#!/bin/bash

base_dir=$PWD
for I in *_*; do
  PROJECT=$(echo $I | awk 'BEGIN {FS="_"} ; { print $2}')
  echo $PROJECT
  pushd . > /dev/null
  cd $I
  # rm -rf evosuite-files
  rm -rf evosuite-tests
  rm -rf evosuite-reports
  rm -rf LOG*
  rm -rf allMethods.txt  
  rm -rf distribution.xlsx
  rm -rf progress.xlsx

  if [ !  -e $PROJECT.jar  ] ; then
   echo ERROR file $PROJECT.jar does not exist!!!
   exit 1
  fi
  
  # run evosuite
  java -jar $base_dir/EvosuiteTest-1.0.6-SNAPSHOT.jar -criterion branch -target $PROJECT.jar -Doutput_variables=TARGET_CLASS,criterion,Size,Length,MutationScore -Dsearch_budget 900 -inclusiveFile /home/wgj/SF100_01/target1.txt
  popd > /dev/null
done
