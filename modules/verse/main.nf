process VERSE {
    label 'process_medium'
    container 'ghcr.io/bf528/verse:latest'
    publishDir params.outdir
    

    input: 
    tuple val(name), path(bam) 
    path gtf
    
    output: 
    path "${name}.exon.txt"

    script: 
    """
    verse -a ${gtf} -o ${name} -S ${bam}
    """

}


