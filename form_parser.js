(function() {
  var $r, TEST_ENTRY, TEST_FORM;
  require("./regex_builder.rb");
  TEST_FORM = "form_test.yaml";
  TEST_ENTRY = "example_entry.txt";
  $r = get_regex_entries(get_form_keys(TEST_FORM));
}).call(this);
