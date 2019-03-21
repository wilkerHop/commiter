git add .

$OutputVariable = (git status) | Out-String

if ($OutputVariable.Contains('nothing to commit, working tree clean')) {
    return Write-Output "Everything's fine!"
}

$files = $OutputVariable.Split([Environment]::NewLine) |
    # maybe do a split by /                          .Split("\\|\/")[-3] -join ''
    ForEach-Object { If (!($_ -eq $null)) { $_.Trim() } }

$files = $files -join ' ' -split '  '

$message = ($files[6..($files.length - 1)] -join ' ').Trim().Replace('  ', ' ') 

$message | Write-Output

git commit -m "$message" | Write-Output