set -x prefix [Sakura]
set -x script_location (status filename)
sysinfo
switch $argv[1]
    case ign
        broker $argv[2..-1]
    case sysinfo
        sysinfo print $argv[2..-1]
    case loadinfo
        loadinfo print $argv[2..-1]
    case h help '*'
        help_echo
end
