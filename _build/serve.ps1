# Simple static server for local preview: powershell -File _build\serve.ps1 [-Port 5173]
# Supports Range requests, so the hero video can seek and loop like on a real host.
param([int]$Port = 5173)
$root = Split-Path $PSScriptRoot -Parent
$types = @{ ".html"="text/html; charset=utf-8"; ".css"="text/css; charset=utf-8"; ".js"="application/javascript; charset=utf-8"; ".svg"="image/svg+xml"; ".png"="image/png"; ".jpg"="image/jpeg"; ".webp"="image/webp"; ".json"="application/json"; ".mp4"="video/mp4"; ".webm"="video/webm" }
$l = New-Object Net.HttpListener
$l.Prefixes.Add("http://localhost:$Port/")
$l.Start()
Write-Output "Serving $root on http://localhost:$Port/"
while ($l.IsListening) {
  $ctx = $l.GetContext()
  $res = $ctx.Response
  try {
    $path = [Uri]::UnescapeDataString($ctx.Request.Url.AbsolutePath.TrimStart('/'))
    if ($path -eq "") { $path = "index.html" }
    $file = Join-Path $root $path
    if (-not (Test-Path $file -PathType Leaf)) { $file = Join-Path $root "404.html"; $res.StatusCode = 404 }
    $ext = [IO.Path]::GetExtension($file).ToLower()
    $res.ContentType = if ($types[$ext]) { $types[$ext] } else { "application/octet-stream" }
    $res.Headers.Add("Cache-Control", "no-store")
    $res.Headers.Add("Accept-Ranges", "bytes")
    $len = (Get-Item $file).Length
    $from = 0; $to = $len - 1
    $range = $ctx.Request.Headers["Range"]
    if ($range -match '^bytes=(\d*)-(\d*)$') {
      if ($matches[1]) { $from = [long]$matches[1]; if ($matches[2]) { $to = [Math]::Min([long]$matches[2], $len - 1) } }
      elseif ($matches[2]) { $from = [Math]::Max(0, $len - [long]$matches[2]) }
      $res.StatusCode = 206
      $res.Headers.Add("Content-Range", "bytes $from-$to/$len")
    }
    $count = $to - $from + 1
    $res.ContentLength64 = $count
    $fs = [IO.File]::OpenRead($file)
    try {
      $fs.Position = $from
      $buf = New-Object byte[] 65536
      while ($count -gt 0) {
        $n = $fs.Read($buf, 0, [Math]::Min($buf.Length, $count))
        if ($n -le 0) { break }
        $res.OutputStream.Write($buf, 0, $n); $count -= $n
      }
    } finally { $fs.Close() }
  } catch {}
  try { $res.Close() } catch {}
}
