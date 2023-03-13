#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

params.assemblies = ""

process BUILD_DATABASE {
    input:
        tuple val(assemblyName), path(assembly)

    output:
        tuple val(assemblyName), path("${assemblyName}.*")

    """
    BuildDatabase -name $assemblyName $assembly
    """
}

process REPEAT_MODELER {
    input:
        tuple val(dbName), path(db)

    output:
        tuple val(dbName), path("${dbName}-families.fa")

    """
    RepeatModeler -threads $task.cpus -database $dbName -quick
    """
}

process REPEAT_MASKER {
    input:
        tuple val(dbName), path(assembly), path(families)

    output:
        path("${dbName}.fa.*")

    """
    RepeatMasker \
        -pa ${task.cpus.intdiv(4)} \
        -lib $families \
        -xsmall \
        $assembly
    """
}

workflow {
    Channel.fromPath(params.assemblies)
        .map { tuple(it.baseName, it) }
        .set { assemblies }
    REPEAT_MODELER(BUILD_DATABASE(assemblies))
    REPEAT_MASKER(assemblies.join(REPEAT_MODELER.out))
}
