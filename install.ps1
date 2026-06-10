# install.ps1
# Install the universal agent-kit into Claude Code (~/.claude) and Antigravity/Gemini (~/.gemini).
# Single source of truth: global/RULES.md and global/skills/. Re-run after editing either.

$ErrorActionPreference = 'Stop'
$kit = $PSScriptRoot
$rules = Join-Path $kit 'global/RULES.md'
if (-not (Test-Path $rules)) { throw "Cannot find $rules" }
$body = Get-Content -Raw $rules

$claudeHome = Join-Path $HOME '.claude'
$geminiHome = Join-Path $HOME '.gemini'

# 1. Global rules: generate CLAUDE.md and GEMINI.md from RULES.md (single source).
$genNote = "<!-- GENERATED from agent-kit/global/RULES.md by install.ps1. Do not edit here; edit RULES.md and re-run install.ps1. -->`n`n"
New-Item -ItemType Directory -Force -Path $claudeHome | Out-Null
New-Item -ItemType Directory -Force -Path $geminiHome | Out-Null
Set-Content -Path (Join-Path $claudeHome 'CLAUDE.md') -Value ($genNote + $body) -Encoding utf8
Set-Content -Path (Join-Path $geminiHome 'GEMINI.md') -Value ($genNote + $body) -Encoding utf8
Write-Host "Wrote ~/.claude/CLAUDE.md and ~/.gemini/GEMINI.md"

# 2. Skills: copy each global/skills/<name> into both skill dirs (idempotent).
$srcSkills = Join-Path $kit 'global/skills'
foreach ($base in @($claudeHome, $geminiHome)) {
  $dstSkills = Join-Path $base 'skills'
  New-Item -ItemType Directory -Force -Path $dstSkills | Out-Null
  Get-ChildItem -Directory $srcSkills | ForEach-Object {
    $dst = Join-Path $dstSkills $_.Name
    if (Test-Path $dst) { Remove-Item -Recurse -Force $dst }
    Copy-Item -Recurse -Force $_.FullName $dst
    Write-Host "Installed skill '$($_.Name)' -> $dst"
  }
}

Write-Host ""
Write-Host "Done. Re-run this script after editing global/RULES.md or global/skills/."
