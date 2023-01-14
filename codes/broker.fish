function broker
    logger 0 'Daemon loading'
    echo $fish_pid >/tmp/SakuraD.lock
    loadconf
    if $sys_zram_module
        if $sys_zram_enable
        else
            zram_switch
        end
    else
        logger 4 'Zram module is not available in this system'
    end

end