
$7z = "C:\Program Files\7-Zip\7z.exe"

$project = "OpenMauSuji"
$version = "134"

$dst = $project

if (Test-Path $dst) {
  Remove-Item $dst -Recurse
}
New-Item $dst -ItemType Directory

$platforms =
  @{Win32 = "32bit";
    x64   = "64bit"}

$compile_assets =
  @("MauHook.dll", 
    "MauSuji.exe")

$static_assets =
  @("OpenMauSuji.txt", 
    "LICENSE.txt")

foreach($key in $platforms.Keys) {
    $p_src = $key
    $p_dst = Join-Path $dst $platforms[$key]
    New-Item $p_dst -ItemType Directory
    foreach($asset in $compile_assets) {
      Copy-Item (Join-Path (Join-Path $p_src "Release") $asset) $p_dst
    }
}

foreach ($asset in $static_assets) {
  Copy-Item $asset $dst
}

Start-Process $7z -ArgumentList "a $project-$version.zip $dst"
Remove-Item $dst -Recurse
