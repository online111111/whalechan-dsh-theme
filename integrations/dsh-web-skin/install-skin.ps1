[CmdletBinding()]
param(
  [string]$DshWebRepository,
  [string]$DshHome = $env:DSH_HOME,
  [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$skinSource = Join-Path $PSScriptRoot 'whalechan-harness'
if (-not (Test-Path -LiteralPath (Join-Path $skinSource 'skin.json'))) {
  throw "Skin package is incomplete: $skinSource"
}

if (-not [string]::IsNullOrWhiteSpace($DshWebRepository)) {
  $cli = Join-Path ([System.IO.Path]::GetFullPath($DshWebRepository)) 'scripts\dsh-skin'
  if (-not (Test-Path -LiteralPath $cli)) {
    throw "dsh-web skin CLI not found: $cli"
  }
  $args = @($cli, 'install', $skinSource)
  if ($Force) { $args += '--force' }
  & node @args
  if ($LASTEXITCODE -ne 0) { throw 'dsh-skin install failed.' }
  Write-Host 'Whale-chan skin installed through the dsh-web skin CLI.' -ForegroundColor Cyan
  return
}

if ([string]::IsNullOrWhiteSpace($DshHome)) {
  $DshHome = Join-Path $HOME '.dsh'
}
$targetRoot = Join-Path ([System.IO.Path]::GetFullPath($DshHome)) 'skins'
$target = Join-Path $targetRoot 'whalechan-harness'

if ((Test-Path -LiteralPath $target) -and -not $Force) {
  throw "Skin already exists: $target. Re-run with -Force to update it."
}

New-Item -ItemType Directory -Force -Path $targetRoot | Out-Null
$stage = Join-Path $targetRoot ('.whalechan-harness-stage-' + [guid]::NewGuid().ToString('N'))
try {
  Copy-Item -LiteralPath $skinSource -Destination $stage -Recurse -Force
  if (Test-Path -LiteralPath $target) { Remove-Item -LiteralPath $target -Recurse -Force }
  Move-Item -LiteralPath $stage -Destination $target
} finally {
  if (Test-Path -LiteralPath $stage) { Remove-Item -LiteralPath $stage -Recurse -Force }
}

Write-Host "Whale-chan Skin Center package installed: $target" -ForegroundColor Cyan
Write-Host 'Open Settings -> Skin Center, then try on or apply Whale-chan Harness.' -ForegroundColor Cyan
