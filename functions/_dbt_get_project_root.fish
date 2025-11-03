function _dbt_get_project_root --description "Find dbt project root directory"
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
