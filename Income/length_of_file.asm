length_of_file:
# This student provided function will find length of data 
# read from file the data file (number of characters stored
# in the buffer). Note that this can be found by looking for
# the first null character, i.e. 0x00.
# 
# Parameters: 
#   a1 = bufferAdress holding the file data
#        This is in the data segment called MMIO.
# The length of the text file will have to be returned in
# register a0
#
# Note If you write no code below, the function as is
# will just returns a length of 0 in a0, and nothing else
# will work.

    li a0, 0  # Your code will replace 0 value in a0. 
#--------------- Start your code here ---------------------

    # Initialize counter for length
    li a0, -1          # Initialize counter
    mv t0, a1          # Copy buffer start

loop_length_of_file:
    # nop # loop_length_of_file  !!! CRAZY WHY EFFECT TO SCORE (Branches and ALU)
    lbu t1, 0(t0)                 # Load byte from address a1 into t0
    addi t0, t0, 1                # Move to the next byte in the file
    addi a0, a0, 1                # Increment the length counter
    bnez t1, loop_length_of_file  # Repeat the loop

#---------------- End your code here ----------------------
	ret
############## End of length_of_file#######################
