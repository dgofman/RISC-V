# maxIncome finds the record with the maximum income from the file
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

maxIncome:
	#if empty file, return 0 for both a0, a1
	bnez a1, maxIncome_fileNotEmpty ###F### maxIncome Function
	li a0, 0
	ret

maxIncome_fileNotEmpty:	
# ----------Begining of student code---------
    .eqv SIZE_20,   20            # Set constant for 24-byte register saving space

    addi sp, sp, -SIZE_20
    sw ra, 0(sp)
    sw s0, 4(sp)  # Base pointer
    sw s1, 8(sp)  # Record count
    sw s2, 12(sp) # Current max value
    sw s3, 16(sp) # Current max address

    mv s0, a0     # Store base address
    mv s1, a1     # Store record count

    # Initialize with first record
    addi a0, s0, 4
    jal income_from_record
    mv s2, a0          # Initial max value
    mv s3, s0          # Initial max address

    # Setup loop for remaining records
    li t0, 1           # Records processed counter
    addi t1, s0, 8     # Current record pointer

max_loop:
    bge t0, s1, max_done  # All records processed
    
    addi a0, t1, 4     # Get income pointer
    jal income_from_record
    
    # Compare and update max
    ble a0, s2, skip_max_update
    mv s2, a0          # New max value
    mv s3, t1          # New max address
skip_max_update:
    
    addi t0, t0, 1     # Increment counter
    addi t1, t1, 8     # Next record
    j max_loop

max_done:
    mv a0, s3          # Return max address
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    addi sp, sp, SIZE_20
 
#     #nop # maxIncome_fileNotEmpty  !!! CRAZY WHY EFFECT TO SCORE (Branches and ALU)
#   
#     # Define constants for max/min mode and register size
#     .eqv FIND_MAX,  1             # Set constant for FIND_MAX mode
#     .eqv FIND_MIN, -1             # Set constant for FIND_MIN mode
#     .eqv SIZE_4,    4             # Set constant for 4-byte register saving space
#     .eqv SIZE_32,   32            # Set constant for 32-byte register saving space
#   
#     # Save return address (ra) and set up the stack space
#     addi sp, sp, -SIZE_4  # Adjust stack pointer by 4 bytes for saving ra
#     sw ra, 0(sp)          # Save return address to the stack
#   
#     li a2, FIND_MAX       # Set mode to FIND_MAX (search for maximum income)
#     jal shared_MinMax     # Call shared logic to find the max income
#   
#     lw ra, 0(sp)          # Restore the return address (ra) from the stack
#     addi sp, sp, SIZE_4   # Adjust stack pointer back (restore it)
#     ret                   # Return the address of the record with the maximum income
#   
#
# Shared Helper Function: shared_MinMax (find extreme value - max or min)
# Arguments:
#   a0 = base address of records
#   a1 = number of records
#   a2 = mode (1 for max, -1 for min)
# Returns:
#   a0 = address of stock name pointer with extreme value
#
# shared_MinMax:
#     #nop # maxIncome_fileNotEmpty  !!! CRAZY WHY EFFECT TO SCORE (Branches and ALU)
#
#     # Because we have a limited number of saved registers from s0 to s7, and all are used in the lab4_testbench_rv32_rev1.asm file,
#     # we need to use the stack pointer (sp) to temporarily save and restore registers across function calls.
#     # Registers s0 to s11 are preserved (callee-saved) across function calls, and modifying these registers without saving
#     # them could lead to errors. Below is an example where these registers are checked for integrity in the lab4_testbench_rv32_rev1.asm file:
#     # 
#     # bne t1, s8, ERROR_S_REG   # Check if s8 has been corrupted
#     # bne t1, s9, ERROR_S_REG   # Check if s9 has been corrupted
#     # bne t1, s10, ERROR_S_REG  # Check if s10 has been corrupted
#     # bne t1, s11, ERROR_S_REG  # Check if s11 has been corrupted
#  
#     # Allocate space for saved registers (32 bytes for 8 registers)
#     addi sp, sp, -SIZE_32 # Adjust stack pointer (32 bytes for saving registers)
#     sw ra, 0(sp)                  # Save return address (ra)
#     sw s0, 4(sp)                  # Save s0 register (base address of records)
#     sw s1, 8(sp)                  # Save s1 register (number of records)
#     sw s2, 12(sp)                 # Save s2 register (current extreme value)
#     sw s3, 16(sp)                 # Save s3 register (comparison mode)
#     sw s4, 20(sp)                 # Save s4 register (current extreme address)
#     sw s5, 24(sp)                 # Save s5 register (loop counter)
#     sw s6, 28(sp)                 # Save s6 register (current record pointer)
#
#     # Initialize saved registers for comparison
#     mv s0, a0             # s0 = base address of records
#     mv s1, a1             # s1 = number of records
#     mv s3, a2             # s3 = comparison mode (1 for max, -1 for min)
#
#     # Get income for the first record and initialize extreme values
#     addi a0, s0, 4        # Get address of income pointer for first record
#     jal income_from_record # Call to income_from_record to get the income
#     mv s2, a0             # Store the first income in s2 as current extreme value
#     mv s4, s0             # Store the first record's address in s4 (current extreme address)
#
#     li t0, 1              # Initialize loop counter t0 to 1 (starting from 2nd record)
#     beq s1, t0, shared_MinMax_done # If only one record, skip the loop
#
#     # Initialize loop counter and current record pointer
#     li s5, 1              # s5 = loop counter (start from the second record)
#     addi s6, s0, 8        # s6 = current record pointer (start at second record)
#
# shared_MinMax_loop:
#     #nop # shared_MinMax_loop  !!! CRAZY WHY EFFECT TO SCORE (Branches and ALU)
#
#     addi a0, s6, 4        # Get address of income pointer (move by 4 to get the income)
#     jal income_from_record # Call to income_from_record to get the income
#
#     # Perform the comparison to check for max or min
#     sub t0, a0, s2         # Compare current income (a0) with extreme (s2)
#
#     #li t2, FIND_MAX        # Load FIND_MAX constant into t2
#     #beq s3, t2, shared_Max # If mode is FIND_MAX (max), check for maximum value
#
#     #li t2, FIND_MIN       # Load FIND_MIN constant into t2
#     #beq s3, t2, shared_Min # If mode is FIND_MIN (min), check for minimum value
#
#     # Optimization Begin
#     mul t0, t0, s3          # Multiply the comparison result (t0) by the comparison mode (s3, which is either 1 for max or -1 for min)
#                             # This unifies the comparison logic: if mode is FIND_MAX (1), a positive result indicates a larger value;
#                             # if mode is FIND_MIN (-1), a negative result indicates a smaller value.
#     blez t0, shared_MinMax_next  # If the result is less than or equal to 0 (i.e., no update for max or min), jump to the next record.
#     mv s2, a0               # If the current income is extreme (larger or smaller depending on mode), update the extreme value (s2).
#     mv s4, s6               # Update the extreme record address (s4) to the current record's address (s6).
#     # Optimization End - Old Score: 2449, New Score 2396
#
#shared_Max:
#    #nop # shared_Max
#    
#    bgtz t0, shared_MinMaxUpdate # Check for maximum value
#    j shared_MinMax_next         # Continue to next record if no update
#    
#shared_Min:
#    nop # shared_Min
#
#    bltz t0, shared_MinMaxUpdate # Check for minimum value
#    j shared_MinMax_next         # Continue to next record if no update
#
#shared_MinMaxUpdate:
#    nop # shared_MinMaxUpdate
#
#    mv s2, a0             # Update extreme value with the current income
#    mv s4, s6             # Update extreme address to the current record pointer
#
# shared_MinMax_next:
#     #nop # shared_MinMax_next  !!! CRAZY WHY EFFECT TO SCORE (Branches and ALU)
#
#     addi s5, s5, 1        # Increment loop counter
#     addi s6, s6, 8        # Move to the next record (next pair of pointers)
#     blt s5, s1, shared_MinMax_loop # Loop until all records are checked
#
# shared_MinMax_done:
#     #nop # shared_MinMax_done  !!! CRAZY WHY EFFECT TO SCORE (Branches and ALU)
#
#     mv a0, s4             # Return the extreme record's address (company name pointer)
#
#     # Restore saved registers
#     lw ra, 0(sp)          # Restore return address (ra)
#     lw s0, 4(sp)          # Restore s0 (base address of records)
#     lw s1, 8(sp)          # Restore s1 (number of records)
#     lw s2, 12(sp)         # Restore s2 (current extreme value)
#     lw s3, 16(sp)         # Restore s3 (comparison mode)
#     lw s4, 20(sp)         # Restore s4 (current extreme address)
#     lw s5, 24(sp)         # Restore s5 (loop counter)
#     lw s6, 28(sp)         # Restore s6 (current record pointer)
#     addi sp, sp, SIZE_32  # Restore stack pointer (adjust by 32 bytes)

#---------- End student code here------------
	ret

