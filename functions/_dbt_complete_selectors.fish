function _dbt_complete_selectors --description "Provide YAML selector completions"
    if not _dbt_get_project_root >/dev/null 2>&1
        return 1
    end

    if not _dbt_parse_manifest >/dev/null 2>&1
        return 1
    end

    _dbt_extract_selectors
end
