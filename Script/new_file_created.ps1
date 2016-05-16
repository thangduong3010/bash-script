# filename: new_file_created.ps1
# Usage: search for newly created file within the last 5 minutes
# Arg: foldername

$folder = $args.get(0)
$files = dir $folder
$err1 = "CHET_SERVICE_MESS_*"
$err2 = "CHET_MQException_*"
$err_in_hour = 0
$noerr_in_hour = 0

foreach($file in $files) {
	if ($file -match $err1) {
	$created = $file.CreationTime
	$nowtime = get-date
	if (($nowtime - $created).totalminutes -lt 5) 
    {  
		write-host "Message: file [$file] created within the last 5 minutes"
		write-host "Message: 403 error has been encountered"
		write-host "Statistic: 1"
		$err_in_hour++
	}
   Else
    {  $noerr_in_hour++}
	}
	
	elseif ($file -match $err2) {
	$created = $file.CreationTime
	$nowtime = get-date
	if (($nowtime - $created).totalminutes -lt 5) 
    {  
		write-host "Message: file [$file] created within the last 5 minutes"
		write-host "Message: Cannot call business service"
		write-host "Statistic: 1"
		$err_in_hour++
	}
   Else
    {  $noerr_in_hour++}
	}
	
}
#write-host "err_in_hour = [$err_in_hour]"
#write-host "noerr_in_hour = [$noerr_in_hour]"
if ($err_in_hour -eq 0) {
	write-host "Message: No errors have been encountered within the last 5 minutes"
	write-host "Statistic: $err_in_hour"
}

<#
foreach($file in $files) {
	if ($file -match $err1) {
		write-host "403 error has been encountered. File [$file]"
	}
	elseif ($file -match $err2) {
		write-host "Cannot call business service. File [$file]"
	}
	else {
		write-host "Unknown error"
	}
}
#>