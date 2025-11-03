function _dbt_complete_models --description "Provide model completions for dbt commands"
    if not _dbt_get_project_root >/dev/null 2>&1
        return 1
    end

    if not _dbt_parse_manifest >/dev/null 2>&1
        return 1
    end

    set -l prefix (_dbt_handle_prefix)
    _dbt_get_all_selectors $prefix
end
