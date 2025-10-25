process COUNTS_MATRIX {
    label 'process_medium'
    container 'ghcr.io/bf528/pandas:latest'
    publishDir params.outdir

    input:
    path verse_exons
    path output_file

    output:
    path output_file

    script: 
    """
    verse_argparse.py -i $verse_exons -o $output_file
    """

}