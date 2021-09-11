
echo

# tests collection
# TODO
it "should be able to collect tests from a single file"
  assert() {
    cmd() { ../bash_describe tests_collection/test_success.sh; }
    run cmd
    exit_code_is 0 && output_contains "it should work well" && output_contains "it should work too"
  }
ti

it "should be able to collect tests from multiple files"
  assert() {
    cmd() { ../bash_describe tests_collection/test_success.sh tests_collection/test_fail.sh; }
    run cmd
    output_contains "it should work well" && \
      output_contains "it should work too" && \
      output_contains "it should fail"
      # exit_code_is 1  # TODO
  }
ti

it "should be able to collect tests from a folder"
  assert() {
    cmd() { ../bash_describe tests_collection; }
    run cmd
    output_contains "it should work well" && \
      output_contains "it should work too" && \
      output_contains "it should fail"
      # exit_code_is 1  # TODO
  }
ti

it "should skip files with wrong format from a folder"
  assert() {
    cmd() { ../bash_describe tests_collection; }
    run cmd
    output_contains "it should work well" && \
      output_contains "it should work too" && \
      output_contains "it should fail" && \
      ! output_contains "it should skip"
      # exit_code_is 1  # TODO
  }
ti

it "should run tests from a wrong name format file if expressly told to"
  assert() {
    cmd() { ../bash_describe tests_collection/t_skip.sh; }
    run cmd
    output_contains "it should skip" && \
      exit_code_is 0
  }
ti

it "should complain if a wrong path is given as argument"
  assert() {
    cmd() { ../bash_describe tests_collection/nothere; }
    run cmd
    exit_code_is 1 && output_contains "is not a valid folder or file"
  }
ti

# TODO
# it "should complain if no test is collected"
  # assert() {
    # cmd() { ../bash_describe tests_collection/empty; }
    # run cmd
    # exit_code_is 1
  # }
# ti

echo

# tests format
# TODO make poorly formatted test SKIP, not die
it "should die with a missing it"
  assert() {
    cmd() { ../bash_describe test_format/missing_it; }
    run cmd
    exit_code_is 1 && output_contains "ERR: \`ti\` called without a matching \`it\`"
  }
ti

it "should die with a missing ti"
  assert() {
    cmd() { ../bash_describe test_format/missing_ti; }
    run cmd
    exit_code_is 1 && output_contains "ERR: \`it\` called, but a previous \`ti\` seems missing"
  }
ti

it "should die with a missing assert function"
  assert() {
    cmd() { ../bash_describe test_format/missing_assert; }
    run cmd
    exit_code_is 1 && output_contains "ERR: no assert function was found. Define one"
  }
ti

it "should die with an assert function defined outside it/ti blocks"
  assert() {
    cmd() { ../bash_describe test_format/defined_assert; }
    run cmd
    exit_code_is 1 && output_contains "a function called assert was already defined:"
  }
ti

it "should take the name from it"
  assert() {
    cmd() { ../bash_describe test_format/given_name; }
    run cmd
    exit_code_is 0 && output_contains "it has a name"
  }
ti

it "should have a default name"
  assert() {
    cmd() { ../bash_describe test_format/no_name; }
    run cmd
    exit_code_is 0 && output_contains "it should work"
  }
ti


# run and assertions
# TODO
