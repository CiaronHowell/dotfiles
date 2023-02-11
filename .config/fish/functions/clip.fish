function clip
    # Takes first argument given and copies file
    # to clipboard
    cat $argv[1] | pbcopy
end
