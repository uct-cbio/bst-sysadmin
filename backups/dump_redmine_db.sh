#!/bin/sh
config=/home/gerrit/code/bst-sysadmin/backups/config.txt
dump_dir=/home/gerrit/backups/database_dumps
db_dump_file=$dump_dir/redmine_db.sql
db_dump_file_copy=$dump_dir/redmine_db.sql.copy

if [ -e "$db_dump_file" ]; then
    echo "Making a copy of the previous dump..."
    mv $db_dump_file $db_dump_file_copy
else
   echo "No dump exits."
fi

. $config

echo "Dumping database..."
cmd="mysqldump --no-tablespaces --single-transaction -uredmine -p\"$redmine_db_pwd\" redmine > $db_dump_file"
eval $cmd
echo "Removing copy.."
rm -f $db_dump_file_copy
echo "Done."
