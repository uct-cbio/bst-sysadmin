#!/bin/bash

. config.txt

# Print header
echo -e "Issue id\tIssue description\tPerson assigned to\tHours spent"
# cbio12 is the BST ad-hoc project
join -1 1 -2 1 -t $'\t' \
  <(join -1 1 -2 1 -t $'\t' \
    <(for i in `curl -X GET -H 'Content-type: text/xml' "http://bst.cbio.uct.ac.za/redmine/projects/cbio12/issues.xml?format=xml&key=$key" 2> /dev/null | xmllint --xpath '//id' - | sed "s/<id>//g" | sed "s/<\/id>/\n/g"`; do
      echo -ne $i'\t';curl -X GET -H 'Content-type: text/xml' "http://bst.cbio.uct.ac.za/redmine/issues/$i.xml?format=xml&key=$key" 2> /dev/null | xmllint --xpath '//subject' - | sed "s/<subject>//g" | sed "s/<\/subject>/\n/g";
    done) \
    <(for i in `curl -X GET -H 'Content-type: text/xml' "http://bst.cbio.uct.ac.za/redmine/projects/cbio12/issues.xml?format=xml&key=$key" 2> /dev/null | xmllint --xpath '//id' - | sed "s/<id>//g" | sed "s/<\/id>/\n/g"`; do
      echo -ne $i'\t';curl -X GET -H 'Content-type: text/xml' "http://bst.cbio.uct.ac.za/redmine/issues/$i.xml?format=xml&key=$key" 2> /dev/null | xmllint --xpath '//assigned_to' - | sed "s/<assigned_to.*name=\"//g" | sed "s/\"\/>/\n/";
    done)) \
  <(for i in `curl -X GET -H 'Content-type: text/xml' "http://bst.cbio.uct.ac.za/redmine/projects/cbio12/issues.xml?format=xml&key=$key" 2> /dev/null | xmllint --xpath '//id' - | sed "s/<id>//g" | sed "s/<\/id>/\n/g"`; do
    echo -ne $i'\t';curl -X GET -H 'Content-type: text/xml' "http://bst.cbio.uct.ac.za/redmine/issues/$i.xml?format=xml&key=$key" 2> /dev/null | xmllint --xpath '//total_spent_hours' - | sed "s/<total_spent_hours>//g" | sed "s/<\/total_spent_hours>/\n/g";
  done)
