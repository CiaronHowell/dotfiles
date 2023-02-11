
function note -d "Create a Markdown file within a notes folder"
    set --local note_home "$HOME/OneDrive - Science and Technology Facilities Council/Notes"
    
    vim "$note_home/$argv[1].md"

    # TODO: Add a -t flag for temp
end

