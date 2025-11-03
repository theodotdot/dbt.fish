function _dbt_get_project_root --description "Find dbt project root directory"
    # Check if DBT_PROJECT_DIR is set and valid
    if set -q DBT_PROJECT_DIR
        and test -f "$DBT_PROJECT_DIR/dbt_project.yml"
        echo $DBT_PROJECT_DIR
        return 0
    end

    # Fall back to searching from current directory
    set -l current_dir (pwd)
    while test "$current_dir" != /
        if test -f "$current_dir/dbt_project.yml"
            echo $current_dir
            return 0
        end
        set current_dir (dirname $current_dir)
    end
    return 1
end
