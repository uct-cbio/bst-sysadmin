#!/bin/bash
source ~/miniconda3/etc/profile.d/conda.sh
conda activate py3.7
/home/gerrit/code/bst-sysadmin/redmine/get_project_info.sh > /home/gerrit/scratch/project_info.tsv
cat /home/gerrit/scratch/project_info.tsv | sort -k 6 -r -t$'\t' | tail -n +2 > /home/gerrit/scratch/content.tsv
head -n 1 /home/gerrit/scratch/project_info.tsv  > /home/gerrit/scratch/head.tsv
cat /home/gerrit/scratch/head.tsv /home/gerrit/scratch/content.tsv > /home/gerrit/scratch/project_info.tsv
/home/gerrit/code/bst-sysadmin/redmine/create_project_listing_html.py -i /home/gerrit/scratch/project_info.tsv -t /home/gerrit/code/bst-sysadmin/redmine/create_project_listing_template.tmpl -o /home/gerrit/scratch/project_info.html
sudo cp /home/gerrit/scratch/project_info.html /var/www/html/index.html
