#!/usr/bin/env bats

EXPECTED_CLIENT_MARKDOWN_FILE=$PWD/clients/example_client.markdown
FIXTURES_PATH=$PWD/tests/fixtures

load_test_data() {
  cp $FIXTURES_PATH/example_client.yaml ./clients/example_client.yaml
}

remove_test_data() {
  rm -r ./clients/example_client.*
}

setup() {
  example_client="Example Client"
  load_test_data
  example_markdown=$(cat $FIXTURES_PATH/example_client.md)
}

teardown() {
  remove_test_data
}

@test "YAML correctly renders to markdown." {
  run bin/generate_markdown.sh "$example_client"
  >&2 echo "Generate markdown test failed with status $status: $output"
  [ "$status" -eq 0 ]

  run test -f "$EXPECTED_CLIENT_MARKDOWN_FILE"
  >&2 echo "Expected markdown file test failed with status $status: $output"
  [ "$status" -eq 0 ]

  run cat "$EXPECTED_CLIENT_MARKDOWN_FILE"
  >&2 echo "The generated markdown differs from what we expected:"
  diff <(echo "$expected_markdown") <(echo "$output")
  [ "$output" == "$EXPECTED_CLIENT_MARKDOWN_FILE" ]

}
