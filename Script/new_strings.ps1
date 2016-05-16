# file name: new_strings.ps1
# usage: search for new string that have been created
# Arguments example: folder_name\*.log,AMQ9202

$folder = $args.get(0)
$files = dir $folder

foreach ($file in $files) {
$logfile_path = $file
$regex = $args.get(1);
$Error.Clear();
if ( $logfile_path -eq $null )
  {
  Write-Host "Message: Can't find ""logfile_path"" argument. Check documentation."
  exit 1
  }
if ( $regex -eq $null )
  {
  Write-Host "Message: Can't find ""regex"" argument. Check documentation."
  exit 1
  }
if ( !$(Test-Path $logfile_path) )
  {
  Write-Host "Message: File $logfile_path not found."
  exit 1
  }
$filename = split-path $logfile_path -leaf
$filenameroot = split-path $logfile_path

write-host "Message: Scanning $logfile_path"
$t = (Get-Childitem env:temp).value
$usage="new";
$regname = [System.Text.RegularExpressions.Regex]::Replace($regex,"[^1-9a-zA-Z_]","_");
$txt=".txt"
$file_path = "$t\$usage-$filename-$regname-$txt"

if ( Test-Path $file_path )
  { $known_rows = get-content $file_path}
else
  { $known_rows = 0 }
$resn = @()
$resl = @()
$matching_rows = get-childitem $logfile_path | select-string -pattern $regex
$total = $matching_rows.Count


if ($Error.Count -ne 0) {
  Write-Host "$($Error[0])"
  exit 1
  }
if ( $total -lt $known_rows ) {
  $known_rows = 0
  $known_rows > $file_path
  }
$new_rows = $total - $known_rows
$total > $file_path

for ( $i = 0 ; $i -le $total; $i++ ) {
  $resn += @($i)
  $resl += @($i) }
$i = 1
$stat = $matching_rows | select linenumber, line | ForEach-Object {
  $resn[$i] = $_.linenumber
  $resl[$i] = $_.line
  $i = $i + 1
  }
if ($new_rows -eq 0)
 {
 write-host "Statistic: $new_rows"
 write-host "Message: No new error has been encountered"
 #exit 0
 }
if ($new_rows -gt 0)
 {
 $lines = @()
 #write-host "Statistic: $new_rows"
 if($new_rows -gt 1)
  {
  for ( $i = 1 ; $i -le $new_rows; $i++ ) 
   {
   $lines += "<br/>"
   $lines += $resl[$resl.Count - $i]
   $lines += ";"
   }
  write-host "Message: AMQ9202 Error has been encountered"
  write-host "Statistic: 1"
  #exit 0
  }
 else
  {
  $line = $resl[$resl.Count - 1]
  write-host "Message: AMQ9202 Error has been encountered"
  write-host "Statistic: 1"
  #exit 0
  }
 }
 }