#Set-ExecutionPolicy unrestricted -force
$test = @(Get-Content -Path c:\corona\script\servers.txt) 

 Write-Host "Enter the port number to check"
[int]$portno= Read-Host


write-Host -Prompt "<----- Test-Connection Start ----->`n" -ForegroundColor cyan
Start-Sleep -Milliseconds 300
 
Foreach ($t in $test) 
{ 
 
    $source = $t.Split('/')[0]
    
 
  try   {
    write-Host "<----- Test-Connection Start ----->" 

    write-Host "Connecting to $source on port $portno"

    $test  = Test-NetConnection -ComputerName $source -Port $portno
    if ($test:PingSucceeded -eq $true){
         
      write-Host "PingSucceeded Is Alive $source port $portno <-Connected->`n" -ForegroundColor green
    
 
}else {
     write-Host "PingSucceeded Not i´m dead $source port $portno <-Failed->`n" -ForegroundColor red
} 

  if($test:TcpTestSucceeded -eq $true){
    
    write-Host "TcpTestSucceeded Is Alive $source port $portno <-Connected->`n" -ForegroundColor green
    
 
}else {
     write-Host "TcpTestSucceeded Not i´m dead $source port $portno <-Failed->`n" -ForegroundColor red
} 
} 
  catch [Exception] 
  { 
    Write-Host $_.Exception.GetType().FullName 
    Write-Host $_.Exception.Message 
  } 
 
  write-Host -Prompt "<----- Test-Connection Finish ----->`n" -ForegroundColor cyan
Start-Sleep -Seconds 10
} 
