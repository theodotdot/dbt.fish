function _dbt_get_manifest_path --description "Get path to dbt manifest.json"
    set -l project_root (_dbt_get_project_root)
    if test $status -ne 0
        return 1
    end

    # Check for custom manifest path from environment
    if test -n "$DBT_MANIFEST_PATH"
        set -l custom_manifest "$DBT_MANIFEST_PATH/manifest.json"
        if test -f "$custom_manifest"
            echo $custom_manifest
            return 0
        end
    end

    # Default manifest location
    set -l default_manifest "$project_root/target/manifest.json"
    if test -f "$default_manifest"
        echo $default_manifest
        return 0
    end

    return 1
end

