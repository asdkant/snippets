## List Resource Groups
function lsrg($pattern){
    Find-AzureRmResourceGroup | Where-Object Name -like $pattern | Select-Object name
}

## List RGs with a given tag
function lsrg-tag($pattern, $tag) {
    Find-AzureRmResourceGroup | Select-Object Name,Tags | Where-Object Name -Like $pattern | Where-Object {$_.Tags.$tag -ne $null}
}

## List RGs without a given tag
function lsrg-notag($pattern, $tag) {
    Find-AzureRmResourceGroup | Select-Object Name,Tags | Where-Object Name -Like $pattern | Where-Object {$_.Tags.$tag -eq $null}
}

## Remove Resource Groups (-Force for no confirm)
function rmrg($pattern, [switch]$Force){
    if($Force){lsrg $pattern | Remove-AzureRmResourceGroup -Force}
    else {lsrg $pattern | Remove-AzureRmResourceGroup}
}

# get VM status for all VMs
function Get-AzVMStatus {
    foreach ($v in Get-AzureRmVM){
        $resgroup = $v.ResourceGroupName
        $name = $v.Name
        Get-AzureRmVM -Status -ResourceGroupName $resgroup -Name $name | Select-Object ResourceGroupName,Name,{$_.Statuses[1].DisplayStatus}
    } 
}

