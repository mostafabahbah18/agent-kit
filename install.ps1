# install.ps1
# Install the universal agent-kit into Claude Code (~/.claude) and Antigravity/Gemini (~/.gemini).
# Single source of truth: global/RULES.md and global/skills/. Re-run after editing either.
# Existing non-kit global rules files are backed up before being overwritten.

$ErrorActionPreference = 'Stop'
$kit = $PSScriptRoot
$rules = Join-Path $kit 'global/RULES.md'
if (-not (Test-Path $rules)) { throw "Cannot find $rules" }
$body = Get-Content -Raw $rules

$marker  = 'GENERATED from agent-kit/global/RULES.md'
$genNote = "<!-- $marker by the installer. Do not edit here; edit RULES.md and re-run. -->`n`n"

function Write-Rules($target) {
  New-Item -ItemType Directory -Force -Path (Split-Path $target) | Out-Null
  if ((Test-Path $target) -and -not (Select-String -Path $target -SimpleMatch $marker -Quiet)) {
    $bak = "$target.bak.$(Get-Date -Format 'yyyyMMdd-HHmmss')"
    Copy-Item $target $bak
    Write-Host "Backed up existing $target -> $bak"
  }
  Set-Content -Path $target -Value ($genNote + $body) -Encoding utf8
  Write-Host "Wrote $target"
}

Write-Rules (Join-Path $HOME '.claude/CLAUDE.md')
Write-Rules (Join-Path $HOME '.gemini/GEMINI.md')

# Skills: copy each global/skills/<name> into both skill dirs (idempotent).
$srcSkills = Join-Path $kit 'global/skills'
foreach ($base in @((Join-Path $HOME '.claude'), (Join-Path $HOME '.gemini'))) {
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
Write-Host "Done. Re-run after editing global/RULES.md or global/skills/."
