###
# Useful to have: Powershell community extensions https://github.com/Pscx/Pscx 

# Install system-wide
Install-Module Pscx

#Install for current user
Install-Module Pscx -Scope CurrentUser -AllowClobber
###

###
# Language features
$hashmap = @{key1=value1 ; key2=value2}
$list = item1,item2,item3
$hashmap += $appended_hashmap

Foreach ($i in $collection){
	Do-Something
}

Get-List | Select-Object Property,{$_.hmap.key}
Get-List | Where-Object {Property -eq value}
Get-List | Where-Object {$_.hmap.key -eq value}
###


# Report cert expiry on remote machines
$days = 30 # only expiries up to this many days in the future
foreach ($s in "server1","server2"){
    Enter-PSSession -ComputerName $s
    Get-ChildItem cert: -Recurse -ExpiringInDays $days| Select-Object @{Name="Expires in (Days)";Expression={($_.NotAfter).subtract([DateTime]::Now).days}},Issuer,Subject | Sort "Expires in (Days)"
    Exit-PSSession
}

# something like a pgrep (but with objects)
ps | Where-Object ProcessName -Like "cn*"

# create a resource group $ResGrp
$ResGrp = New-AzureRmResourceGroup $resourceGroupName -location 'East US'