cd Files/
[int]$loop = -1
	While ($loop -ne 0) {
	
	echo "1 - Generate two new money orders"
	echo "2 - Blind your money orders"
	echo "3 - Bank un-blinds one money order and signs the other"
	echo "4 - Spend your money order with a merchant"
	echo "5 - Merchant deposits money order to the bank"
	echo "0 - Exit"
	
	[int]$temp = read-host

	Switch ($temp) {
		1 { 
			.\_1Generate_Money_Orders.ps1
			Break
		}
		2 {
			.\_2Blind_Money_Orders.ps1
			Break
		}
		3 {
			.\_3UnBlind_And_Sign_Money_Orders.ps1
			Break
		}
		4 {
			.\_4Give_Money_Order_To_Merchant.ps1
			Break
		}
		5 {
			.\_5Merchant_Takes_MO_To_Bank.ps1
			Break
		}
		0 { $loop = 0 }
		default { echo "Invalid Input" }	
	}
	cls
}
		