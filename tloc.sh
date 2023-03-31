#!/bin/bash

# current directory
path='../'$(basename "$PWD")'/*'

# max depth of folder
max_depth=$(find $path -type d | awk -F"$path" 'NF > max {max = NF} END {print max}')
echo $max_depth

# count number of lines in each directory 
# write report to text file
for dir_name in $(find $path -maxdepth $max_depth -type d); do
  if [ -d "$dir_name" ]; then
    echo "$dir_name"
    file_name=$(basename $dir_name)
    file_name+='-tloc.txt'
    $(cloc --by-file-by-lang $dir_name > $file_name)
    $(mv $file_name $dir_name)

  fi
done
