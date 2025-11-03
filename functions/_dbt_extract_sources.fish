function _dbt_extract_sources --description "Extract source selectors from manifest"
    set -l manifest_path (_dbt_parse_manifest)
    if test $status -ne 0
        return 1
    end

    set -l prefix $argv[1]

    # Extract both source:source_name and source:source_name.table_name
    jq -r --arg prefix "$prefix" '
        .sources | 
        to_entries[] | 
        select(.value.resource_type == "source") |
        "\($prefix)source:\(.value.source_name)",
        "\($prefix)source:\(.value.source_name).\(.value.name)"
    ' $manifest_path 2>/dev/null | sort -u
end
