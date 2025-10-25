#!/usr/bin/env nextflow

process STAR_ALIGN {
    label 'process_high'
    container 'ghcr.io/bf528/star:latest'
    publishDir params.outdir

    input: 
    tuple val(name), path(reads)
    path index_directory
    output: 
    tuple val(name), path("*.bam"), emit: bam
    path ("*.Log.final.out"), emit: log
    script: 
    """
    STAR --runThreadN $task.cpus --genomeDir ${index_directory} --readFilesIn ${reads[0]} ${reads[1]} --readFilesCommand zcat --outFileNamePrefix ${name}. --outSAMtype BAM SortedByCoordinate 2> ${name}.Log.final.out
    """

}