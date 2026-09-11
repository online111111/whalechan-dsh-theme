Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-WhaleThemeRepositoryRoot {
  return (Split-Path -Parent (Split-Path -Parent $PSScriptRoot))
}

function Test-WhaleThemeDist([string]$Path) {
  if ([string]::IsNullOrWhiteSpace($Path)) { return $false }
  return (Test-Path -LiteralPath (Join-Path $Path 'index.html')) -and
    ((Split-Path -Leaf $Path) -eq 'dist')
}

function Resolve-WhaleThemeDist {
  param(
    [string]$HarnessRoot,
    [string]$DistPath
  )

  $candidates = [System.Collections.Generic.List[string]]::new()

  if (-not [string]::IsNullOrWhiteSpace($DistPath)) {
    $candidates.Add([System.IO.Path]::GetFullPath($DistPath))
  }

  if (-not [string]::IsNullOrWhiteSpace($HarnessRoot)) {
    $root = [System.IO.Path]::GetFullPath($HarnessRoot)
    $candidates.Add((Join-Path $root 'node_modules\@deepseek-ai\dsh-web-frontend\dist'))
    $candidates.Add((Join-Path $root 'packages\web-frontend\dist'))
  }

  foreach ($envName in 'DSH_ROOT', 'DEEPSEEK_HARNESS_ROOT') {
    $value = [Environment]::GetEnvironmentVariable($envName)
    if (-not [string]::IsNullOrWhiteSpace($value)) {
      $candidates.Add((Join-Path ([System.IO.Path]::GetFullPath($value)) 'node_modules\@deepseek-ai\dsh-web-frontend\dist'))
    }
  }

  $command = Get-Command dsh -ErrorAction SilentlyContinue | Select-Object -First 1
  if ($null -ne $command -and -not [string]::IsNullOrWhiteSpace($command.Source)) {
    $cursor = Split-Path -Parent $command.Source
    for ($i = 0; $i -lt 7 -and -not [string]::IsNullOrWhiteSpace($cursor); $i++) {
      $candidates.Add((Join-Path $cursor 'node_modules\@deepseek-ai\dsh-web-frontend\dist'))
      $parent = Split-Path -Parent $cursor
      if ($parent -eq $cursor) { break }
      $cursor = $parent
    }
  }

  $cursor = (Get-Location).Path
  for ($i = 0; $i -lt 7 -and -not [string]::IsNullOrWhiteSpace($cursor); $i++) {
    $candidates.Add((Join-Path $cursor 'node_modules\@deepseek-ai\dsh-web-frontend\dist'))
    $parent = Split-Path -Parent $cursor
    if ($parent -eq $cursor) { break }
    $cursor = $parent
  }

  foreach ($candidate in ($candidates | Select-Object -Unique)) {
    if (Test-WhaleThemeDist $candidate) {
      return [System.IO.Path]::GetFullPath($candidate)
    }
  }

  $message = @'
Could not locate @deepseek-ai/dsh-web-frontend/dist.
Pass either:
  -HarnessRoot <folder containing node_modules\@deepseek-ai\dsh-web-frontend>
or:
  -DistPath <full path to dsh-web-frontend\dist>
'@
  throw $message.Trim()
}

function Get-WhaleThemeMarkers {
  return [pscustomobject]@{
    Css = '<link rel="stylesheet" href="/whalechan/whalechan-theme.css" data-whalechan-theme="style">'
    Js  = '<script src="/whalechan/whalechan-theme.js" data-whalechan-theme="script"></script>'
  }
}

function Remove-WhaleThemeTags([string]$Html) {
  $result = $Html
  $result = [regex]::Replace($result, '(?i)\s*<link\s+[^>]*href=["'']/whalechan/whalechan-theme\.css(?:\?[^"'']*)?["''][^>]*>\s*', '')
  $result = [regex]::Replace($result, '(?i)\s*<script\s+[^>]*src=["'']/whalechan/whalechan-theme\.js(?:\?[^"'']*)?["''][^>]*>\s*</script>\s*', '')
  return $result
}
