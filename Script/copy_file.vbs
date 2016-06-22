Const SourceFolder = "H:\Data\*"
Dim DestinationFolder, dt, dd, mm, yy, hh, mi, ss

DestinationFolder = "Z:\Data KT\Copy_"
dt=now
dd=day(dt)
mm=month(dt)
yy=year(dt)
hh=hour(dt)
mi=minute(dt)
ss=second(dt)
DestinationFolder = DestinationFolder & dd & "_" & mm & "_" & yy & "_" & hh & "h_" & mi & "m_" & ss & "s"

' Create new destination folder
Set fso = CreateObject("Scripting.FileSystemObject")
	If (fso.FolderExists(DestinationFolder)) Then
		wscript.quit(0)		
	Else
		FSO.CreateFolder(DestinationFolder)
	End If
Set fso = Nothing

' Copy to destination folder
Set fso = CreateObject("Scripting.FileSystemObject")
	FSO.CopyFolder SourceFolder, DestinationFolder  
Set fso = Nothing

'wscript.echo(dd & "_" & mm & "_" & yy & "_" & hh & "h_" & mi & "m_" & ss & "s")