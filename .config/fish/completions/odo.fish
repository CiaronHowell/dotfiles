
function __complete_odo
    set -lx COMP_LINE (string join ' ' (commandline -o))
    test (commandline -ct) = ""
    and set COMP_LINE "$COMP_LINE "
    /usr/local/bin/odo
end
complete -c odo -a "(__complete_odo)"

