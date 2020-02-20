#!/usr/bin/env python3.6

# Create an HTML page listing all the projects in Redmine

import sys
import jinja2
from jinja2 import Template
import re
import string
from optparse import OptionParser
import csv
import datetime

def main():
    usage = "usage: %prog -i project_listing_file -t project_listing_template_file -o project_listing_html_file"
    parser = OptionParser(usage=usage)
    parser.add_option("-i", "--input", dest="pl_file", help="Project listing TSV input file.")
    parser.add_option("-t", "--template", dest="template", help="Project listing HTML template file.")
    parser.add_option("-o", "--output", dest="plh_file", help="Project listing HTML output file.")
    (options, args) = parser.parse_args()

    if not options.pl_file:
        print ("Please specify the project listing TSV input file. (-i input)")
        return - 1
    if not options.template:
        print ("Please specify the project listing HTML template file (-t output)")
        return - 2
    if not options.plh_file:
        print ("Please specify the project listing HTML output file (-o output)")
        return - 3
    if (len(args) > 0):
        print ("Too many input arguments")
        return - 4

    pl_file = options.pl_file
    template = options.template
    plh_file = options.plh_file

    loader = jinja2.FileSystemLoader(template)
    env = jinja2.Environment(loader=loader)
    tm = env.get_template("")

    pl_file_tsv = csv.reader(open(pl_file), delimiter='\t')

    rows = []
    new_format = "%Y/%m/%d"
    header = True

    for row in pl_file_tsv:
        rows.append(row)
        if(not header):
            d1 = datetime.datetime.strptime(row[4],"%Y-%m-%dT%H:%M:%SZ")
            row[4] = d1.strftime(new_format)
            d1 = datetime.datetime.strptime(row[5],"%Y-%m-%dT%H:%M:%SZ")
            row[5] = d1.strftime(new_format)

        header = False

    html = (tm.render(rows=rows))

    fd_out = open(plh_file,"w", encoding='utf-16')
    fd_out.write(html)
    fd_out.close()

if __name__ == "__main__":
    sys.exit(main())
