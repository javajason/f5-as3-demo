# This script continuously polls a GitHub repo for changes.
# It does this by checking the repo, every 60 seconds, for its most recent update and comparing it to the last update it knows about.
# If there is a more recent update, then a new change has been committed.
# It relies on a data file, LastUpdate.txt, which stores the date of the most recent known change. Example contents: "2023-05-11T00:42:13Z".

oldChange=`cat LastUpdate.txt`

while true
  do

  oldChange=`cat LastUpdate.txt`
  # date "+%Y-%m-%dT%H:%M:%SZ" > LastUpdate.txt

  isNewCommit=`gh search commits --repo javajason/f5-as3-demo --author-date=">$oldChange" \
    | sed s/"^no commits*"//g`

  if [ "$isNewCommit" = "" ]
  then
    echo No new changes.
  else
    echo New changes have been made!
  fi


  # echo Previous change at $oldChange
  # echo Most recent change at $recentChange

  # if [[ "$recentChange" > "$oldChange" ]]
  # then
  #   echo New changes have been made! Latest is $recentChange
  # else
  #   echo No new changes.
  # fi

  sleep 60
done
