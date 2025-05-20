#!/usr/bin/env nextflow

/*
 * Use echo to print 'Hello World!' to a file
 */
process sayHello {

    publishDir 'results', mode: 'copy'

    input:
        val greeting

    output:
        path "${greeting}-output.txt"

    script:
    """
    echo '$greeting' > '$greeting-output.txt'
    """
}

/*
 * Pipeline parameters
 */
params.greeting = 'greetings.csv'

workflow {

    //declare an array of input greetings
    //greeting_array = '['Hello','Bonjour','Hola']'

    // create a channel for inputs
    greeting_ch = Channel.fromPath(params.greeting)
                    //.view{greeting -> "Before flatten: $greeting"}
                    //.flatten()
                    //  .view{greeting -> "After flatten: $greeting"}

    // emit a greeting
    sayHello(greeting_ch)
}
