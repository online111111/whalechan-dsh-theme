[CmdletBinding()]
param(
  [string]$HarnessRoot,
  [string]$DistPath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'scripts\Theme.Common.ps1')

$dist = Resolve-WhaleThemeDist -HarnessRoot $HarnessRoot -DistPath $DistPath
$themeSource = Join-Path $PSScriptRoot 'theme'
$target = Join-Path $dist 'whalechan'
$htmlPath = Join-Path $dist 'index.html'
$markers = Get-WhaleThemeMarkers

$required = @(
  'whalechan-theme.css',
  'whalechan-theme.js',
  'whalechan-riding-whale-64.png',
  'control-fanart\session-active-beacon-64.png',
  'control-fanart\perm-shield-readonly-64.png',
  'control-fanart\perm-shield-write-64.png',
  'control-fanart\perm-shield-full-64.png',
  'tool-fanart\toolcall-64.png',
  'ui-fanart\file-document-64.png',
  'status\07-subagent-outsourcing.png'
)
foreach ($relative in $required) {
  $path = Join-Path $themeSource $relative
  if (-not (Test-Path -LiteralPath $path)) {
    throw "Theme package is incomplete. Missing: $relative"
  }
}

Write-Host "DeepSeek Harness web assets: $dist" -ForegroundColor DarkGray

$stage = Join-Path $dist ('.whalechan-stage-' + [guid]::NewGuid().ToString('N'))
try {
  Copy-Item -LiteralPath $themeSource -Destination $stage -Recurse -Force
  if (Test-Path -LiteralPath $target) {
    Remove-Item -LiteralPath $target -Recurse -Force
  }
  Move-Item -LiteralPath $stage -Destination $target
} finally {
  if (Test-Path -LiteralPath $stage) {
    Remove-Item -LiteralPath $stage -Recurse -Force
  }
}

$html = [System.IO.File]::ReadAllText($htmlPath, [System.Text.Encoding]::UTF8)
$html = Remove-WhaleThemeTags $html

if ($html -notmatch '(?i)</head\s*>') {
  throw "Cannot patch index.html because </head> was not found: $htmlPath"
}
if ($html -notmatch '(?i)</body\s*>') {
  throw "Cannot patch index.html because </body> was not found: $htmlPath"
}

$html = [regex]::Replace($html, '(?i)</head\s*>', "    $($markers.Css)`r`n  </head>", 1)
$html = [regex]::Replace($html, '(?i)</body\s*>', "    $($markers.Js)`r`n  </body>", 1)

$tempHtml = Join-Path $dist ('index.html.whalechan-' + [guid]::NewGuid().ToString('N') + '.tmp')
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
try {
  [System.IO.File]::WriteAllText($tempHtml, $html, $utf8NoBom)
  Move-Item -LiteralPath $tempHtml -Destination $htmlPath -Force
} finally {
  if (Test-Path -LiteralPath $tempHtml) {
    Remove-Item -LiteralPath $tempHtml -Force
  }
}

$installedHtml = [System.IO.File]::ReadAllText($htmlPath, [System.Text.Encoding]::UTF8)
if ($installedHtml -notmatch 'data-whalechan-theme="style"' -or
    $installedHtml -notmatch 'data-whalechan-theme="script"' -or
    -not (Test-Path -LiteralPath (Join-Path $target 'whalechan-theme.css'))) {
  throw 'Installation verification failed.'
}

Write-Host 'Whale-chan theme installed successfully.' -ForegroundColor Cyan
Write-Host 'Refresh the existing DeepSeek Harness page (Ctrl+F5 if cached).' -ForegroundColor Cyan
