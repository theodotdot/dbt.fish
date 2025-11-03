# Only enable dbt completions when in a dbt project directory
# This prevents unnecessary manifest parsing when not working with dbt

function _dbt_completion_init --on-variable PWD
    # Check if we're in a dbt project
    if _dbt_get_project_root >/dev/null 2>&1
        # We're in a dbt project, completions are already loaded via completions/dbt.fish
        # This function just ensures we're in the right context
        return 0
    end
end

# Run once on shell startup
_dbt_completion_init
