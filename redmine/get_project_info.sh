#!/bin/bash

. config.txt

# Print header
echo -e "Project title\tMembers\tShort description of project\tOjectives\tCreated on\tUpdate on\tHours spent"
# Get info for all projects
for i in `curl -X GET -H 'Content-type: text/xml' "https://bst.cbio.uct.ac.za/redmine/projects.xml?format=xml&key=$key&limit=100" 2> /dev/null | xmllint --xpath '//identifier' - | sed "s/<identifier>//g" | sed "s/<\/identifier>/\n/g"`; do
  # Get project title
  curl -X GET -H 'Content-type: text/xml' "https://bst.cbio.uct.ac.za/redmine/projects/$i.xml?format=xml&key=$key" 2> /dev/null | xmlstarlet sel -t -v '//description' - | sed "s/<description>//g" | sed "s/<\/description>/\n/g" | tr "\n" " " | sed -e "s/.*\*Project title\*\(.*\)\*People involved\*.*/\1/" | sed "s/ //"
  echo -en '\t'
  # Get people involved
  curl -X GET -H 'Content-type: text/xml' "https://bst.cbio.uct.ac.za/redmine/projects/$i.xml?format=xml&key=$key" 2> /dev/null | xmlstarlet sel -t -v '//description' - | sed "s/<description>//g" | sed "s/<\/description>/\n/g" | tr "\n" " " | sed -e "s/.*\*People involved\*\(.*\)\*Short description of project\*.*/\1/" | sed "s/ //"
  echo -en '\t'
  # Get project description
  curl -X GET -H 'Content-type: text/xml' "https://bst.cbio.uct.ac.za/redmine/projects/$i.xml?format=xml&key=$key" 2> /dev/null | xmlstarlet sel -t -v '//description' - | sed "s/<description>//g" | sed "s/<\/description>/\n/g" | tr "\n" " " | sed -e "s/.*\*Short description of project\*\(.*\)\*Objectives\*.*/\1/" | sed "s/ //"
  echo -en '\t'
  # Get objectives
  curl -X GET -H 'Content-type: text/xml' "https://bst.cbio.uct.ac.za/redmine/projects/$i.xml?format=xml&key=$key" 2> /dev/null | xmlstarlet sel -t -v '//description' - | sed "s/<description>//g" | sed "s/<\/description>/\n/g" | tr "\n" " " | sed -e "s/.*\*Objectives\*\(.*\)/\1/" | sed "s/ //"
  echo -en '\t'
  # Get created on
  curl -X GET -H 'Content-type: text/xml' "https://bst.cbio.uct.ac.za/redmine/projects/$i.xml?format=xml&key=$key" 2> /dev/null | xmlstarlet sel -t -v '//created_on' - | sed "s/<created_on>//g" | sed "s/<\/created_on>//g" | tr "\n" " " | sed "s/ //"
  echo -en '\t'
  # Get updated on
  curl -X GET -H 'Content-type: text/xml' "https://bst.cbio.uct.ac.za/redmine/projects/$i.xml?format=xml&key=$key" 2> /dev/null | xmlstarlet sel -t -v '//updated_on' - | sed "s/<updated_on>//g" | sed "s/<\/updated_on>//g" | tr "\n" " " | sed "s/ //"
  echo -en '\t'
  # Get hours spent
  total=0.0;
    for j in `curl -X GET -H 'Content-type: text/xml' "https://bst.cbio.uct.ac.za/redmine/projects/$i/time_entries.xml?format=xml&key=$key" 2> /dev/null | xmlstarlet sel -t -v '//hours' - | sed "s/<hours>//g" | sed "s/<\/hours>/\n/g"`; do
      total=`echo "$total+$j"|bc`;
    done;
  echo $total
done
