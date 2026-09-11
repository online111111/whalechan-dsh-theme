[CmdletBinding()]
param(
  [string]$DshWebRepository,
  [string]$DshHome = $env:DSH_HOME
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if (-not [string]::IsNullOrWhiteSpace($DshWebRepository)) {
  $cli = Join-Path ([System.IO.Path]::GetFullPath($DshWebRepository)) 'scripts\dsh-skin'
  if (-not (Test-Path -LiteralPath $cli)) { throw "dsh-web skin CLI not found: $cli" }
  & node $cli uninstall whalechan-harness
  if ($LASTEXITCODE -ne 0) { throw 'dsh-skin uninstall failed.' }
  Write-Host 'Whale-chan skin removed through the dsh-web skin CLI.' -ForegroundColor Yellow
  return
}

if ([string]::IsNullOrWhiteSpace($DshHome)) { $DshHome = Join-Path $HOME '.dsh' }
$target = Join-Path ([System.IO.Path]::GetFullPath($DshHome)) 'skins\whalechan-harness'
if (Test-Path -LiteralPath $target) { Remove-Item -LiteralPath $target -Recurse -Force }
Write-Host "Whale-chan Skin Center package removed: $target" -ForegroundColor Yellow
Write-Host 'Select the official theme or another installed skin in Skin Center.' -ForegroundColor Yellow
