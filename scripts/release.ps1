# Script para automatizar release com versionamento semântico (Windows)
# Uso: .\scripts\release.ps1 [major|minor|patch]

param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("major", "minor", "patch")]
    [string]$ReleaseType
)

$ErrorActionPreference = "Stop"

# Ler versão atual do pubspec.yaml
$pubspecContent = Get-Content "pubspec.yaml" -Raw
$currentVersion = [regex]::Match($pubspecContent, "version:\s*(.+)").Groups[1].Value

$currentVersionParts = $currentVersion -split '\+'
$currentVersionNumber = $currentVersionParts[0]
$currentBuildNumber = [int]$currentVersionParts[1]

# Separar versão em MAJOR, MINOR, PATCH
$versionParts = $currentVersionNumber -split '\.'
$major = [int]$versionParts[0]
$minor = [int]$versionParts[1]
$patch = [int]$versionParts[2]

# Incrementar versão baseada no tipo
switch ($ReleaseType) {
    "major" {
        $major = $major + 1
        $minor = 0
        $patch = 0
    }
    "minor" {
        $minor = $minor + 1
        $patch = 0
    }
    "patch" {
        $patch = $patch + 1
    }
}

# Nova versão
$newVersion = "$major.$minor.$patch"
$newBuildNumber = $currentBuildNumber + 1
$newVersionString = "$newVersion+$newBuildNumber"

Write-Host "===================================" -ForegroundColor Cyan
Write-Host "Release: $ReleaseType" -ForegroundColor Green
Write-Host "Versão atual: $currentVersion" -ForegroundColor Yellow
Write-Host "Nova versão: $newVersionString" -ForegroundColor Green
Write-Host "===================================" -ForegroundColor Cyan

# Atualizar pubspec.yaml
$newContent = $pubspecContent -replace "version:\s*$currentVersion", "version: $newVersionString"
Set-Content "pubspec.yaml" -Value $newContent -NoNewline

# Commit changes
git add pubspec.yaml
git commit -m "chore(release): bump version to $newVersionString"

# Criar tag
git tag -a "v$newVersion" -m "Release v$newVersion"

Write-Host "✅ Versão atualizada para $newVersionString" -ForegroundColor Green
Write-Host "✅ Tag criada: v$newVersion" -ForegroundColor Green
Write-Host "📝 Execute 'git push --follow-tags' para enviar as mudanças" -ForegroundColor Yellow