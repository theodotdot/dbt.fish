function _dbt_handle_prefix --description "Detect and return prefix from current token"
    set -l current_token (commandline -ct)

    # Check for + or @ prefix
    if string match -qr '^[+@]' -- $current_token
        string sub -l 1 -- $current_token
        return 0
    end

    # No prefix
    echo ""
    return 0
end
