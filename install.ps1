param(
    [switch]$Global,
    [string]$Project,
    [string]$SourceUrl = "https://raw.githubusercontent.com/flyrev/payback/main/PAYBACK.md"
)

$ErrorActionPreference = "Stop"
$BeginMarker = "<!-- payback:begin -->"
$EndMarker = "<!-- payback:end -->"

function Get-PaybackContract {
    (Invoke-RestMethod -Uri $SourceUrl -Method Get).TrimEnd()
}

function Remove-PaybackBlock([string]$Content) {
    if ([string]::IsNullOrEmpty($Content)) { return "" }

    $escapedBegin = [regex]::Escape($BeginMarker)
    $escapedEnd = [regex]::Escape($EndMarker)
    $pattern = "(?ms)^$escapedBegin\r?\n.*?^$escapedEnd\r?\n?"
    return ([regex]::Replace($Content, $pattern, "")).TrimEnd()
}

function Install-PaybackBlock([string]$Path, [string]$Contract) {
    $directory = Split-Path -Parent $Path
    if ($directory) {
        New-Item -ItemType Directory -Force -Path $directory | Out-Null
    }

    $existing = if (Test-Path $Path) { Get-Content -Raw $Path } else { "" }
    $clean = Remove-PaybackBlock $existing

    $parts = @()
    if ($clean) { $parts += $clean }
    $parts += $BeginMarker
    $parts += $Contract
    $parts += $EndMarker

    ($parts -join [Environment]::NewLine) + [Environment]::NewLine |
        Set-Content -Path $Path -Encoding utf8

    Write-Host "Payback -> $Path"
}

$contract = Get-PaybackContract

if ($Project) {
    $root = (Resolve-Path -LiteralPath $Project).Path
    Install-PaybackBlock (Join-Path $root "AGENTS.md") $contract
    Install-PaybackBlock (Join-Path $root "CLAUDE.md") $contract
    Install-PaybackBlock (Join-Path $root "GEMINI.md") $contract
    Install-PaybackBlock (Join-Path $root ".github\copilot-instructions.md") $contract
}
else {
    $homeDir = [Environment]::GetFolderPath("UserProfile")
    Install-PaybackBlock (Join-Path $homeDir ".codex\AGENTS.md") $contract
    Install-PaybackBlock (Join-Path $homeDir ".copilot\copilot-instructions.md") $contract
    Install-PaybackBlock (Join-Path $homeDir ".claude\CLAUDE.md") $contract
    Install-PaybackBlock (Join-Path $homeDir ".gemini\GEMINI.md") $contract
}

Write-Host "Payback installed. AI agents now have an always-on 'med samme mynt' instruction where supported."
