function sysinfo
    #Decide initd type
    set -xg sys_initd (ps -p 1 -o comm=)
    #Decide virtual type
    #Try to detect if it's a container
    if ps -ef | string match -eq '\['
        set -xg sys_virt container
    else
        #Try to set virt platform
        set -xg sys_virt (lscpu | string match -e 'Hypervisor vendor' | string split -f2 : | string trim)
        #Fallback to baremetal
        if test -z "$sys_virt"
            set -xg sys_virt baremetal
        end
    end
    #Detect if zram is available
    if string match -eq zram (lsmod)
        set -xg sys_zram_module true
        #Detect if zram is enabled
        if string match -eq zram (cat /proc/swaps )
            set -xg sys_zram_enable true
        end
        #Detect available algo
        set -xg sys_zram_algo_ava (cat /sys/block/zram0/comp_algorithm)
    end
    #Cpu related
    set -xg sys_cpu_governors_ava (cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors)
    set -xg sys_cpu_threads (nproc)
    #Network related
    set -xg sys_tcp_congestion_control_ava (cat /proc/sys/net/ipv4/tcp_available_congestion_control)
    #Print or not
    if test "$argv[1]" = "print"
        env | string match -e 'sys_'
    end
end
