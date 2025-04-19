# minIncome finds the record with the minimum income from the file
# Parameters:	
#   a0 contains address of pointer pair array 
#      this is (0x10040000 in our example) 
#      But your code MUST handle any address value
#   a1:the number of records in the file
# Return value: 
#   a0: pointer to actual location of record stock name in file buffer
#
# Consider whether this is a leaf or nested function
# Consider what registers you may have to save and restore
# What type of register is best to use and why.
# This function must make calls to the input_from_record function.

minIncome:
	#if empty file, return 0 for both a0, a1
	bnez a1, minIncome_fileNotEmpty ###F### minIncome Function
	li a0, 0
	ret

minIncome_fileNotEmpty:	
# ----------Begining of student code for minIncome---------

    addi sp, sp, -SIZE_20
    sw ra, 0(sp)
    sw s0, 4(sp)  # Base pointer
    sw s1, 8(sp)  # Record count
    sw s2, 12(sp) # Current min value
    sw s3, 16(sp) # Current min address

    mv s0, a0     # Store base address
    mv s1, a1     # Store record count

    # Initialize with first record
    addi a0, s0, 4
    jal income_from_record
    mv s2, a0          # Initial min value
    mv s3, s0          # Initial min address

    # Setup loop for remaining records
    li t0, 1           # Records processed counter
    addi t1, s0, 8     # Current record pointer

min_loop:
    bge t0, s1, min_done  # All records processed
    
    addi a0, t1, 4     # Get income pointer
    jal income_from_record
    
    # Compare and update min
    bge a0, s2, skip_min_update
    mv s2, a0          # New min value
    mv s3, t1          # New min address
skip_min_update:
    
    addi t0, t0, 1     # Increment counter
    addi t1, t1, 8     # Next record
    j min_loop

min_done:
    mv a0, s3          # Return min address
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    addi sp, sp, SIZE_20
    


#    # Optimization Begin
#    #nop # minIncome_fileNotEmpty  !!! CRAZY WHY EFFECT TO SCORE (Branches and ALU)
#    # Optimization End - Old Score: 2396, New Score 2395
#
#    # Save return address (ra) and set up the stack space
#    addi sp, sp, -SIZE_4  # Adjust stack pointer by 4 bytes for saving ra
#    sw ra, 0(sp)          # Save return address to the stack
#    
#    li a2, FIND_MIN       # Set mode to FIND_MIN (search for minimum income)
#    jal shared_MinMax     # Call shared logic to find the min income
#    
#    lw ra, 0(sp)          # Restore the return address (ra) from the stack
#    addi sp, sp, SIZE_4   # Adjust stack pointer back (restore it)

#---------- End student code here for minIncome!------------
	ret

