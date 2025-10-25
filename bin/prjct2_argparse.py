#!/usr/bin/env python
import argparse

parser = argparse.ArgumentParser(description='ensemblID to gene name')
parser.add_argument('-i', dest='input', help='GTF file', required=True)
parser.add_argument('-o', dest='output', help='txt file', required=True)
args = parser.parse_args()

gene_ids = {}

gtf = open(args.input, 'r')
genes = []
for line in gtf:
    if line.startswith('#'):
        continue
    else:
        line = line.strip().split('\t')
        gene_attribs = line[8].strip().split(';')
        genes.append(gene_attribs)
print(genes)

for attrib in genes:
    gene_id = attrib[0].strip().split(' ')[1].strip('"')
    gene_name = attrib[3].strip().split(' ')[1].strip('"')
    gene_ids[gene_id] = gene_name

output = open(args.output, 'w')

for ensembl in gene_ids:
    gene_name = gene_ids[ensembl]
    output.write(f'{ensembl}\t{gene_name}\n')

output.close()
