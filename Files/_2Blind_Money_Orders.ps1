#COSC 274
#Project 3 - Digital Cash
#Brad Squillets and Lev Berzon-Kozlov

#Constants
[int]$e = 29
[int]$n = 571
[int]$d = 59

[int32[]]$K = Get-Content -path Output/K_Values.txt
[int]$K1 = $K[0]
[int]$K2 = $K[1]

#Blinding the Money Orders

#Using Perl script to calculate large numbers for modulo equations 
$K1 > PerlInput.txt
$e >> PerlInput.txt
$n >> PerlInput.txt
perl LargeNumberCalc.pl

#Blinding Money Order 1
[int]$BlFa = Get-Content -path PerlOutput.txt

[int32[]]$MO1 = Get-Content -path Output/MoneyOrder1.txt
write-host "`nMO1: `nAmount = $($MO1[0]) `nUniqueness String = $($MO1[1]) `nI11 = $($MO1[2..5]) `nI12 = $($MO1[6..9])"
new-item temp.txt -ItemType file
For($i=0; $i -lt $MO1.length; $i++) {
	(($MO1[$i] * $BlFa) % $n) >> temp.txt
}
[int32[]]$BMO1 = Get-Content -path temp.txt
echo "`nBlinded first money order"
$temp = $BMO1
echo $temp > Output/BlindedMoneyOrder1.txt
write-host "Blinded MO1: `nAmount = $($BMO1[0]) `nUniqueness String = $($BMO1[1]) `nI11 = $($BMO1[2..5]) `nI12 = $($BMO1[6..9])"
Remove-Item temp.txt

#Using Perl script to calculate large numbers for modulo equations
$K2 > PerlInput.txt
$e >> PerlInput.txt
$n >> PerlInput.txt
perl LargeNumberCalc.pl
#Blinding Money Order 2
[int]$BlFa = Get-Content -path PerlOutput.txt
[int32[]]$MO2 = Get-Content -path Output/MoneyOrder2.txt
write-host "`nMO2: `nAmount = $($MO2[0]) `nUniqueness String = $($MO2[1]) `nI21 = $($MO2[2..5]) `nI22 = $($MO2[6..9])"
new-item temp.txt -ItemType file
For($i=0; $i -lt $MO2.length; $i++) {
	(($MO2[$i] * $BlFa) % $n) >> temp.txt
}
[int32[]]$BMO2 = Get-Content -path temp.txt
echo "`nBlinded second money order"
$temp = $BMO2
echo $temp > Output/BlindedMoneyOrder2.txt
write-host "`nBlinded MO2: `nAmount = $($BMO2[0]) `nUniqueness String = $($BMO2[1]) `nI21 = $($BMO2[2..5]) `nI22 = $($BMO2[6..9])"
Remove-Item temp.txt

echo "`n##Blinding Money Orders Complete##"

pause