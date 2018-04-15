#COSC 274
#Project 3 - Digital Cash
#Brad Squillets and Lev Berzon-Kozlov

#Constants
[int]$e = 29
[int]$n = 571
[int]$d = 59
[int]$Inverse = -1

[int32[]]$K = Get-Content -path Output/K_Values.txt
[int]$K1 = $K[0]
[int]$K2 = $K[1]

[int32[]]$BMO1 = Get-Content -path Output/BlindedMoneyOrder1.txt
[int32[]]$BMO2 = Get-Content -path Output/BlindedMoneyOrder2.txt

echo "`nBank enters which Money Order to unblind (1 or 2)"
$Rand = Read-Host

if ($Rand -eq 1) {
	$temp = 1
	$temp >> Output/K_Values.txt
	#Using Perl script to calculate large numbers for modulo equations
	$K1 > PerlInput.txt
	$Inverse >> PerlInput.txt
	$n >> PerlInput.txt
	perl LargeNumberCalc.pl
	[int]$InvK1 = Get-Content -path PerlOutput.txt 
	$InvK1 > PerlInput.txt
	$e >> PerlInput.txt
	$n >> PerlInput.txt
	perl LargeNumberCalc.pl

	#Getting blinding factor from Perl
	$BlFa = Get-Content -path PerlOutput.txt
	new-item temp.txt -ItemType file

	#For loop unblinding the blinded money order 1
	For($i=0; $i -lt $BMO1.length; $i++) {
	
	
		(($BMO1[$i] * $BlFa) % $n) >> temp.txt
		
	}
	
	
	
	[int32[]]$BMO1 = Get-Content -path temp.txt
	echo "`nUnblinded Money Order One"
	$temp = $BMO1
	echo $temp > Output/UnBlindedMoneyOrder.txt
	write-host "Un-Blinded MO1: `nAmount = $($BMO1[0]) `nUniqueness String 	= $($BMO1[1]) `nI11 = $($BMO1[2..5]) `nI12 = $($BMO1[6..9])"
	Remove-Item temp.txt
	
	#For loop signing the blinded money order 2
	For($i=0; $i -lt $BMO2.length; $i++) {
	
	
		$($BMO2[$i]) > PerlInput.txt
		$d >> PerlInput.txt
		$n >> PerlInput.txt
		perl LargeNumberCalc.pl
		[int]$temp = Get-Content -path PerlOutput.txt
		$temp >> temp.txt
	
	
	
	}
[int32[]]$Signature = Get-Content -path temp.txt
Remove-Item temp.txt
echo "`nThe Signature is $Signature"
[int32[]]$BMO2Sig = $($BMO2) + $Signature
[int32[]]$temp = $($BMO2Sig)
echo $temp > Output/BlindedSignedMoneyOrder.txt
echo "`nBlinded Signed Money Order Two: `nAmount = $($BMO2Sig[0]) `nUniqueness String = $($BMO2Sig[1]) `nI21 = $($BMO2Sig[2..5]) `nI22 = $($BMO2Sig[6..9]) `nSignature: ($($BMO2Sig[10..19]))"
}	

elseif ($Rand -eq 2) {
	$temp = 2
	$temp >> Output/K_Values.txt
	#Using Perl script to calculate large numbers for modulo equations
	$K2 > PerlInput.txt
	$Inverse >> PerlInput.txt
	$n >> PerlInput.txt
	perl LargeNumberCalc.pl

	[int]$InvK2 = Get-Content -path PerlOutput.txt 
	$InvK2 > PerlInput.txt
	$e >> PerlInput.txt
	$n >> PerlInput.txt
	perl LargeNumberCalc.pl

	#Getting blinding factor from Perl
	$BlFa = Get-Content -path PerlOutput.txt
	new-item temp.txt -ItemType file

	#For loop unblinding the blinded money order 2
	For($i=0; $i -lt $BMO2.length; $i++) {
	
	
		(($BMO2[$i] * $BlFa) % $n) >> temp.txt
	
	}
	
	
	[int32[]]$BMO2 = Get-Content -path temp.txt
	echo "`nUnblinded Money Order Two"
	$temp = $BMO2
	echo $temp > Output/UnBlindedMoneyOrder.txt
	write-host "`nUn-Blinded MO2: `nAmount = $($BMO2[0]) `nUniqueness String = $($BMO2[1]) `nI21 = $($BMO2[2..5]) `nI22 = $($BMO2[6..9])"
	Remove-Item temp.txt
	
	#For loop signing the blinded money order 1
		For($i=0; $i -lt $BMO1.length; $i++) {
			$($BMO1[$i]) > PerlInput.txt
			$d >> PerlInput.txt
			$n >> PerlInput.txt
			perl LargeNumberCalc.pl
			[int]$temp = Get-Content -path PerlOutput.txt
			$temp >> temp.txt
		}
	[int32[]]$Signature = Get-Content -path temp.txt
	Remove-Item temp.txt
	echo "`nThe Signature is $Signature"
	[int32[]]$BMO1Sig = $BMO1 + $Signature
	[int32[]]$temp = $($BMO1Sig)
	echo $temp > Output/BlindedSignedMoneyOrder.txt
	echo "`nBlinded Signed Money Order One: `nAmount = $($BMO1Sig[0]) `nUniqueness String = $($BMO1Sig[1]) `nI11 = $($BMO1Sig[2..5]) `nI12 = $($BMO1Sig[6..9]) `nSignature: ($($BMO1Sig[10..19]))"
}

else { echo "Invalid Input" }
pause