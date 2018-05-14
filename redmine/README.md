## Get Redmine info

Keep a `config.txt` in the same folder that you run your scripts. Add your Redmine API key in the config.

`key=XXXXXX`

1. Get all project info - `./get_project_info.sh > ~/scratch/project_info.tsv` - This creates a tab delimited file with all project info.

2. Get all info from the BST ad-hoc project - `./get_ad_hoc_project_issue_info.sh  > ~/scratch/ad_hoc_project_issue_info.tsv` - This creates a tab delimited file with all info from the BST ad-hoc project
