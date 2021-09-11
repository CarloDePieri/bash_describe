
echo

# tests collection
# TODO


echo

# tests format
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
