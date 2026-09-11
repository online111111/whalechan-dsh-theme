[CmdletBinding()]
param(
  [string]$HarnessRoot,
  [string]$DistPath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'scripts\Theme.Common.ps1')

$dist = Resolve-WhaleThemeDist -HarnessRoot $HarnessRoot -DistPath $DistPath
$htmlPath = Join-Path $dist 'index.html'
$target = Join-Path $dist 'whalechan'

$html = [System.IO.File]::ReadAllText($htmlPath, [System.Text.Encoding]::UTF8)
$clean = Remove-WhaleThemeTags $html

if ($clean -ne $html) {
  $tempHtml = Join-Path $dist ('index.html.whalechan-' + [guid]::NewGuid().ToString('N') + '.tmp')
  $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
  try {
    [System.IO.File]::WriteAllText($tempHtml, $clean, $utf8NoBom)
    Move-Item -LiteralPath $tempHtml -Destination $htmlPath -Force
  } finally {
    if (Test-Path -LiteralPath $tempHtml) {
      Remove-Item -LiteralPath $tempHtml -Force
    }
  }
}

if (Test-Path -LiteralPath $target) {
  Remove-Item -LiteralPath $target -Recurse -Force
}

$installedHtml = [System.IO.File]::ReadAllText($htmlPath, [System.Text.Encoding]::UTF8)
if ($installedHtml -match '/whalechan/whalechan-theme\.(css|js)' -or (Test-Path -LiteralPath $target)) {
  throw 'Uninstall verification failed.'
}

Write-Host 'Whale-chan theme removed successfully.' -ForegroundColor Yellow
Write-Host 'Refresh the existing DeepSeek Harness page.' -ForegroundColor Yellow
