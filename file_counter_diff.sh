
#!/bin/bash
# return non zero exit status 
set -e

entity='file1'
messager_send="/home/push_to_messanger_method.sh"

# tr covert lower case letter to uppercase
message_entity=$(echo $entity | tr '[:lower:]' '[:upper:]')

# get ltr and dbltr date
ltr=$(wget --quiet "http://date_link" -O- | grep --only-matching --perl-regexp "(\d+\.){2}\d+" | tr '.' '-')
dbltr=$(wget --quiet "http://date_link" -O- | grep --only-matching --perl-regexp "(\d+\.){2}\d+" | tr '.' '-')

# get file path
src_fld_ltr="/data/$entity/$entity-$ltr/"
src_fld_dbltr="/data/$entity/$entity-$dbltr/"

# field counter
files_fld_ltr=$(find "$src_fld_ltr" -maxdepth 1 -type f | wc --lines)
files_fld_dbltr=$(find "$src_fld_dbltr" -maxdepth 1 -type f | wc --lines)

# compare results
if [ "$files_fld_ltr" -lt "$files_fld_dbltr" ]; then
  $messager_send --channel 'test' --username  "$HOSTNAME" --emoji ':red_circle:' --header "$message_entity" --text "$message_entity data is missing for $ltr <!here>"
else
  $messager_send --channel 'test' --username  "$HOSTNAME" --emoji ':large_green_circle:' --header "$message_entity" --text "$message_entity data has successfully copied for $ltr"
fi
