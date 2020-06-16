#!/bin/bash
#
# this script generates a report of the files on the system that have the setuid permission bit turned on
# it is for the lab1 exercise
# it uses the find command to find files of the right type and with the right permissions, and an error redirect to
# /dev/null so we do not get errors for inaccessible directories and files
# the identified files are sorted by their owner

# Task 1 for the exercise is to modify it to also find and display the setgid files in a second listing
# The second listing should display after the setuid file list, and be formatted similar to the
# setuid file list including having a title
# use the find command to find files of the right type and with the right permissions, and an error redirect to
# /dev/null so we do not get errors for inaccessible directories and files
# the identified files should be sorted by their group

# Task 2 for the exercise is to modify it to also display the 10 largest regular files in the system, sorted by their sizes
# The listing should only have the file name, owner, and size in MBytes and be displayed after the listings of
# setuid and setgid files and should have its own title
# use the find command to generate the list of files with their sizes, with an error redirect to /dev/null
# use cut or awk to display only the output desired

echo "Setuid files:"
echo "============="
find / -type f -executable -perm -4000 -ls 2>/dev/null | sort -k 3
echo ""
echo "Setgid files:" # setgid file list including having a title
echo "=============="
find / -type f -executable -perm -2000 -ls 2>/dev/null | #/dev/null uses so we do not get errors for inaccessible directories and files and 2000 is to find permissions related to gid
sort -k 6 # -k 6 is for the identified files should be sorted by their group
echo ""
echo "The 10 largest regular files in the system:"
echo "=============================================="
find /home/ -type f -exec ls -alh 2>/dev/null --block-size=M {} \; | #/dev/null uses so we do not get errors for inaccessible directories, -exec executes ls with all,longlist, and h options and blocksize = M shows all files in MB and curly breckets \; uses to execute ls on each and every findings
sort -hk5 | #reverse short on 5th column
tail -n 10| #showing last 10 files and give this output to awk to handle columns and to show accordingly
awk '{print $9, $3, $5}' #awk is different programming language uses in here to provide custom sequence of columns
echo ""
