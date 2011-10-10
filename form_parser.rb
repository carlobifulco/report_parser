####Need to replace stdin args for form and text entry


require "./regex_builder.rb"
require "pp"

# testing
TEST_FORM="form_test.yaml"
TEST_ENTRY="example_entry.txt"


#gets database keys and matching regex in 2 arrays
form_keys,regex_entries=get_regex_entries(get_form_keys TEST_FORM)

#load form
text_entry=File.read TEST_ENTRY

#run each regex and load result in key:value regex_match {}
regex_match={}
counter=0
regex_entries.each do |regex|
    match=(text_entry.match regex)
    if match and match.length>1
      regex_match[form_keys[counter]]=match[1]
    end
    counter+=1
end

#show results if run from command line
pp regex_match if (__FILE__ == $0)


