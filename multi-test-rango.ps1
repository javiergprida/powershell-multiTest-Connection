Set-ExecutionPolicy unrestricted -force
$test = @(Get-Content -Path c:\script\servers.txt) 

 Write-Host "Enter the port number to check"
[int]$portno= Read-Host


write-Host -Prompt "<----- Test-Connection Start ----->`n" -ForegroundColor cyan
Start-Sleep -Milliseconds 300
 
Foreach ($t in $test) 
{ 
 
    $source = $t.Split('/')[0]

    [int]$ipr = $t.Split('/')[1]

    [int]$ipl = $source.Split('.')[3]

    [int]$range = $ipr + $ipl  
    
 
  try   {
  for ($i = $ipl ;$i -le $range; $i++){
    $ipfinal = $source.Split('.')[0]+"."+$source.Split('.')[1]+"."+$source.Split('.')[2]
    write-Host "<----- Test-Connection Start ----->" 

    write-Host "Connecting to $ipfinal.$i on port $portno"

    $test  = Test-NetConnection -ComputerName $ipfinal"."$i -Port $portno
    if ($test:PingSucceeded -eq $true){
        if($test:TcpTestSucceeded -eq $true){
    
        write-Host " Is Alive $ipfinal.$i port $portno <-Connected->`n" -ForegroundColor green
        }
     
    }else {
         write-Host "Not i´m dead $ipfinal.$i port $portno <-Failed->`n" -ForegroundColor red
    } 
     
  } 
  }
  
  catch [Exception] 
  { 
    Write-Host $_.Exception.GetType().FullName 
    Write-Host $_.Exception.Message 
  } 
 
  Write-Host "<-Connected->`n" -ForegroundColor green
} 

write-Host -Prompt "<----- Test-Connection Finish ----->`n" -ForegroundColor cyan
Start-Sleep -Seconds 10
