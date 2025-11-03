function _dbt_parse_manifest --description "Parse dbt manifest.json with error handling"
    set -l manifest_path (_dbt_get_manifest_path)
    if test $status -ne 0
        return 1
    end

    # Verify jq is available
    if not command -q jq
        return 1
    end

    # Test if manifest is valid JSON
    if not jq empty $manifest_path 2>/dev/null
        return 1
    end

    echo $manifest_path
    return 0
end

