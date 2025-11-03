function _dbt_extract_tags --description "Extract tag selectors from manifest"
    set -l manifest_path (_dbt_parse_manifest)
    if test $status -ne 0
        return 1
    end

    set -l prefix $argv[1]

    jq -r --arg prefix "$prefix" '
        .nodes | 
        to_entries[] | 
        select(.value.resource_type == "model") |
        .value.tags[]? |
        "\($prefix)tag:\(.)"
    ' $manifest_path 2>/dev/null | sort -u
end
