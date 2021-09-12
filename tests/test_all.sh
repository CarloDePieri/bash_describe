# constants
test_cases="test_cases"
collection="$test_cases/tests_collection"
format="$test_cases/tests_format"

# helpers
bd() {
  # Convenient way to run bash_describe against one or multiple target with the run helper function
  targets="$@"
  cmd() { ../bash_describe $targets; }
  run cmd
}

# tests collection

# TODO
it "should be able to collect tests from a single file"
  assert() {
    bd $collection/test_success.sh
    exit_code_is 0 && output_contains "it should work well" && output_contains "it should work too"
  }
ti

it "should be able to collect tests from multiple files"
  assert() {
    bd $collection/test_success.sh $collection/test_fail.sh
    output_contains "it should work well" && \
      output_contains "it should work too" && \
      output_contains "it should fail"
      # exit_code_is 1  # TODO
  }
ti

it "should be able to collect tests from a folder"
  assert() {
    bd $collection
    output_contains "it should work well" && \
      output_contains "it should work too" && \
      output_contains "it should fail"
      # exit_code_is 1  # TODO
  }
ti

it "should skip files with wrong format from a folder"
  assert() {
    bd $collection
    output_contains "it should work well" && \
      output_contains "it should work too" && \
      output_contains "it should fail" && \
      ! output_contains "it should skip"
      # exit_code_is 1  # TODO
  }
ti

it "should run tests from a wrong name format file if expressly told to"
  assert() {
    bd $collection/t_skip.sh
    output_contains "it should skip" && \
      exit_code_is 0
  }
ti

it "should complain if a wrong path is given as argument"
  assert() {
    bd $collection/notthere
    exit_code_is 1 && output_contains "is not a valid folder or file"
  }
ti

# TODO
# it "should complain if no test is collected"
  # assert() {
    # bd $collection/empty
    # exit_code_is 1
  # }
# ti

echo

# tests format
# TODO make poorly formatted test SKIP, not die ?
it "should die with a missing it"
  assert() {
    bd $format/missing_it
    exit_code_is 1 && output_contains "ERR: \`ti\` called without a matching \`it\`"
  }
ti

it "should die with a missing ti"
  assert() {
    bd $format/missing_ti
    exit_code_is 1 && output_contains "ERR: \`it\` called, but a previous \`ti\` seems missing"
  }
ti

it "should die with a missing assert function"
  assert() {
    bd $format/missing_assert
    exit_code_is 1 && output_contains "ERR: no assert function was found. Define one"
  }
ti

it "should die with an assert function defined outside it/ti blocks"
  assert() {
    bd $format/defined_assert
    exit_code_is 1 && output_contains "a function called assert was already defined:"
  }
ti

it "should take the name from it"
  assert() {
    bd $format/given_name
    exit_code_is 0 && output_contains "it has a name"
  }
ti

it "should have a default name"
  assert() {
    bd $format/no_name
    exit_code_is 0 && output_contains "it should work"
  }
ti

it "should die before any test is executed if a format error is found"
  assert() {
    bd $format/delayed
    exit_code_is 1 && \
      output_contains "ERR: \`ti\` called without a matching \`it\`" && \
      ! output_contains "it should work"
  }
ti

# run and assertions
# TODO
