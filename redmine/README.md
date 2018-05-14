## Get Redmine info

Keep a `config.txt` in the same folder that you run your scripts. Add your Redmine API key in the config.

`key=XXXXXX`

1. Get all project info - `./get_project_info.sh > ~/scratch/project_info.tsv` - This creates a tab delimited file with all project info.

E.g.

| Project title  | Members       | Short description of project | Ojectives | Hours spent |
| -------------- | ------------- | ---------------------------- | --------- | ----------- |
| X              | X             | X                            | X         | X           |

2. Get all info from the BST ad-hoc project - `./get_ad_hoc_project_issue_info.sh  > ~/scratch/ad_hoc_project_issue_info.tsv` - This creates a tab delimited file with all info from the BST ad-hoc project.

E.g.

| Issue id       | Issue description  | Person assigned to | Hours spent |
| -------------- | ------------------ | ------------------ | ----------- |
| X              | X                  | X                  | X           |