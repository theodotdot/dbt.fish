#!/usr/bin/env fish

# Get the directory where this script is located
set -l script_dir (dirname (status --current-filename))

# Source all functions from the functions directory
echo "Sourcing functions..."
for func_file in functions/_dbt_*.fish
    source $func_file
    echo "  Sourced: "(basename $func_file)
end
echo

# Save current directory
set -l original_dir (pwd)

# Navigate to test dbt project
set -l test_project "$script_dir/jaffle_shop_duckdb"

if not test -d "$test_project"
    echo "Error: Test project not found at $test_project"
    exit 1
end

echo "Navigating to test project: $test_project"
cd $test_project
echo

# Test 1: _dbt_get_project_root
echo "=== Test 1: _dbt_get_project_root ==="
set -l project_root (_dbt_get_project_root)
set -l status1 $status
echo "Result: $project_root"
echo "Status: $status1"
if test $status1 -eq 0
    echo "✓ PASS: Found project root"
else
    echo "✗ FAIL: Could not find project root"
end
echo

# Test 2: _dbt_get_manifest_path
echo "=== Test 2: _dbt_get_manifest_path ==="
set -l manifest_path (_dbt_get_manifest_path)
set -l status2 $status
echo "Result: $manifest_path"
echo "Status: $status2"
if test $status2 -eq 0
    echo "✓ PASS: Found manifest path"
else
    echo "✗ FAIL: Could not find manifest path"
end
echo

# Test 3: _dbt_parse_manifest
echo "=== Test 3: _dbt_parse_manifest ==="
set -l parsed_manifest (_dbt_parse_manifest)
set -l status3 $status
echo "Result: $parsed_manifest"
echo "Status: $status3"
if test $status3 -eq 0
    echo "✓ PASS: Manifest is valid"
else
    echo "✗ FAIL: Could not parse manifest"
end
echo

# Test 4: Test from subdirectory (should still find project root)
echo "=== Test 4: Finding project root from subdirectory ==="
if test -d models
    cd models
else
    mkdir -p models
    cd models
end
set -l project_root_subdir (_dbt_get_project_root)
set -l status4 $status
echo "Current dir: "(pwd)
echo "Found root: $project_root_subdir"
echo "Status: $status4"
if test $status4 -eq 0
    echo "✓ PASS: Found project root from subdirectory"
else
    echo "✗ FAIL: Could not find project root from subdirectory"
end
echo

# Test 5: _dbt_extract_models
echo "=== Test 5: _dbt_extract_models ==="
set -l models (_dbt_extract_models "")
set -l status5 $status
echo "Sample output (first 3):"
echo "$models" | head -n 3
echo "Total models: "(echo "$models" | wc -l)
if test $status5 -eq 0 -a -n "$models"
    echo "✓ PASS: Extracted models"
else
    echo "✗ FAIL: Could not extract models"
end
echo

# Test 6: _dbt_extract_models with prefix
echo "=== Test 6: _dbt_extract_models with + prefix ==="
set -l models_prefix (_dbt_extract_models "+")
set -l status6 $status
echo "Sample output (first 3):"
echo "$models_prefix" | head -n 3
if test $status6 -eq 0 -a -n "$models_prefix"
    echo "✓ PASS: Extracted models with prefix"
else
    echo "✗ FAIL: Could not extract models with prefix"
end
echo

# Test 7: _dbt_extract_tags
echo "=== Test 7: _dbt_extract_tags ==="
set -l tags (_dbt_extract_tags "")
set -l status7 $status
echo "Tags found:"
echo "$tags"
if test $status7 -eq 0
    echo "✓ PASS: Tag extraction succeeded"
else
    echo "✗ FAIL: Tag extraction failed"
end
echo

# Test 8: _dbt_extract_sources
echo "=== Test 8: _dbt_extract_sources ==="
set -l sources (_dbt_extract_sources "")
set -l status8 $status
echo "Sources found:"
echo "$sources"
if test $status8 -eq 0
    echo "✓ PASS: Source extraction succeeded"
else
    echo "✗ FAIL: Source extraction failed"
end
echo

# Test 9: _dbt_extract_exposures
echo "=== Test 9: _dbt_extract_exposures ==="
set -l exposures (_dbt_extract_exposures "")
set -l status9 $status
echo "Exposures found:"
echo "$exposures"
if test $status9 -eq 0
    echo "✓ PASS: Exposure extraction succeeded"
else
    echo "✗ FAIL: Exposure extraction failed"
end
echo

# Test 10: _dbt_extract_metrics
echo "=== Test 10: _dbt_extract_metrics ==="
set -l metrics (_dbt_extract_metrics "")
set -l status10 $status
echo "Metrics found:"
echo "$metrics"
if test $status10 -eq 0
    echo "✓ PASS: Metric extraction succeeded"
else
    echo "✗ FAIL: Metric extraction failed"
end
echo

# Test 11: _dbt_extract_fqns
echo "=== Test 11: _dbt_extract_fqns ==="
set -l fqns (_dbt_extract_fqns "")
set -l status11 $status
echo "Sample FQNs (first 5):"
echo "$fqns" | head -n 5
if test $status11 -eq 0
    echo "✓ PASS: FQN extraction succeeded"
else
    echo "✗ FAIL: FQN extraction failed"
end
echo

# Test 12: _dbt_extract_selectors
echo "=== Test 12: _dbt_extract_selectors ==="
set -l selectors (_dbt_extract_selectors)
set -l status12 $status
echo "YAML selectors found:"
echo "$selectors"
if test $status12 -eq 0
    echo "✓ PASS: Selector extraction succeeded"
else
    echo "✗ FAIL: Selector extraction failed"
end
echo

# Test 13: _dbt_extract_hardcoded
echo "=== Test 13: _dbt_extract_hardcoded ==="
set -l hardcoded (_dbt_extract_hardcoded "")
set -l status13 $status
echo "Hardcoded selectors:"
echo "$hardcoded"
if test $status13 -eq 0 -a -n "$hardcoded"
    echo "✓ PASS: Hardcoded selectors returned"
else
    echo "✗ FAIL: Hardcoded selectors failed"
end
echo

# Test 14: _dbt_get_all_selectors
echo "=== Test 14: _dbt_get_all_selectors ==="
set -l all_selectors (_dbt_get_all_selectors "")
set -l status14 $status
echo "Total selectors: "(echo "$all_selectors" | wc -l)
echo "Sample (first 5):"
echo "$all_selectors" | head -n 5
if test $status14 -eq 0 -a -n "$all_selectors"
    echo "✓ PASS: All selectors retrieved"
else
    echo "✗ FAIL: Could not retrieve all selectors"
end
echo

# Test 15: _dbt_get_all_selectors with prefix
echo "=== Test 15: _dbt_get_all_selectors with + prefix ==="
set -l all_selectors_prefix (_dbt_get_all_selectors "+")
set -l status15 $status
echo "Sample (first 3):"
echo "$all_selectors_prefix" | head -n 3
# Check that results have + prefix
set -l first_result (echo "$all_selectors_prefix" | head -n 1)
set -l has_prefix (string match -r '^\+' -- $first_result)
if test $status15 -eq 0 -a -n "$has_prefix"
    echo "✓ PASS: All selectors with prefix retrieved"
else
    echo "✗ FAIL: Could not retrieve selectors with prefix"
end
echo

# Test 16: _dbt_complete_selectors
echo "=== Test 16: _dbt_complete_selectors ==="
set -l yaml_selectors (_dbt_complete_selectors)
set -l status16 $status
echo "YAML selectors:"
echo "$yaml_selectors"
if test $status16 -eq 0
    echo "✓ PASS: YAML selector completions generated"
else
    echo "✗ FAIL: Could not generate YAML selector completions"
end
echo

# Return to original directory
cd $original_dir

# Summary
echo "=== Test Summary ==="
set -l total_tests 16
set -l passed_tests 0
test $status1 -eq 0; and set passed_tests (math $passed_tests + 1)
test $status2 -eq 0; and set passed_tests (math $passed_tests + 1)
test $status3 -eq 0; and set passed_tests (math $passed_tests + 1)
test $status4 -eq 0; and set passed_tests (math $passed_tests + 1)
test $status5 -eq 0 -a -n "$models"; and set passed_tests (math $passed_tests + 1)
test $status6 -eq 0 -a -n "$models_prefix"; and set passed_tests (math $passed_tests + 1)
test $status7 -eq 0; and set passed_tests (math $passed_tests + 1)
test $status8 -eq 0; and set passed_tests (math $passed_tests + 1)
test $status9 -eq 0; and set passed_tests (math $passed_tests + 1)
test $status10 -eq 0; and set passed_tests (math $passed_tests + 1)
test $status11 -eq 0; and set passed_tests (math $passed_tests + 1)
test $status12 -eq 0; and set passed_tests (math $passed_tests + 1)
test $status13 -eq 0 -a -n "$hardcoded"; and set passed_tests (math $passed_tests + 1)
test $status14 -eq 0 -a -n "$all_selectors"; and set passed_tests (math $passed_tests + 1)
test $status15 -eq 0 -a -n "$has_prefix"; and set passed_tests (math $passed_tests + 1)
test $status16 -eq 0; and set passed_tests (math $passed_tests + 1)

echo "Passed: $passed_tests/$total_tests"
echo "(3 interactive tests skipped - will be tested during actual usage)"
if test $passed_tests -eq $total_tests
    echo "✓ All testable functions passed!"
    exit 0
else
    echo "✗ Some tests failed"
    exit 1
end
