function _dbt_fzf_complete --description "Handle TAB completion with fzf for dbt selectors"
    set -l tokens (commandline -opc)
    set -l current_token (commandline -ct)

    # Check if we're in a dbt command that needs selectors
    if test (count $tokens) -eq 0
        or not string match -q dbt -- $tokens[1]
        or not _dbt_needs_selector
        # Fall back to default TAB behavior
        commandline -f complete
        return
    end

    # Check if fzf is available
    if not command -v fzf >/dev/null 2>&1
        commandline -f complete
        return
    end

    # Get completions
    set -l completions (_dbt_complete_models)

    if test (count $completions) -eq 0
        commandline -f complete
        return
    end

    # Launch fzf
    set -l selected (printf '%s\n' $completions | fzf \
        --height=40% \
        --reverse \
        --multi \
        --cycle \
        --query="$current_token")

    # If user selected something, insert it
    if test -n "$selected"
        commandline -t ""
        for item in $selected
            commandline -it -- "$item "
        end
    end

    # Explicitly repaint the prompt
    commandline -f repaint
end
