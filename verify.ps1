[CmdletBinding()]
param(
  [string]$HarnessRoot,
  [string]$DistPath,
  [string]$BaseUrl
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'scripts\Theme.Common.ps1')

$dist = Resolve-WhaleThemeDist -HarnessRoot $HarnessRoot -DistPath $DistPath
$htmlPath = Join-Path $dist 'index.html'
$themePath = Join-Path $dist 'whalechan'
$html = [System.IO.File]::ReadAllText($htmlPath, [System.Text.Encoding]::UTF8)

$checks = [System.Collections.Generic.List[object]]::new()
function Add-Check([string]$Name, [bool]$Passed, [string]$Detail) {
  $checks.Add([pscustomobject]@{ Check = $Name; Passed = $Passed; Detail = $Detail })
}

Add-Check 'index.html exists' (Test-Path -LiteralPath $htmlPath) $htmlPath
Add-Check 'CSS tag injected' ($html -match 'data-whalechan-theme="style"') '/whalechan/whalechan-theme.css'
Add-Check 'JS tag injected' ($html -match 'data-whalechan-theme="script"') '/whalechan/whalechan-theme.js'
Add-Check 'Theme directory exists' (Test-Path -LiteralPath $themePath) $themePath

$content = ''
foreach ($name in 'whalechan-theme.css', 'whalechan-theme.js') {
  $path = Join-Path $themePath $name
  if (Test-Path -LiteralPath $path) { $content += [System.IO.File]::ReadAllText($path) }
}
$refs = [regex]::Matches($content, '/whalechan/[^''"\)\s]+') | ForEach-Object { $_.Value } | Sort-Object -Unique
$missing = @()
foreach ($ref in $refs) {
  $relative = $ref.Substring('/whalechan/'.Length).Replace('/', [System.IO.Path]::DirectorySeparatorChar)
  if (-not (Test-Path -LiteralPath (Join-Path $themePath $relative))) { $missing += $ref }
}
Add-Check 'Referenced assets exist' ($missing.Count -eq 0) ($(if ($missing.Count -eq 0) { "$($refs.Count) references checked" } else { $missing -join ', ' }))

if (-not [string]::IsNullOrWhiteSpace($BaseUrl)) {
  $base = $BaseUrl.TrimEnd('/')
  foreach ($relative in 'whalechan-theme.css', 'whalechan-theme.js', 'whalechan-riding-whale-64.png') {
    $url = "$base/whalechan/$relative"
    try {
      $response = Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 10
      Add-Check "HTTP $relative" ($response.StatusCode -eq 200) "$($response.StatusCode) $url"
    } catch {
      Add-Check "HTTP $relative" $false $_.Exception.Message
    }
  }
}

$checks | Format-Table -AutoSize
$failed = @($checks | Where-Object { -not $_.Passed })
if ($failed.Count -gt 0) {
  throw 'One or more verification checks failed.'
}
Write-Host 'All Whale-chan theme checks passed.' -ForegroundColor Green
