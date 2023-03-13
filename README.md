# mask-repeats-nf
simple RepeatModeler/Masker pipeline

## Introduction
This pipeline soft-masks as many genomes as you want in parallel by running
RepeatModeler and then RepeatMasker on them.

## Setup
Take a look at our [nextflow pipeline advice][nf-advice] doc. In general, all
you need is to have nextflow installed and configured and it will take care of
everything else, including downloading this pipeline. This pipeline runs
everything inside of the [tetools][tet] container.

## Running
Just run
```bash
nextflow run WarrenLab/mask-repeats-nf --assemblies /path/to/assemblies/*.fa
```

That's it! It will put all RepeatMasker output in `out/`.

[nf-advice]: <https://github.com/WarrenLab/docs/blob/main/nextflow.md>
[tet]: <https://github.com/Dfam-consortium/TETools>
