#!/usr/bin/env python
import pandas as pd
import argparse

parser = argparse.ArgumentParser(description='Concatenate VERSE exon count files into a single counts matrix')
parser.add_argument('-i', dest='inputs', nargs='+', help='List of VERSE exon.txt files', required=True)
parser.add_argument('-o', dest='output', help='Output counts matrix .txt file', required=True)
args = parser.parse_args()

concat_dfs = pd.DataFrame()

for file in args.inputs:
    exp_name = file[:-9]
    df = pd.read_csv(file, sep="\t", header=0, names=['gene', exp_name])

    if concat_dfs.empty:
        concat_dfs = df
    else:
        concat_dfs = concat_dfs.merge(df, on='gene')

concat_dfs.set_index('gene', inplace=True)
#concat_dfs.index.name = None


concat_dfs.to_csv(args.output, sep="\t")

