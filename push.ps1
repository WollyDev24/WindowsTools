# Git Push Helper for PowerShell

# 1. search for all git repos in current directory and subdirectories
$gitFolders = Get-ChildItem -Directory -Recurse | Where-Object { Test-Path "$($_.FullName)\.git" }

if ($gitFolders.Count -eq 0) {
    Write-Host "no Git-Repos found"
    exit
}

# 2. list folders with numbers
for ($i = 0; $i -lt $gitFolders.Count; $i++) {
    Write-Host "$($i+1): $($gitFolders[$i].FullName)"
}

# 3. User selects a number
do {
    $selection = Read-Host "Select a Number (1-$($gitFolders.Count))"
} while (-not ($selection -as [int]) -or $selection -lt 1 -or $selection -gt $gitFolders.Count)

$repoPath = $gitFolders[$selection - 1].FullName
Set-Location $repoPath
Write-Host "Arbeite im Repository: $repoPath"

git add .

# commit message
$commitMessage = Read-Host "Gib eine Commit-Nachricht ein"
git commit -m "$commitMessage"

# Push
git push
Write-Host "Done!"
