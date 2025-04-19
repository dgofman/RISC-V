Income Calculation Program

-----------
DESCRIPTION

In this lab, the program processes a file containing a list of records, where each record holds a stock's name and its income. The program will determine the stock with the highest income and the stock with the lowest income. It will also calculate the total income across all records. The program works with a file buffer and calculates income statistics for each stock.

FILES
-----------
lab4_testbench_rv32_rev#.asm
This is the main testbench program you will run upon completion of all coding in Lab4. This file is initially provided such that if you run it as it is (with the other .asm files in the same directory), you will still get partially correctly generated output.

allocate_file_record_pointers.asm
This file contains a function that creates an array in memory of pointer pairs. These pointer pairs indicate 1) the location of the start of a string corresponding to the stock name and 2) the start of a location containing the stock price for each and every record/entry coming from the data.csv file.

macros_rv32_rev#.asm
This file contains useful macros, mostly to do I/O. It uses and modifies the a# registers. Become familiar with these functions as they will be helpful during development.

length_of_file.asm
This file contains a function to find the total amount of data bytes in the CSV file.

income_from_record.asm
This file contains the code that retrieves the income of a stock from a record. The function income_from_record extracts the income value associated with the stock and returns it for comparison and accumulation.

totalIncome.asm
This file contains code that computes the total income across all records in the file. The function totalIncome sums up the income from each stock and returns the total.

maxIncome.asm
This file contains the function maxIncome, which determines the record with the highest income. It uses a helper function shared_MinMax to find the record with the maximum income by comparing the income of each record.

minIncome.asm
This file contains the function minIncome, which determines the record with the lowest income. Like maxIncome, it uses the shared_MinMax function to compare the income values and identify the record with the minimum income.

data.csv
This file contains the stock records used by the program. Each record consists of two values: the stock name (a string) and the corresponding stock price (a floating-point number). The records are stored as pairs of pointers in memory, where each pointer in the pair refers to the location of the stock name and the stock price.

------------
INSTRUCTIONS
This program is intended to be run using the RARS Simulator. To run the program, follow these steps:

Open the testbench_rv32_rev1.asm file in the RARS Simulator (java -jar RARS.jar).
Assemble the code by clicking on Assemble.
Run the program by clicking on Go or pressing F5.

Or open a command prompt and run this command:
java -jar RARS.jar testbench_rv32_rev1.asm.asm

Output:
Printing file contents...
========================
Kruger Industrial Smoothing,365
Kramerica,0
Vandelay Industries,500
Pendant Publishing,100
J. Peterman Catalog,42
========================
Size of file data (in bytes): 119
income records: 365 0 500 100 42
Total income garnered from all stocks: $1007
Stock name with maximum income:Vandelay Industries
Stock name with minimum income:Kramerica