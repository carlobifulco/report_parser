#### Reads form and extracts parsing structure; below is an example of the yaml data structure
# form:  
  
# \- Specimen  
# \-  
#  \- "Specimen type:  [Excision without wire-guided localization| Excision with wire-guided localization | Simple mastectomy (including nipple and skin) | Simple mastectomy (including nipple and skin) and axillary dissection|Modified radical mastectomy| Nipple sparing mastectomy] $"  
#  \- "Specimen size (for specimens less than total mastectomy):  $ x $ x $ [cm|mm] [,see comment]"  

require "yaml"


$form=(YAML.load (File.read "form_test.yaml"))["form"]
PATTERN=/\A(.+?):/


# in 
#\- Cats  
#\-  
# \- "mors: hkjhkjh"  
# \- "death: jkhkjh"  
# \- "steve: khkjhkj"  
# out
#["mors: hkjhkjh", "death: jkhkjh", "steve: khkjhkj"]
def select_keys_entries yaml_array
  e=0
  selected=[]
  for i in yaml_array
    selected<<i if (e%2==1)
    e+=1
  end
  return selected.flatten
end

# in keys:values list
# out keys list
def parse_keys string_array
  matches=[]
  10.times {|x| puts "**************"}
  for i in string_array
    match=(i.match PATTERN)
    if match and match.length>1
      matches<<match[1] if match.length>1
    else
      puts "no match --> #{i}" 
    end
  end
  10.times {|x| puts "**************"}
  matches
end


# extract keys from YAML file
def get_form_keys form_file_name
  form_yaml=(YAML.load (File.read form_file_name))["form"]
  parse_keys (select_keys_entries  form_yaml)
end

#escape regex special symbols in match text string
def escape_regex_symbols text_string
  special_symbols=[ "^","$",".","(",")","{","}","?","*","+","/"]
  special_symbols.each do |s|
    text_string.sub! s,"\\\\#{s}"
  end 
  text_string+':(.*)'
end

# converts keys present in form into regex matching patterns
def get_regex_entries(form_keys)
  regex_entries=form_keys.collect {|form_key| escape_regex_symbols form_key}
  return [form_keys, regex_entries]
end

#prints test if run from command line
puts get_regex_entries(get_form_keys "form_test.yaml") if (__FILE__ == $0)


