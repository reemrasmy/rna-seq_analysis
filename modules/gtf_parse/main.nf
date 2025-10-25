#!/usr/bin/env nextflow

process GTF_PARSE {
    label 'process_low'
    container 'ghcr.io/bf528/biopython:latest'
    publishDir params.outdir
    
    input:
    path gtf
    path output_file
    
    output: 
    path output_file
    
    script: 
    """
    prjct2_argparse.py -i $gtf -o $output_file
    """

}
