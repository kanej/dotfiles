
function Set-LocationByAlias([string]$alias) {

  $lookups = @{}

  $jumpFile = Get-Content ~/.jumpfile

  foreach($line in $jumpFile) {
    $parts = @($line.Split("`t"))
    $lookups.Add($parts[0], $parts[1])
  }

  Set-Location $lookups[$alias]
}

Export-ModuleMember Set-LocationByAlias
