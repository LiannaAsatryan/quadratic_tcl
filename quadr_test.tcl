#!usr/bin/tclsh

#this function receives the input data and the golden data and calls the
#quadr function for the input values writes in the output file,
# compares with the corresponding value in the golden file
# and writes a message in the result file (passed or not passed)
proc test {input_data golden_data} {
        set len [llength $input_data]
        set output_data []
        set result_data []
        for {set i 0} {$i < [expr $len - 1]} {incr i} {
                set a [lindex $input_data $i 0]
                set b [lindex $input_data $i 1]
		set c [lindex $input_data $i 2]
                set quadr_result [quadr $a $b $c]
                append output_data $quadr_result
                if {$i != [expr $len - 2]} {
                        append output_data "\n"
                }
                set similiar  [expr {$quadr_result == [lindex $golden_data $i]}]
                if {$similiar == 1} {
                        append result_data "test passed" "\n"
                } else {append result_data "test not passed" "\n"}
        }
        write_data "output.txt" $output_data
        write_data "result.txt" $result_data
}

#the main function cleans the generated files,
#checks the accurance of the input_file,
#if everything is ok, it calls the testing function,
#otherwise writes the message in the golden and output files
proc main {} {
        source "quadr_functions.tcl"
        clean_files
        if {[check_input]} {
                set input_data [get_data "input.txt"]
                set golden_data [get_data "golden.txt"]
                test $input_data $golden_data
        } else {
                set answer "wrong input"
                write_data "output.txt" $answer
                write_data "result.txt" $answer
        }
}

main

