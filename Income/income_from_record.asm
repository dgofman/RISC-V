
    #
    # The income_from_record function must return the numerical 
    # (binary value) of corresponding to the income from a 
    # specific record e.g. for record 
    # "Microsoft,34\r\n",it should return an integer value
    # of 34 in a0
    #
    # argument: a0 passed to income_from_record contains 
    # the address that points to the second pointers in 
    # the array of pointer pairs.  
    # e.g. for above example above it will point at the "3"
    # byte address.
    #
    # For more details look at how this gets invoked look
    # at the test bench call.
    #
    # Also look at the file: income_from_record_ideas_asm
    # for ideas about how to code this.
    # ...	
	# Note if you do not edit this code it just returns 0 :(
#------------- Modify this with your code! --------------
income_from_record:
    #nop # income_from_record  !!! CRAZY WHY EFFECT TO SCORE (Branches and ALU)
    .eqv ZERO 48       # Define a constant named 'ZERO' with a value of 48 (ASCII code for '0')
    .eqv NINE 57       # Define a constant named 'NINE' with a value of 57 (ASCII code for '9')
    #li t1, ZERO       # Load ASCII value of '0' into t1, used for comparison
    li t2, NINE        # Load ASCII value of '9' into t2, used for comparison
    li t3, 10          # Load constant value 10 into t3, used for decimal place multiplication

    lw a0, 0(a0)       # Load the address from a0 (which points to the income string) into a0
    mv t4, a0          # Copy the address in a0 into t4, this will act as the current character pointer
    
    #li t0, 0           # Initialize t0 to 0; t0 will store the accumulated value (the result)
    li a0, 0            # Optimization
    
# Loop to process each character in the string until a non-digit is encountered    
loop_income_from_record:
    #nop # loop_income_from_record  !!! CRAZY WHY EFFECT TO SCORE (Branches and ALU)
    lbu t5, 0(t4)      # Load unsigned byte from the memory address pointed to by t4 (character)
    #blt t5, t1, ret_income_from_record # If character is less than '0' (not a digit), exit loop
    #bgt t5, t2, ret_income_from_record # If character is greater than '9' (not a digit), exit loop
    
    # If character is a digit, convert from ASCII to integer
    #addi t5, t5, -ZERO  # Convert ASCII character to its integer value by subtracting 48 (ASCII of '0')
    
    #mul t0, t0, t3      # Multiply the current accumulated value by 10 (move to the next decimal place)
    #add t0, t0, t5      # Add the current digit to the accumulated result
    
    # Optimization Begin
    addi t5, t5, -ZERO       # Convert the ASCII value of the character (in t5) to an integer. 
    bgtu t5, t2, ret_income_from_record  # If the converted character (in t1) is greater than 9, it is not a valid digit.
    
    mul a0, a0, t3      # Multiply the current accumulated value by 10 (move to the next decimal place)
    add a0, a0, t5      # Add the current digit to the accumulated result
    # Optimization End - Old Score: 2754, New Score 2578
    
    addi t4, t4, 1      # Move to the next character in the string
    
    j loop_income_from_record  # Repeat the loop until a non-digit character is encountered

# Exit the loop and return the result when non-digit or end of string is reached
ret_income_from_record:
    #nop # ret_income_from_record  !!! CRAZY WHY EFFECT TO SCORE (Branches and ALU)
    #mv a0, t0          # Move the accumulated value in t0 to a0, which will be the return value

#------------- End your  coding  here! -------------------
	ret
############## end of income_from_record #################
