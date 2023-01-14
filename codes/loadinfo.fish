function loadinfo
    # dynamic loadavg info
    # 0 = spare
    # 1 = intensive
    # 3 = medium
    # 4 = busy

    #calc loadavg
    set -xg load_avg (math "$(cat /proc/loadavg | string split -f1 ' ')/$sys_cpu_threads*100")
    #status
    if test $load_avg -ge 75
        set -xg load_stat 4
    else
        if test $load_avg -ge 50
            set -xg load_stat 3
        else
            if test $load_avg -ge 25
                set -xg load_stat 2
            else
                set -xg load_stat 1
            end
        end
    end
    #Print or not
    if test "$argv[1]" = print
        env | string match -e load_
    end
end
