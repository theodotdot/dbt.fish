function _dbt_extract_hardcoded --description "Return hardcoded dbt selectors"
    set -l prefix $argv[1]

    echo "$prefix"config.materialized:view
    echo "$prefix"config.materialized:table
    echo "$prefix"config.materialized:incremental
    echo "$prefix"config.materialized:snapshot
    echo "$prefix"state:new
    echo "$prefix"state:modified
    echo "$prefix"result:error
    echo "$prefix"result:fail
end
