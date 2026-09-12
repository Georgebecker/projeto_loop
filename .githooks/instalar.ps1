# instalar.ps1 — ativa os ganchos de protecao do git neste projeto
# Uso: powershell -ExecutionPolicy Bypass -File .githooks\instalar.ps1
$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
Push-Location $root
try {
    if (-not (Test-Path ".git")) {
        Write-Host "Nenhum repositorio git aqui. Inicializando 'git init'..."
        git init
    }
    git config core.hooksPath .githooks
    Write-Host ""
    Write-Host "Protecao ativa: commits com .env serao bloqueados automaticamente."
    Write-Host "Arquivo responsavel: .githooks\pre-commit"
} finally {
    Pop-Location
}
