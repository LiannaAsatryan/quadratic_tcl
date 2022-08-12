#!usr/bin/tclsh

#this function returns true if there are more than <n> digits after the point in the <num>
proc precision { num n } {
        set p 1
        for {set i 0} {$i<$n} {incr i} {
                set p [expr {$p*10}]
        }
        #p=10^n
        set d [expr {$num * $p }]
        if { [expr {abs($d)}] > [expr {abs(int($d))}] } {
                return true
        } else { return false }
}

#this function corrects the numeric data so that we don't have num.0
#and if the number of digits after the point are more than 4(in this case)
#the function sets its precision to 4
proc correct_data { res } {
	#to avoid the num.0 case
        if { $res == [expr int($res)]} { return [expr int($res)]}
	#setting the precision if it is necessary
        if { [precision $res 4] } {
        	return [format {%.4f} $res]
        }
        return $res
}

#this function returns the solution(as a string) of the ax+b=0 linear equation
proc linear { a b } {
        if { $a == 0 && $b == 0 } {
                #infinity
                return "R"
        }
        if { $b != 0 && $a == 0 } {
                return "no solution"
        }
        if { $b == 0 } {
                return "0"
        }  else {
        	set res [expr { (- $b * 1.0) / ($a) }]
                return [correct_data $res]
        }
}

#this function solves the quadratic equation ax^2+bx+c=0, where a, b, and c are given as 
#str1, str2, str3.  Answer will be returned as a string
proc quadr { a b c } {
	if { $a == 0 } {
        	return [linear $b $c]
        }
        set d [expr {$b * $b - 4 * $a * $c}]
        if { $d == 0 } {
        	set res [expr {(- $b * 1.0) / ( 2 * $a )}]
		return [correct_data $res]
        } elseif {$d < 0} {
        	return "no solution"
	} else {
        	set s1 [expr {1.0 * (- $b + sqrt($d)) / (2 * $a)}]
                set s2 [expr {1.0 * (- $b - sqrt($d)) / (2 * $a)}]
		set s1 [correct_data $s1]
		set s2 [correct_data $s2]
		set S " "
		if { $s1 < $s2 } { return $s1$S$s2 } else { return $s2$S$s1 }
        }
}

#this function checks whether all the inputs in the input_file are real numbers
#if they are, the function returns true, and returns false otherwise
proc check_input {} {
        set file_data [read_data "input.txt"]
        set data [split $file_data "\n"]
        foreach line $data {
                set str1 [lindex $line 0]
                set str2 [lindex $line 1]
                if {![string is double $str1] || ![string is double $str2]} { return false}
        }
        return true
}

#this function reads data from the given file and returns that
proc read_data { file_name } {
        set fp [open $file_name]
        set file_data [read $fp]
        close $fp
        return $file_data
}

#this function writes the given data in the given file
proc write_data { file_name output_data } {
        set fp [open $file_name w+]
        puts $fp $output_data
        close $fp
}

#this function deletes the generated files
proc clean_files {} {
        file delete -force "output.txt"
        file delete -force "result.txt"
}

#this function reads the data drom the given file
#splits it into lines and returns the list
proc get_data { file_name } {
        set file_data [read_data $file_name]
        set data [split $file_data "\n"]
        return $data
}

