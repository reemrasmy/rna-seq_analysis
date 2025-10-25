#!/usr/bin/env nextflow
include {FASTQC} from './modules/fastqc'
include {GTF_PARSE} from './modules/gtf_parse'
include {STAR_INDEX} from './modules/star_index'
include {STAR_ALIGN} from './modules/star_align'
include {MULTIQC} from './modules/multiqc'
include {VERSE} from './modules/verse'
include {COUNTS_MATRIX} from './modules/counts_matrix'


workflow {

    align_ch = Channel.fromFilePairs(params.reads)
    //align_ch.view()
    //Sample Output: 
        //[exp_rep3, [/projectnb/bf528/materials/project-2-rnaseq/subsampled_files/exp_rep3_R1.subset.fastq.gz, /projectnb/bf528/materials/project-2-rnaseq/subsampled_files/exp_rep3_R2.subset.fastq.gz]]
    
    
    fastqc_ch = align_ch.transpose()
    //fastqc_ch.view()
    //Sample Output: 
        //[exp_rep3, /projectnb/bf528/materials/project-2-rnaseq/subsampled_files/exp_rep3_R1.subset.fastq.gz]
        //[exp_rep3, /projectnb/bf528/materials/project-2-rnaseq/subsampled_files/exp_rep3_R2.subset.fastq.gz]
    
    
    FASTQC(fastqc_ch)

    GTF_PARSE(params.gtf,params.gene_names)
    //Sample Output: (from txt)
        //ENSG00000290825.1	DDX11L2
        //ENSG00000223972.6	DDX11L1
        //ENSG00000227232.6	WASH7P
    
    
    STAR_INDEX(params.genome, params.gtf)
        //Sample Output: star_index directory: results/star_index 

    STAR_ALIGN(align_ch,STAR_INDEX.out.star_index)

    fastqc_zips = FASTQC.out.zip.map { name, zip -> zip }
    star_logs = STAR_ALIGN.out.log
    multiqc_ch = fastqc_zips.mix(star_logs).flatten().collect()

    //multiqc_ch.view()

    MULTIQC(multiqc_ch)
    
    VERSE(STAR_ALIGN.out.bam, params.gtf)

    verse_exons = VERSE.out.collect()
    //verse_exons.view()
        //Output: [/projectnb/bf528/students/rrasmy/project-2-reemrasmy/work/ff/dfc1144e175ff0a7f76e193a4ca4a9/exp_rep1.exon.txt, 
                // /projectnb/bf528/students/rrasmy/project-2-reemrasmy/work/e7/243acca17693386ee59321029854f9/control_rep3.exon.txt ...
    COUNTS_MATRIX(verse_exons, params.counts_matrix)



    
}
