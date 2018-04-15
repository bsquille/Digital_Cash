#COSC 274
#Project 3 - Digital Cash
#Brad Squillets and Lev Berzon-Kozlov

#Constants
[int]$e = 29
[int]$n = 571
[int]$d = 59
echo "Enter amount of money for money order"
[int]$Amount = Read-Host
echo "Enter your ID"
[int]$ID = Read-Host
[int]$Inverse = -1

#Random Numbers
[int]$R11 = Get-Random -minimum 1 -maximum 99
[int]$R12 = Get-Random -minimum 1 -maximum 99
[int]$R21 = Get-Random -minimum 1 -maximum 99
[int]$R22 = Get-Random -minimum 1 -maximum 99
[int]$R111 = Get-Random -minimum 1 -maximum 99
[int]$R112 = Get-Random -minimum 1 -maximum 99
[int]$S111 = Get-Random -minimum 1 -maximum 99
[int]$S112 = Get-Random -minimum 1 -maximum 99
[int]$R121 = Get-Random -minimum 1 -maximum 99
[int]$R122 = Get-Random -minimum 1 -maximum 99
[int]$S121 = Get-Random -minimum 1 -maximum 99
[int]$S122 = Get-Random -minimum 1 -maximum 99
[int]$R211 = Get-Random -minimum 1 -maximum 99
[int]$R212 = Get-Random -minimum 1 -maximum 99
[int]$S211 = Get-Random -minimum 1 -maximum 99
[int]$S212 = Get-Random -minimum 1 -maximum 99
[int]$R221 = Get-Random -minimum 1 -maximum 99
[int]$R222 = Get-Random -minimum 1 -maximum 99
[int]$S221 = Get-Random -minimum 1 -maximum 99
[int]$S222 = Get-Random -minimum 1 -maximum 99
[int]$K1 = Get-Random -minimum 1 -maximum 99
[int]$K2 = Get-Random -minimum 1 -maximum 99

#Secret Splitting of generated numbers from above.
[int]$S11 = $R11 -bxor $ID
[int]$S12 = $R12 -bxor $ID
[int]$S21 = $R21 -bxor $ID
[int]$S22 = $R22 -bxor $ID

echo "##Secret Splitting Complete $S11 $S12 $S21 $S22##"

#Bit commitment
[int32[]]$I11L = ($R11 -bxor $R111 -bxor $R112), $R111
[int32[]]$I11R = ($S11 -bxor $S111 -bxor $S112), $S111
[int32[]]$I12L = ($R12 -bxor $R121 -bxor $R122), $R121
[int32[]]$I12R = ($S12 -bxor $S121 -bxor $S122), $S121
[int32[]]$I21L = ($R21 -bxor $R211 -bxor $R212), $R211
[int32[]]$I21R = ($S21 -bxor $S211 -bxor $S212), $S211
[int32[]]$I22L = ($R22 -bxor $R221 -bxor $R222), $R221
[int32[]]$I22R = ($S22 -bxor $S221 -bxor $S222), $S221

[int32[]]$I11 = $I11L + $I11R
[int32[]]$I12 = $I12L + $I12R
[int32[]]$I21 = $I21L + $I21R
[int32[]]$I22 = $I22L + $I22R

echo "`n##Bit Commitment Complete##"
echo "$I11L"
echo "$I11R"
echo "$I12L"
echo "$I12R"
echo "$I21L"
echo "$I21R"
echo "$I22L"
echo "$I22R"

#Take an unused uniqueness string from a file of uniqueness strings
[int32[]]$US1 = Get-Content Uniqueness_Strings.txt -First 1
(Get-Content Uniqueness_Strings.txt | Select-Object -Skip 1) | Set-Content Uniqueness_Strings.txt

[int32[]]$MO1 = $Amount
$MO1 += $US1
$MO1 += $I11
$MO1 += $I12
$temp = $MO1
echo $temp > Output/MoneyOrder1.txt

#Take an unused uniqueness string from a file of uniqueness strings
[int32[]]$US2 = Get-Content Uniqueness_Strings.txt -First 1
(Get-Content Uniqueness_Strings.txt | Select-Object -Skip 1) | Set-Content Uniqueness_Strings.txt

[int32[]]$MO2 = $Amount
$MO2 += $US2
$MO2 += $I21
$MO2 += $I22
$temp = $MO2
echo $temp > Output/MoneyOrder2.txt

$K1 > Output/K_Values.txt
$K2 >> Output/K_Values.txt

echo "`nMoney orders have been generated"

pause
