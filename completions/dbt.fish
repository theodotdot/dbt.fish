# Disable file completion by default
complete -c dbt -f

# Global options (available for all subcommands)
complete -c dbt -l help -s h -d "Show help message"
complete -c dbt -l version -s v -d "Show version information"
complete -c dbt -l debug -d "Display debug logging"
complete -c dbt -l log-format -d "Specify log format" -xa "text json default"
complete -c dbt -l no-write-json -d "Prevent writing JSON artifacts"
complete -c dbt -l use-colors -d "Colorize logs"
complete -c dbt -l printer-width -d "Set output width" -x
complete -c dbt -l warn-error -d "Convert warnings to errors"
complete -c dbt -l no-version-check -d "Skip version check"

# Profile/target options
complete -c dbt -l profile -d "Profile to use" -x
complete -c dbt -l target -s t -d "Target to use" -x
complete -c dbt -l profiles-dir -d "Profiles directory" -r
complete -c dbt -l project-dir -d "Project directory" -r

# Subcommands
complete -c dbt -n __fish_use_subcommand -a run -d "Execute models"
complete -c dbt -n __fish_use_subcommand -a test -d "Execute tests"
complete -c dbt -n __fish_use_subcommand -a build -d "Run models and tests"
complete -c dbt -n __fish_use_subcommand -a seed -d "Load seed files"
complete -c dbt -n __fish_use_subcommand -a snapshot -d "Execute snapshots"
complete -c dbt -n __fish_use_subcommand -a compile -d "Compile models"
complete -c dbt -n __fish_use_subcommand -a parse -d "Parse project"
complete -c dbt -n __fish_use_subcommand -a docs -d "Generate documentation"
complete -c dbt -n __fish_use_subcommand -a source -d "Source commands"
complete -c dbt -n __fish_use_subcommand -a init -d "Initialize project"
complete -c dbt -n __fish_use_subcommand -a debug -d "Debug connection"
complete -c dbt -n __fish_use_subcommand -a deps -d "Install dependencies"
complete -c dbt -n __fish_use_subcommand -a clean -d "Clean artifacts"
complete -c dbt -n __fish_use_subcommand -a list -d "List resources"
complete -c dbt -n __fish_use_subcommand -a ls -d "List resources (alias)"
complete -c dbt -n __fish_use_subcommand -a retry -d "Retry failed nodes"
complete -c dbt -n __fish_use_subcommand -a show -d "Show compiled SQL"
complete -c dbt -n __fish_use_subcommand -a clone -d "Clone models"

# Selector flags for run, test, build, compile, list, etc.
set -l selector_commands run test build compile seed snapshot list ls show clone retry

# --select/-s flag with model completions
for cmd in $selector_commands
    # Dynamic completions when typing after selector flags
    complete -c dbt -n "__fish_seen_subcommand_from $cmd; and _dbt_needs_selector" -f -a "(_dbt_complete_models)"
    # Flag definitions
    complete -c dbt -n "__fish_seen_subcommand_from $cmd" -l select -s s -d "Specify resources to include" -f -a "(_dbt_complete_models)"
    complete -c dbt -n "__fish_seen_subcommand_from $cmd" -l models -s m -d "Specify models to include" -f -a "(_dbt_complete_models)"
    complete -c dbt -n "__fish_seen_subcommand_from $cmd" -l exclude -d "Specify resources to exclude" -f -a "(_dbt_complete_models)"
    complete -c dbt -n "__fish_seen_subcommand_from $cmd" -l selector -d "Use predefined selector" -f -a "(_dbt_complete_selectors)"
end

# run command specific options
complete -c dbt -n "__fish_seen_subcommand_from run" -l full-refresh -d "Full refresh incremental models"
complete -c dbt -n "__fish_seen_subcommand_from run" -l fail-fast -s x -d "Stop on first failure"
complete -c dbt -n "__fish_seen_subcommand_from run" -l threads -d "Number of threads" -x

# test command specific options
complete -c dbt -n "__fish_seen_subcommand_from test" -l store-failures -d "Store test failures in database"
complete -c dbt -n "__fish_seen_subcommand_from test" -l indirect-selection -d "Indirect selection mode" -xa "eager cautious buildable empty"

# build command specific options
complete -c dbt -n "__fish_seen_subcommand_from build" -l full-refresh -d "Full refresh incremental models"
complete -c dbt -n "__fish_seen_subcommand_from build" -l fail-fast -s x -d "Stop on first failure"
complete -c dbt -n "__fish_seen_subcommand_from build" -l store-failures -d "Store test failures in database"

# seed command specific options
complete -c dbt -n "__fish_seen_subcommand_from seed" -l full-refresh -d "Drop and recreate seed tables"
complete -c dbt -n "__fish_seen_subcommand_from seed" -l show -d "Show sample of loaded data"

# snapshot command specific options
complete -c dbt -n "__fish_seen_subcommand_from snapshot" -l threads -d "Number of threads" -x

# docs subcommands
complete -c dbt -n "__fish_seen_subcommand_from docs; and not __fish_seen_subcommand_from generate serve" -a generate -d "Generate documentation"
complete -c dbt -n "__fish_seen_subcommand_from docs; and not __fish_seen_subcommand_from generate serve" -a serve -d "Serve documentation"
complete -c dbt -n "__fish_seen_subcommand_from docs; and __fish_seen_subcommand_from serve" -l port -d "Port for docs server" -x
complete -c dbt -n "__fish_seen_subcommand_from docs; and __fish_seen_subcommand_from serve" -l no-browser -d "Don't open browser"

# source subcommands
complete -c dbt -n "__fish_seen_subcommand_from source; and not __fish_seen_subcommand_from freshness snapshot-freshness" -a freshness -d "Check source freshness"
complete -c dbt -n "__fish_seen_subcommand_from source; and not __fish_seen_subcommand_from freshness snapshot-freshness" -a snapshot-freshness -d "Check source freshness (deprecated)"

# list/ls command specific options
complete -c dbt -n "__fish_seen_subcommand_from list ls" -l resource-type -d "Resource type to list" -xa "model test source snapshot seed analysis metric exposure"
complete -c dbt -n "__fish_seen_subcommand_from list ls" -l output -d "Output format" -xa "json name path selector"
complete -c dbt -n "__fish_seen_subcommand_from list ls" -l output-keys -d "Output keys for json format" -x

# show command specific options
complete -c dbt -n "__fish_seen_subcommand_from show" -l inline -d "Pass SQL inline" -x
complete -c dbt -n "__fish_seen_subcommand_from show" -l limit -d "Limit number of rows" -x

# clone command specific options
complete -c dbt -n "__fish_seen_subcommand_from clone" -l state -d "State directory for comparison" -r

# State comparison flags (for run, test, build, list, etc.)
for cmd in $selector_commands
    complete -c dbt -n "__fish_seen_subcommand_from $cmd" -l state -d "State directory for comparison" -r
    complete -c dbt -n "__fish_seen_subcommand_from $cmd" -l defer -d "Defer to state for unselected resources"
    complete -c dbt -n "__fish_seen_subcommand_from $cmd" -l no-defer -d "Don't defer to state"
    complete -c dbt -n "__fish_seen_subcommand_from $cmd" -l favor-state -d "Favor state for modified resources"
end

# Vars flag (available for most commands)
complete -c dbt -l vars -d "Supply variables as YAML string" -x

# Cache-related flags
complete -c dbt -l no-populate-cache -d "Don't populate cache"
