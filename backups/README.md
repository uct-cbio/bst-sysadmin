Adding line to crontab to run a MySQL dump of the Redmine db daily at 6pm. This dump will then be picked up by Bacula.

```
00 18 * * * /home/gerrit/code/bst-sysadmin/backups/dump_redmine_db.sh 2>&1 | mail -s "Cronjob report - BST Redmine db dump"   gerrit.botha@uct.ac.za
```
