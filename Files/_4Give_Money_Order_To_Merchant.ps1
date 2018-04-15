#COSC 274
#Project 3 - Digital Cash
#Brad Squillets and Lev Berzon-Kozlov

#Constants
[int]$e = 29
[int]$n = 571
[int]$d = 59
[int]$Inverse = -1

[int32[]]$K = Get-Content -path Output/K_Values.txt

[int32[]]$BlindSignedMO = Get-Content -path Output/BlindedSignedMoneyOrder.txt

if ($($K[2] -eq 1)) {
	$K1 = $K[1]
	}
elseif ($($K[2] -eq 2)) {
	$K1 = $K[0]
	}
else { echo "An error occured" }

echo "`nYou unblind the signed money order"
$K1 > PerlInput.txt
$Inverse >> PerlInput.txt
$n >> PerlInput.txt
perl LargeNumberCalc.pl
[int]$InvK1 = Get-Content -path PerlOutput.txt 
$InvK1 > PerlInput.txt
$e >> PerlInput.txt
$n >> PerlInput.txt
perl LargeNumberCalc.pl
$BlFa = Get-Content -path PerlOutput.txt
new-item temp.txt -ItemType file

#For loop unblinding the signed blinded money order
For($i=0; $i -lt 10; $i++) {
	
	
	(($BlindSignedMO[$i] * $BlFa) % $n) >> temp.txt
	
	
	}
[int32[]]$MOSig1 = Get-Content -path temp.txt
Remove-Item temp.txt
new-item temp.txt -ItemType file
For($i=10; $i -lt 20; $i++) {
	(($BlindSignedMO[$i] * $InvK1) % $n) >> temp.txt
}
[int32[]]$MOSig2 = Get-Content -path temp.txt
[int32[]]$MOSig = $($MOSig1) + $($MOSig2)
[int32[]]$temp = $($MOSig)
echo $temp > Output/UnBlindedSignedMoneyOrder.txt
write-host "`nUn-Blinded MO: `nAmount = $($MOSig[0]) `nUniqueness String = $($MOSig[1]) `nI11 = $($MOSig[2..5]) `nI12 = $($MOSig[6..9])"
write-host "Un-Blinded Signature: `n($($MOSig[10..19]))"
Remove-Item temp.txt

[int32[]]$SignedMO = Get-Content -path Output/UnBlindedSignedMoneyOrder.txt

#Merchant is unblinding the signature of the Money Order
For($i=10; $i -lt 20; $i++) {
	$($SignedMO[$i]) > PerlInput.txt
	$e >> PerlInput.txt
	$n >> PerlInput.txt
	perl LargeNumberCalc.pl
	[int]$temp = Get-Content -path PerlOutput.txt
	$temp >> temp.txt
}
[int32[]]$TestSig = Get-Content -path temp.txt
Remove-Item temp.txt

For($i=0; $i -lt 10; $i++) {
	write-host "`n$($SignedMO[$i]) = $($TestSig[$i])"
	if( $($SignedMO[$i]) -eq $($TestSig[$i])) {
		echo "Valid"
		}
	else { 
		echo "INVALID SIGNATURE CALL 911" > Output/_CALL_911.txt
		exit
		}
}

echo "`nYou reveal halves"
[int]$NBit1 = Get-Random -minimum 0 -maximum 1
[int]$NBit2 = Get-Random -minimum 0 -maximum 1


#if and elseif statements to reveal halves
if ($Nbit1 -eq 0) {
	[int32[]]$NewIDS1 = $($SignedMO[2,3])
	}
elseif ($Nbit1 -eq 1) {
	[int32[]]$NewIDS1 = $($SignedMO[4,5])
	}
else { echo "An error occurred" }

if ($Nbit2 -eq 0) {
	[int32[]]$NewIDS2 = $($SignedMO[6,7])
	}
elseif ($Nbit2 -eq 1) {
	[int32[]]$NewIDS2 = $($SignedMO[8,9])
	}
else { echo "An error occurred" }

[int32[]]$temp = $SignedMO[0]
$temp += $SignedMO[1]
$temp += $($NewIDS1)
$temp += $($NewIDS2)
echo $temp > Output/OpenedMoneyOrderForBank.txt

pause