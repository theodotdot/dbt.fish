function _dbt_extract_selectors --description "Extract YAML selectors from manifest"
    set -l manifest_path (_dbt_parse_manifest)
    if test $status -ne 0
        return 1
    end

    jq -r '
        .selectors | 
        to_entries[]? | 
        .value.name
    ' $manifest_path 2>/dev/null
end
