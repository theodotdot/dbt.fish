#!/usr/bin/env fish

source tests/test_helpers.fish

function test_extraction --description "Test JSON extraction functions"
    echo "=== Extraction Tests ==="

    set -l passed 0
    set -l total 0

    # Test models extraction
    echo "Test: Extract models"
    set -l models (_dbt_extract_models "")
    set total (math $total + 1)
    assert_not_empty "$models" "Models extracted"
    and set passed (math $passed + 1)

    # Test models with prefix
    echo "Test: Extract models with + prefix"
    set -l models_prefix (_dbt_extract_models "+")
    set total (math $total + 1)
    assert_not_empty "$models_prefix" "Models with prefix extracted"
    and set passed (math $passed + 1)

    # Test tags extraction
    echo "Test: Extract tags"
    set -l tags (_dbt_extract_tags "")
    set total (math $total + 1)
    # Tags might be empty, so just check if command succeeded
    assert_success $status "Tags extraction succeeded"
    and set passed (math $passed + 1)

    # Test sources extraction
    echo "Test: Extract sources"
    set -l sources (_dbt_extract_sources "")
    set total (math $total + 1)
    assert_success $status "Sources extraction succeeded"
    and set passed (math $passed + 1)

    # Test exposures extraction
    echo "Test: Extract exposures"
    set -l exposures (_dbt_extract_exposures "")
    set total (math $total + 1)
    assert_success $status "Exposures extraction succeeded"
    and set passed (math $passed + 1)

    # Test metrics extraction
    echo "Test: Extract metrics"
    set -l metrics (_dbt_extract_metrics "")
    set total (math $total + 1)
    assert_success $status "Metrics extraction succeeded"
    and set passed (math $passed + 1)

    # Test FQNs extraction
    echo "Test: Extract FQNs"
    set -l fqns (_dbt_extract_fqns "")
    set total (math $total + 1)
    assert_success $status "FQNs extraction succeeded"
    and set passed (math $passed + 1)

    # Test selectors extraction
    echo "Test: Extract YAML selectors"
    set -l selectors (_dbt_extract_selectors)
    set total (math $total + 1)
    assert_success $status "Selectors extraction succeeded"
    and set passed (math $passed + 1)

    # Test hardcoded selectors
    echo "Test: Extract hardcoded selectors"
    set -l hardcoded (_dbt_extract_hardcoded "")
    set total (math $total + 1)
    assert_not_empty "$hardcoded" "Hardcoded selectors returned"
    and set passed (math $passed + 1)

    echo "Extraction Tests: $passed/$total passed"
    echo
    return (math $total - $passed)
end
