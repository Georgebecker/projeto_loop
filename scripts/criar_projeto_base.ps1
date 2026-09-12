# criar_projeto_base.ps1 - cria um novo projeto padrao a partir desta base (projeto_loop)
# Uso: powershell -ExecutionPolicy Bypass -File scripts\criar_projeto_base.ps1 -Nome projeto_x [-Titulo "Projeto X"] [-Destino D:\Projetos] [-Venv]
param(
    [Parameter(Mandatory = $true)][string]$Nome,
    [string]$Titulo = "",
    [string]$Destino = "D:\Projetos",
    [switch]$Venv
)
$ErrorActionPreference = "Stop"

$base = Split-Path -Parent $PSScriptRoot          # raiz desta base (projeto_loop)
if ($Titulo -eq "") {
    $Titulo = (Get-Culture).TextInfo.ToTitleCase(($Nome -replace "[_\-]", " "))
}

$dest = Join-Path $Destino $Nome
if (Test-Path $dest) { throw "Ja existe: $dest" }

Write-Host "[1/5] Copiando arquivos base para $dest ..."
New-Item -ItemType Directory -Force -Path $dest, "$dest\docs", "$dest\data\raw", "$dest\data\processed", "$dest\data\descartados", "$dest\notebooks" | Out-Null
Copy-Item "$base\LICENSE"                  "$dest\LICENSE"
Copy-Item "$base\.gitignore"               "$dest\.gitignore"
Copy-Item "$base\.githooks"                "$dest\.githooks" -Recurse
Copy-Item "$base\.env.example"             "$dest\.env.example"
Copy-Item "$base\.env"                     "$dest\.env"
Copy-Item "$base\README.md"                "$dest\README.md"
Copy-Item "$base\docs\REGRAS_DE_OURO.md"   "$dest\docs\REGRAS_DE_OURO.md"
foreach ($gancho in "pre-commit", "pre-push") {
    if (-not (Test-Path "$dest\.githooks\$gancho")) { throw "Gancho ausente na base de origem: .githooks\$gancho (confira o projeto_loop)" }
}
foreach ($p in "data\raw", "data\processed", "data\descartados", "notebooks") {
    New-Item -ItemType File -Path "$dest\$p\.gitkeep" | Out-Null
}

Write-Host "[2/5] Ajustando o nome do projeto nos textos ..."
$utf8 = New-Object System.Text.UTF8Encoding($false)
foreach ($f in "$dest\.env", "$dest\.env.example", "$dest\README.md", "$dest\docs\REGRAS_DE_OURO.md") {
    $t = [System.IO.File]::ReadAllText($f, $utf8)
    $t = $t.Replace("projeto_loop", $Nome)
    $t = $t.Replace("Projeto Loop", $Titulo)
    [System.IO.File]::WriteAllText($f, $t, $utf8)
}

Write-Host "[3/5] Iniciando git + ganchos de protecao (pre-commit + pre-push) ..."
Push-Location $dest
try {
    git init | Out-Null
    git config core.hooksPath .githooks
    if ((git config core.hooksPath) -ne ".githooks") { throw "core.hooksPath nao foi configurado." }
    git add . | Out-Null
    $stagedEnv = git ls-files --cached | Where-Object { $_ -match '(^|/)\.env$' }
    if ($stagedEnv) { throw "O .env entrou no stage ($($stagedEnv -join ', ')) - commit abortado." }
    git commit -m "Commit inicial: base do $Titulo (documentacao, regras de ouro e configuracao)" | Out-Null
} finally { Pop-Location }

Write-Host "[4/5] Ambiente virtual:"
if ($Venv) {
    if (Get-Command py -ErrorAction SilentlyContinue) { py -3 -m venv "$dest\.venv" }
    else { python -m venv "$dest\.venv" }
    Write-Host "  .venv criado."
} else {
    Write-Host "  nao criado (use -Venv para criar)."
}

Write-Host "[5/5] Pronto: $dest"
Write-Host "Abra no VS Code com: code --new-window `"$dest`""
