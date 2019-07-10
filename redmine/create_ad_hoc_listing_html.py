#!/usr/bin/env python3.6

# Create an HTML page listing all the ad hoc queries in Redmine

import sys
import jinja2
from jinja2 import Template
import re
import string
from optparse import OptionParser
import csv

def main():
    usage = "usage: %prog -i ad_hoc_listing_file -t ad_hoc_listing_template_file -o project_listing_html_file"
    parser = OptionParser(usage=usage)
    parser.add_option("-i", "--input", dest="al_file", help="Add hoc listing TSV input file.")
    parser.add_option("-t", "--template", dest="template", help="Add hoc listing HTML template file.")
    parser.add_option("-o", "--output", dest="alh_file", help="Add hoc listing HTML output file.")
    (options, args) = parser.parse_args()

    if not options.al_file:
        print ("Please specify the add hoc listing TSV input file. (-i input)")
        return - 1
    if not options.template:
        print ("Please specify the add hoc listing HTML template file (-o output)")
        return - 2
    if not options.alh_file:
        print ("Please specify the add hoc listing HTML output file (-o output)")
        return - 3
    if (len(args) > 0):
        print ("Too many input arguments")
        return - 4

    al_file = options.al_file
    template = options.template
    alh_file = options.alh_file

    loader = jinja2.FileSystemLoader(template)
    env = jinja2.Environment(loader=loader)
    tm = env.get_template("")

    pl_file_tsv = csv.reader(open(al_file), delimiter='\t')

    rows = []
    for row in pl_file_tsv:
        rows.append(row)

    html = (tm.render(rows=rows))

    fd_out = open(alh_file,"w")
    fd_out.write(html)
    fd_out.close()

if __name__ == "__main__":
    sys.exit(main())
