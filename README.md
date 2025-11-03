# dbt-completion

Fish shell completions for [dbt (data build tool)](https://www.getdbt.com/) based on the [dbt-completion.bash](https://github.com/dbt-labs/dbt-completion.bash) project.

TAB to trigger fish native completion, CTRL+D to trigger fzf.

## Installation

Install with [Fisher](https://github.com/jorgebucaran/fisher):

```fish
fisher install theodotdot/dbt-completion
```

# Features

Dynamic completion loading (only in dbt projects)
Completions for models, sources, tests, metrics, exposures and FQN (fully qualified name).

fzf integration for fuzzy finding
Multi-selection support through fzf

# Requirements

    jq
    Optional: fzf for fuzzy selection

## Configuration

dbt.fish takes advantabe of DBT_PROJECT_DIR and DBT_MANIFEST_PATH if they are set. When working with several dbt repos, direnv is very handy to dynamically load and unload those.

## fzf Integration

Use CTRL + D to trigger fzf if installed. Otherwise TAB completion works with native fish.

# Troubleshooting

Completions not working:
 - issue with the project root (check if you are in the project of if the DBT_PROJECT_DIR variable is correct)
 - issue with the manifest (check if the manifest in available and/or if the DBT_MANIFEST_PATH variable is correct)
 - fzf not triggering (check installation, binding conflicts)
 - anything else?

# Limitations

Requires compiled manifest  
Performance with very large projects is bad as the manifest needs to be parsed  
About half of this has been vibe coded as a weekend project, expect some issues and edge cases but feel free to raise an issue!
