# Install Azure modules
Install-Module AzureRM -AllowClobber

# Login to Azure
Login-AzureRmAccount

# List all resource groups (their names)
Find-AzureRmResourceGroup | Select-Object Name

#List all resource groups and their tags
Find-AzureRmResourceGroup | Select-Object Name,Tags


#Add one or more tags ($newtags) to one or more RGs ($rgs)
$newtags = @{tagname1="tag content 1";tagname2="tag content 2"}
$rgs = "resgroup1","resgroup2","resgroup3"
Foreach ($r in $rgs) {
    $tags = (Get-AzureRmResourceGroup -Name $r).Tags
    $tags += $newtags
    Set-AzureRmResourceGroup -Tag $tags -Name $r
} 



