#COSC 274
#Project 3 - Digital Cash
#Brad Squillets and Lev Berzon-Kozlov

[int32[]]$temp = Get-Content -path Output/OpenedMoneyOrderForBank.txt
[int]$temp2 = $temp[1]

$test = Test-Path -path Output/Spent_Money_Orders/$temp2.txt
if($test -match "False")
	{
		#new-item Output/SpentMoney_Orders/$temp2.txt -ItemType file
		$temp > Output/Spent_Money_Orders/$temp2.txt
		echo "Money order has been deposited"
	}
else { echo "THIS MONEY ORDER HAS ALREADY BEEN DEPOSITED!!" }
pause