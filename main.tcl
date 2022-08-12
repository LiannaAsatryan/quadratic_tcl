#!usr/bin/tclsh

#this function receives the input data and the golden data and calls the
#gcd function for the input values writes in the output file,
# compares with the corresponding value in the golden file
# and writes a message in the result file (passed or not passed)
proc solve { input_data } {
        set len [llength $input_data]
        set output_data []
        for {set i 0} {$i < [expr $len - 1]} {incr i} {
                set a [lindex $input_data $i 0]
                set b [lindex $input_data $i 1]
		set c [lindex $input_data $i 2]
                set quadr_result [quadr $a $b $c]
                append output_data $quadr_result
                if {$i != [expr $len - 2]} {
                        append output_data "\n"
                }
        }
        write_data "output.txt" $output_data
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
                solve $input_data
        } else {
                write_data "output.txt" "wrong data"
        }
}

main

