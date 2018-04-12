#test convertStringToInt
	la $a0, test1
	addi $t1, $0, '\0'
	sb $t1, 4($a0)
	jal convertStringToInt
	add $a0, $0, $v0
	addi $v0, $0, 1
	syscall
	# test isLeapYear
	addi $a0, $0, 2000
	jal isLeapYear
	add $a0, $0, $v0
	addi $v0, $0, 1
	syscall
	# test checkDateValid
	addi $a0, $0, 1
	addi $a1, $0, 1
	addi $a2, $0, 2015
	jal checkDateValid
	addi $a0, $v0,0
	addi $v0, $0, 1
	syscall
	# test checkChoiceValid
	addi $a0, $0, 7
	jal checkChoiceValid
	addi $a0, $v0, 0
	addi $v0, $0, 1
	syscall
	# test Date
	la $a3, test1
	addi $a0, $0, 30
	addi $a1, $0, 1
	addi $a2, $0, 1998
	jal Date
	addi $a0, $v0, 0
	addi $v0, $0, 4
	syscall
	# test Day <after call Date>
	addi $a0, $v0, 0
	jal Day
	addi $a0, $v0, 0
	addi $v0, $0, 1
	syscall
	# test Month <after call Date>
	addi $a0, $v0, 0
	jal Month
	addi $a0, $v0, 0
	addi $v0, $0, 1
	syscall
	# test Year <after call Date>
	addi $a0, $v0, 0
	jal Year
	addi $a0, $v0, 0
	addi $v0, $0, 1
	syscall
	# test getNameMonth
	addi $a0, $0, 3
	jal getNameMonth
	addi $a0, $v0, 0
	addi $v0, $0, 4
	syscall
	# test Convert type A
	la $a0, test1
	addi $a1, $0, 'C'
	jal Convert
	addi $a0, $v0, 0
	addi $v0, $0, 4
	syscall
	# test LeapYear
	la $a0, test1
	jal LeapYear
	addi $a0, $v0, 0
	addi $v0, $0, 1
	syscall
	# test GetTime
	la $a0, test1
	la $a1, test2
	jal GetTime
	addi $a0, $v0, 0
	addi $v0, $0, 1
	syscall
	# test Weekday
	la $a0, test1
	jal Weekday
	addi $a0, $v0, 0
	addi $v0, $0, 4
	syscall
	# test getLeapYearNearest
	la $a0, test1
	jal getLeapYearNearest
	addi $a0, $v0, 0
	addi $v0, $0, 1
	syscall
	addi $a0, $v1, 0
	addi $v0, $0, 1
	syscall
