README for Project 3 - Digital Cash

Authors - Lev Berzon-Kozlov and Brad Squillets

Version - 1.0

Contact information - lberzonk@emich.edu or bsquille@emich.edu




Dependencies - Must have Powershell 5.0 or higher installed. Can be installed at https://github.com/PowerShell/PowerShell. Must have Perl installed on machine. For Linux or Mac machines,
make sure that Perl is up to date. For Windows machines, Perl can be found at https://www.perl.org/get.html. Perl is required for calculating large exponents and modulo. PowerShell can not handle the large expontents being used in this program. 




Program Description  - This program will allow a user to implement a demonstration of the Digital Cash concept as presented by protocol number 4, described in [SCHN96], p. 142. Program could be run by right clicking the Digital_Cash.ps1 file from explorer.

The program allows you to choose between five different parts. Part one will generate your money orders. You may modify these under {Files/Output/}. Step one will output two money orders and the 'K' values used for calculations in future steps. The first line of the money order is the amount of money, the second line is the uniqueness string, lines 3 through 10 are the identity strings from left to right. For the signed money orders, lines 11 through 20 will be the signature. The uniqueness string is pulled from a list of un-used integers. Once a uniqueness string is assigned to a money order, it is removed from the list to prevent the same uniqueness string from being assigned to multiple money orders. 

Part two blinds the money orders that you generated. If you modified the generated money orders, this will blind the modified version without an issue. As long as each integer is on its own line, and there is a total of ten integers, in order of amount, uniqueness string, and eight identity strings from left to right.

Part three allows the bank to choose one of the two money orders, to un-blind. Once one of the money orders are unblinded, the Bank will sign the blinded money order for you to spend at a merchant. Whichever money order the bank chooses, a variable will be sent to the K_Values list so that we know which randomly generated 'K' value to use for part four. 

Part four allows you to spend the money order with a merchant. The merchant will verify the siganture. If the signature is found to be invalid, a file called "_CALL911" will be created in the output file and the program will immediately exit to avoid the user spending the fake money order. If the signature is valid, the user will reveal random halves of their money orders identity strings. The merchant then keeps the money order to deposit to the bank.

Part five, the merchant deposits the money order in the bank. If the same money order has already been deposited, the bank will inform the merchant than the money order has already been deposited, by verifying the uniqueness string, and the merchent will not be able to deposit it twice. The deposited money orders will go into a directory called "Spent_Money_Orders". This is why it is important that two money orders do not randomly end up with the same uniqueness string, because if they do, only one will be able to be deposited. 




DISCLAIMER - If any part of the program, or files are modified in any way, unforseen errors may occur. Please modify the program and files at your own risk. This program was developed for demonstration purposes only. The demo is shown by going through the program step by step, in order one through five. This will automatically generate the files required for the following steps. You may modify the files once they are generated for proof of concept, however we are not liable for any errors that may occur. 




Date - 04/15/2018


Copyright (C) <2018>  <Lev Berzon-Kozlov and Brad Squillets>

