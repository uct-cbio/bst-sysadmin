## Get Redmine info

Keep a `config.txt` in the same folder that you run your scripts. Add your Redmine API key in the config.

`key=XXXXXX`

1. Get all project info - `./get_project_info.sh > ~/scratch/project_info.tsv` - This creates a tab delimited file with all project info.

E.g.

| Project title  | Members       | Short description of project | Objectives | Hours spent |
| -------------- | ------------- | ---------------------------- | --------- | ----------- |
| X              | X             | X                            | X         | X           |

2. Get all info from the BST ad-hoc project - `./get_ad_hoc_project_issue_info.sh  > ~/scratch/ad_hoc_project_issue_info.tsv` - This creates a tab delimited file with all info from the BST ad-hoc project.

E.g.

| Issue id       | Issue description  | Person assigned to | Hours spent |
| -------------- | ------------------ | ------------------ | ----------- |
| X              | X                  | X                  | X           |

## Create HTML pages

1. Listing the projects and their project_info

`./create_project_listing_html.py -i ~/scratch/project_info.tsv -t create_project_listing_template.tmpl -o ~/scratch/project_info.html`


2. Listing the add-hoc queries and their info

`sed -i '/^$/d' ~/scratch/ad_hoc_project_issue_info.tsv`
`./create_ad_hoc_listing_html.py -i ~/scratch/ad_hoc_project_issue_info.tsv -t create_ad_hoc_listing_template.tmpl -o ~/scratch/ad_hoc_project_issue_info.html`

## Other

1. Sorting on time updated (same can be done on time created, column 5)
`cat ~/scratch/project_info.tsv | sort -k 6 -r -t$'\t' | tail -n +2 > ~/scratch/content.tsv`
`head -n 1 ~/scratch/project_info.tsv  > ~/scratch/head.tsv`
`cat ~/scratch/head.tsv ~/scratch/content.tsv > ~/scratch/project_info.tsv`
`./create_project_listing_html.py -i ~/scratch/project_info.tsv -t create_project_listing_template.tmpl -o ~/scratch/project_info.html`

2. Sorting on hours spent
`cat ~/scratch/project_info.tsv | tail -n +2 > ~/content.tsv`
`cat ~/scratch/content.tsv | sort -k 7 -rn -t$'\t' > ~/scratch/content.sorted.tsv`
`cat ~/scratch/project_info.tsv | head -n 1 > ~/scratch/header.tsv`
`cat ~/scratch/header.tsv ~/scratch/content.sorted.tsv > ~/scratch/project_info.tsv`
`./create_project_listing_html.py -i ~/scratch/project_info.tsv -t create_project_listing_template.tmpl -o ~/scratch/project_info.html`

3. `dump_index.sh` a script that is called by a cronjob to generate an project listing file as in (1) and dump it in the Apache root folder.
