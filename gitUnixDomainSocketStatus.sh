#!/bin/bash
##############################################################################
# file: 			grep the output of a git status and determine whether
#                   we need to commit any files (UnixDomainSocket project)
# author: 			John Schwartzman, Forte Systems, Inc.
# last revision:	07/14/2018
##############################################################################

set -o nounset			# use strict (no unset variables)

cd /home/js/Development/UnixDomainSocket/utility/src

COUNT1=$(git status --untracked-files=no | grep -c "nothing to commit")
COUNT2=$(git status --untracked-files=normal | grep -c "Untracked files")

echo
if [ $COUNT1 -eq 1 ];
then
    echo "utility has no files to commit.";
fi

if [ $COUNT2 -ne 0 ];
then
    echo "utility has 1 or more untracked files.";
fi
echo

cd /home/js/Development/UnixDomainSocket/transport/src

COUNT1=$(git status --untracked-files=no | grep -c "nothing to commit")
COUNT2=$(git status --untracked-files=normal | grep -c "Untracked files")

if [ $COUNT1 -eq 1 ];
then
    echo "transport has no files to commit.";
fi

if [ $COUNT2 -ne 0 ];
then
    echo "transport has 1 or more untracked files.";
fi
echo


cd /home/js/Development/UnixDomainSocket/clientTest/src

COUNT1=$(git status --untracked-files=no | grep -c "nothing to commit")
COUNT2=$(git status --untracked-files=normal | grep -c "Untracked files")

if [ $COUNT1 -eq 1 ];
then
    echo "clientTest has no files to commit.";
fi

if [ $COUNT2 -ne 0 ];
then
    echo "clientTest has 1 or more untracked files.";
fi
echo


cd /home/js/Development/UnixDomainSocket/simpleClientTest/src

COUNT1=$(git status --untracked-files=no | grep -c "nothing to commit")
COUNT2=$(git status --untracked-files=normal | grep -c "Untracked files")

if [ $COUNT1 -eq 1 ];
then
    echo "simpleClientTest has no files to commit.";
fi

if [ $COUNT2 -ne 0 ];
then
    echo "simpleClientTest has 1 or more untracked files.";
fi
echo


cd /home/js/Development/UnixDomainSocket/serverTest/src

COUNT1=$(git status --untracked-files=no | grep -c "nothing to commit")
COUNT2=$(git status --untracked-files=normal | grep -c "Untracked files")

if [ $COUNT1 -eq 1 ];
then
    echo "serverTest has no files to commit.";
fi

if [ $COUNT2 -ne 0 ];
then
    echo "serverTest has 1 or more untracked files.";
fi
echo


cd /home/js/Development/UnixDomainSocket/utilityTest/src

COUNT1=$(git status --untracked-files=no | grep -c "nothing to commit")
COUNT2=$(git status --untracked-files=normal | grep -c "Untracked files")

if [ $COUNT1 -eq 1 ];
then
    echo "utilityTest has no files to commit.";
fi
if [ $COUNT2 -ne 0 ];
then
    echo "utilityTest has 1 or more untracked files.";
fi
echo

