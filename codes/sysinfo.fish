function sysinfo
    #Decide initd type
    set -x sys_initd (ps -p 1 -o comm=)
    #Decide virtual type
    #Try to detect if it's a container
    if ps -ef | grep '\['
        set -x sys_virt container
    else
        #Try to set virt platform
        set -x sys_virt (lscpu | string match -e 'Hypervisor vendor' | string split -f2 : | string trim)
    end
    #Detect if zram is available
    if string match -eq zram (lsmod)
        set -x sys_zram_module true
        #Detect if zram is enabled
        if string match -eq zram (cat /proc/swaps )
            set -x sys_zram_enable true
        end
        #Detect available algo
        set -x sys_zram_algo (cat /sys/block/zram0/comp_algorithm)
    end
    #Cpu related
    set -x sys_cpu_governors (cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors)
    set -x sys_cpu_threads (nproc)
end
