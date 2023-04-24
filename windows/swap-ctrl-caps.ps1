# This PowerShell script swaps Ctrl anv Caps Lock.
# See https://superuser.com/a/1455544/11302
# and https://learn.microsoft.com/en-us/windows-hardware/drivers/hid/keyboard-and-mouse-class-drivers#example-1
#
# To run:
# - open PowerShell with a right-click and admin rights
# - run: powershell -executionpolicy bypass -File .\swap-ctrl-caps.ps1

$SimplePairs = @(
0x3a, 0x1d # CapsLock > L Ctrl
0x1d, 0x3a # L Ctrl > CapsLock
)
$ExtendedPairs = @(
# 0x5d, 0xe0, 0x1d, 0xe0 # ContextMenu > R Ctrl
)
$ByteCount = 2 * $SimplePairs.Length + $ExtendedPairs.Length + 16
$Remap = New-Object -TypeName byte[] -ArgumentList $ByteCount
$Remap[8] = $SimplePairs.Length/2 + $ExtendedPairs.Length/4 + 1
For ($i = 0 ; $i -lt $SimplePairs.Length ; $i += 2) {
   $Remap[$i * 2 + 12] = $SimplePairs[$i]
   $Remap[$i * 2 + 14] = $SimplePairs[$i + 1]
}
For ($i = 0 ; $i -lt $ExtendedPairs.Length ; $i += 4) {
   $Offset = $SimplePairs.Length * 2
   $Remap[$i + 12 + $Offset] = $ExtendedPairs[$i]
   $Remap[$i + 13 + $Offset] = $ExtendedPairs[$i + 1]
   $Remap[$i + 14 + $Offset] = $ExtendedPairs[$i + 2]
   $Remap[$i + 15 + $Offset] = $ExtendedPairs[$i + 3]
}
$args = @{
Path  = 'HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layout'
Name  = 'ScanCode Map'
Value = $Remap
Force = $True
}
New-ItemProperty @args
