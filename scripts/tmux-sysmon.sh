#!/bin/bash
# tmux 상태바용 시스템 모니터
export LC_ALL=C

# CPU 사용률
cpu=$(top -bn1 | grep "Cpu(s)" | awk '{printf "%.0f", $2+$4}')

# RAM
ram_info=$(free -m | awk '/Mem:/{printf "%d %d", $2, $3}')
total=$(echo "$ram_info" | awk '{print $1}')
used=$(echo "$ram_info" | awk '{print $2}')
if [ "$total" -gt 0 ] 2>/dev/null; then
    ram_pct=$((used * 100 / total))
    ram_used=$(awk "BEGIN{printf \"%.1f\", $used/1024}")
    ram_total=$(awk "BEGIN{printf \"%.1f\", $total/1024}")
else
    ram_pct=0; ram_used="?"; ram_total="?"
fi

# GPU
gpu_str=""
if command -v nvidia-smi &>/dev/null; then
    gpu_info=$(nvidia-smi --query-gpu=utilization.gpu,memory.used,memory.total,temperature.gpu,fan.speed --format=csv,noheader,nounits 2>/dev/null)
    if [ -n "$gpu_info" ]; then
        gpu_util=$(echo "$gpu_info" | awk -F', ' '{print $1}')
        vram_used=$(echo "$gpu_info" | awk -F', ' '{print $2}')
        vram_total=$(echo "$gpu_info" | awk -F', ' '{print $3}')
        gpu_temp=$(echo "$gpu_info" | awk -F', ' '{print $4}')
        fan_speed=$(echo "$gpu_info" | awk -F', ' '{print $5}')
        vram_used_g=$(awk "BEGIN{printf \"%.1f\", $vram_used/1024}")
        vram_total_g=$(awk "BEGIN{printf \"%.0f\", $vram_total/1024}")
        # 팬 H/M/L
        if [ "${fan_speed:-0}" -ge 70 ] 2>/dev/null; then fan_label="H"; fan_color="#f38ba8"
        elif [ "${fan_speed:-0}" -ge 40 ] 2>/dev/null; then fan_label="M"; fan_color="#fab387"
        else fan_label="L"; fan_color="#a6e3a1"; fi
        gpu_str=" #[fg=#a6e3a1]GPU#[fg=#cdd6f4]:${gpu_util}% #[fg=#f9e2af]V#[fg=#cdd6f4]:${vram_used_g}/${vram_total_g}G #[fg=#fab387]${gpu_temp}° #[fg=$fan_color]F#[fg=#cdd6f4]:${fan_label}"
    fi
fi

# CPU 색상
if [ "${cpu:-0}" -ge 80 ] 2>/dev/null; then cpu_color="#f38ba8"
elif [ "${cpu:-0}" -ge 50 ] 2>/dev/null; then cpu_color="#fab387"
else cpu_color="#a6e3a1"; fi

# RAM 색상
if [ "${ram_pct:-0}" -ge 80 ] 2>/dev/null; then ram_color="#f38ba8"
elif [ "${ram_pct:-0}" -ge 50 ] 2>/dev/null; then ram_color="#fab387"
else ram_color="#a6e3a1"; fi

echo "#[fg=$cpu_color]C#[fg=#cdd6f4]:${cpu}% #[fg=$ram_color]R#[fg=#cdd6f4]:${ram_used}/${ram_total}G${gpu_str}"
