function _dbt_needs_selector --description "Check if current context expects a selector argument"
    set -l tokens (commandline -opc)

    # Flags that expect selectors as their next argument
    set -l selector_flags -s --select -m --models --exclude --selector

    # Check if the last token is a selector flag
    if test (count $tokens) -gt 0
        set -l last_token $tokens[-1]
        if contains -- $last_token $selector_flags
            return 0
        end
    end

    return 1
end
