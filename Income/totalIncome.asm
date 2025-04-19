
# totalIncome finds the total income from the file
# arguments:
#	a0 contains a pointer to the array of record pointer pairs 
#      location (0x10040000 in our example) 
#      Note your code MUST handle any address value
#	a1: the number of records in the file
# return value:
#    a0: will return the total income 
#        by adding up all the record incomes.
#
# Consider whether this is a leaf or nested function
# Consider what registers you may have to save and restore
# What type of register is best to use and why.
# This function must make calls to the input_from_record function.

# You must make function calls to income_from_record 
# in a loop to obtain the various incomes from your code. 
# This assembly program along with: income_from_record.asm,
#   maxIncome.asm and minIncome.asm all gets
# gets included from lab4_testbench_rev#.asm so 
# reference to label income_from_record is available 
# for your code to use from this file.
# All labels used across all these files should be made unique
# since all the files are included into one file.

# A question for you: Is this a nested or a leaf function?
# Optimize register spills accordingly.

totalIncome:
	bnez a1, totalIncome_fileNotEmpty ###F### totalIncome function
	li a0, 0 # if a1 is 0 return 0 for the total income 
	ret

totalIncome_fileNotEmpty:
#------ Edit this section, starting your code here ---------
    
    #nop # totalIncome_fileNotEmpty  !!! CRAZY WHY EFFECT TO SCORE (Branches and ALU)

    # Because we have a limited number of saved registers from s0 to s7, and all are used in the lab4_testbench_rv32_rev1.asm file,
    # we need to use the stack pointer (sp) to temporarily save and restore registers across function calls.
    # Registers s0 to s11 are preserved (callee-saved) across function calls, and modifying these registers without saving
    # them could lead to errors. Below is an example where these registers are checked for integrity in the lab4_testbench_rv32_rev1.asm file:
    # 
    # bne t1, s8, ERROR_S_REG   # Check if s8 has been corrupted
    # bne t1, s9, ERROR_S_REG   # Check if s9 has been corrupted
    # bne t1, s10, ERROR_S_REG  # Check if s10 has been corrupted
    # bne t1, s11, ERROR_S_REG  # Check if s11 has been corrupted
    
    .eqv SIZE_12, 12
    
    # Prologue: Save the values of registers s9 and s8 (preserved across function calls)
    addi sp, sp, -SIZE_12   # Allocate space for 3 words (12 bytes) on the stack.
    sw s8, 0(sp)            # Save s8 register (accumulator for total income).
    sw s9, 4(sp)            # Save s9 register (current record pointer).
    sw ra, 8(sp)            # Save return address

    # Initialize registers:
    mv s9, a0               # s9 = original array pointer (0x10040000)
    li s8, 0                # s8 = total accumulator (initialize to 0).
    
    # Optimization Begin
    slli t0, a1, 3         # (Shift Left Logical Immediate) instruction shifts the value in a1 (the number of records) by 3 bits to the left.
                           # This is equivalent to multiplying a1 by 8 (since shifting left by 3 bits is like multiplying by 2^3 = 8).
                           # If there are 5 records (a1 = 5), slli t0, a1, 3 results in t0 = 5 * 8 = 40 (the byte offset for the end of the last record).
    add t0, s9, t0         # Adds the value in t0 (the byte offset calculated) to s9 (the base address of the array of record pointers).
    # Optimization End

loop_totalIncome:
    #nop # loop_totalIncome  !!! CRAZY WHY EFFECT TO SCORE (Branches and ALU)

    # Copy exisitng logic from lab4_testbench_rv32_rev1.asm. See: next_record
    addi a0, s9, 4           #*!!!# Add 4 to point to amount pointer, not record name pointer
    jal income_from_record   ## CALL income_from_record ##########################

    # Accumulate the total income:
    add s8, s8, a0          # Add the returned income value to the accumulator (s8).

    # IMPORTANT for array of pointer pairs, to go the next pair increment by 8 
    addi s9, s9, 8          # go to next income pointer (every other one)
    
#    addi a1, a1, -1         # count down
#
#    # Continue looping if there are still records to process.
#    bgtz a1, loop_totalIncome

    # Optimization Begin
    blt s9, t0, loop_totalIncome   # The loop will process records as long as the current pointer s9 is less than the calculated end address t0
    # Optimization End

    # Return the total income:
    mv a0, s8               # Move the accumulated total into a0 (return value).

    # Epilogue: Restore the preserved values back to s9 and s8
    lw s8, 0(sp)            # Restore s8 (accumulated total income).
    lw s9, 4(sp)            # Restore s9 (current record pointer).
    lw ra, 8(sp)            # Restore the return address (ra).
    addi sp, sp, SIZE_12    # Deallocate stack space (restore sp).
    
    #  Optimization - Old Score: 2455, New Score 2449

#------ End your  coding  here! ----------------------------
    ret   # PC = ra

