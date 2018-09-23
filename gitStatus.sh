#!/bin/bash
##############################################################################
# file: gitStatus.sh
#
#                   grep the output of a git status command and determine 
#                   whether we need to commit any files or if we need to 
#                   track untracked files in an array of git repositories
# author: 			John Schwartzman, Forte Systems, Inc.
#
# last revision:	09/23/2018
##############################################################################

set -o nounset			# use strict (no unset variables)

escRed='\e[1;31m'       # define a few color escape sequences
escYellow='\e[0;33m'
escGreen='\e[0;32m'
escReset='\e[0m'

# define cmd1 and cmd2
cmd1="git status . | grep -c \"modified:\""
cmd2="git status . | grep -c \"Untracked files:\""

# define the output strings
strNoCommit="has no files that need to be committed."
strCommit="file(s) that need to be committed."
strNoUntracked="has no untracked files."
strUntracked="has one or more untracked files."

# declare arrays of the project names and their associated directories
declare -a proj
proj[0]="utility|$HOME/Development/UnixDomainSocket/utility/src"
proj[1]="transport|$HOME/Development/UnixDomainSocket/transport/src"
proj[2]="serverTest|$HOME/Development/UnixDomainSocket/serverTest/src"
proj[3]="clientTest|$HOME/Development/UnixDomainSocket/clientTest/src" 
proj[4]="simpleClientTest|$HOME/Development/UnixDomainSocket/simpleClientTest/src"
proj[5]="utilityTest|$HOME/Development/UnixDomainSocket/utilityTest/src"

numProjects=${#proj[@]} # keep track of the number of projects in the array

echo
echo $(date)    # timestamp the output

##############################################################################

# for each project in turn,
#   cd to the repository directory
#   evaluate cmd1 and cmd2 and save the count of strings found in
#   count1 and count2
#   output the results to the user based on the contents of count1 and count2

for (( i=0; $i < $numProjects; i++ )); do

    project="${proj[$i]%%|*}"   # derive the project name from proj[i]
    dir="${proj[$i]#*|}"        # derive the directory name from proj[i]

    cd "${dir}"                 # go into the repository directory
    
    count1=$(eval ${cmd1})      # execute cmd1 and save the result in count1
    count2=$(eval ${cmd2})      # execute cmd2 and save the result in count2

    if [ $count1 -eq 0 ]
    then
        # there are no strings that need to be committed
        echo -e "${escGreen}${project} $strNoCommit"
    else
        # there are count1 string(s) that need to be committed
        echo -e "${escRed}${project} has $count1 $strCommit"
    fi

    if [ $count2 -ne 0 ]
    then
        # there are one or more untracked files
        echo -e "${escYellow}${project} $strUntracked"
    else
        # there are no untracked files
        echo -e "${escGreen}${project} ${strNoUntracked}"
    fi

    echo -e ${escReset}
done

##############################################################################
