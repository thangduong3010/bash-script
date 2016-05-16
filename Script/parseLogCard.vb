' arg: /p:"\\10.36.31.11\Logs\LogWebServiceCNTT" /m:50000 +ORA -ORA-1403 -ORA-1405

Set objArgs = Wscript.Arguments
Dim strArg, strIncl, strExcl, iCount
iCount = 0

For Each strArg in objArgs
    If UCase(Left(strArg, 3)) = "/P:" Then
        prefixPath = Mid(strArg, 4)
    End If

    If UCase(Left(strArg, 3)) = "/M:" Then
        iMinDif = CLng(Mid(strArg, 4))
        'wscript.echo "interval time " & iMinDif
    End If
    
    If Left(strArg,1)="+" Then
        strIncl = Mid(strArg,2)
    End If 
    
    If Left(strArg,1)="-" Then
        strExcl = strExcl & ";" & Mid(strArg,2)
    End If 
    
Next

wscript.echo "Include:" & strIncl
wscript.echo "Exclude:" & strExcl

iMonth=DatePart("m",Now())
iYear = DatePart("yyyy",Now())

Set fso = CreateObject("Scripting.FileSystemObject")
strFullPath = prefixPath & "\Nam_" & iYear & "\Thang_" & iMonth
if (fso.FolderExists(strFullPath)) then
	'Wscript.Echo "Folder exists " & strFullPath
else
	Wscript.Echo "Message: Folder doesn't exists " & strFullPath
	WScript.Echo "Statistic: -1"
	Wscript.Quit(1)
end if
wscript.echo "Scanning:" & strFullPath 
Set objFolder = fso.GetFolder(strFullPath)
Set objFileColl = objFolder.Files


For each objFile In objFileColl
    d=DateDiff("n", objFile.DateLastModified, Now) 
    'wscript.echo objFile.Name & "--" & d
    If (objFile.Type = "Text Document") and (d <=iMinDif ) Then
        wscript.echo "Parsing file:" & objFile.Name 
        Set objText = objFile.OpenAsTextStream(1)
        Do While objText.AtEndOfStream <> True
            TextLine = objText.ReadLine
            p=InStr(TextLine, "-->") 
            If p> 1 Then
                p2=InStr(p, TextLine,":")
                If p2>1 Then
                    errCode=Mid(TextLine,p+4,p2-p-4)
                    Wscript.echo "-->" & errCode
                    If InStr(errCode, strIncl)>0 and InStr(strExcl, errCode)<=0 Then
                        iCount = iCount+1
                    End If
                End If
            End If
        Loop
    End If

Next

If iCount <> 0 then
	Wscript.Echo "Message:Pattern " & strIncl & " occurs " & iCount & " times"
	WScript.Echo "Statistic: "& iCount
Else
        Wscript.Echo "Message: No ORA- errors found"
	Wscript.Echo "Statistic: "& iCount
End If