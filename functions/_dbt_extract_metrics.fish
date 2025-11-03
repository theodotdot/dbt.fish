function _dbt_extract_metrics --description "Extract metric selectors from manifest"
    set -l manifest_path (_dbt_parse_manifest)
    if test $status -ne 0
        return 1
    end

    set -l prefix $argv[1]

    jq -r --arg prefix "$prefix" '
        .metrics | 
        to_entries[] | 
        select(.value.resource_type == "metric") |
        "\($prefix)metric:\(.value.name)"
    ' $manifest_path 2>/dev/null
end
