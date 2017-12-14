# create a credentials object taking a plaintext username and password
function New-PtxtCreds ($User, $PtxtPass){
    $PWord = ConvertTo-SecureString -String $PtxtPass -AsPlainText -Force
    return New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $User, $PWord
}