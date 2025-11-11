function _dbt_get_all_selectors --description "Get all available selectors with optional prefix"
    set -l prefix $argv[1]

    # Combine all selector types
    _dbt_extract_models $prefix
    _dbt_extract_fqns $prefix

    # No big value for those atm and takes a toll on perf when enabled
    #_dbt_extract_hardcoded $prefix
    #_dbt_extract_tags $prefix
    #_dbt_extract_sources $prefix
    #_dbt_extract_exposures $prefix
    #_dbt_extract_metrics $prefix

end
