
# Setup a custom prompt
function prompt { 
   # our theme 
   $cdelim = [ConsoleColor]::DarkCyan 
   $chost = [ConsoleColor]::Green 
   $cloc = [ConsoleColor]::Cyan 

   write-host "$([char]9484)[" -n -f $cdelim 
   write-host "$([Environment]::username)@$([net.dns]::GetHostName())" -n -f $chost 
   write-host "]" -f $cdelim 
   write-host "$([char]9492)[" -n -f $cdelim 
   write-host (shorten-path (pwd).Path) -n -f $cloc 
   write-host ']>' -n -f $cdelim 
   return ' ' 
}

function shorten-path([string] $path) { 
   $loc = $path.Replace($HOME, '~') 

   # remove prefix for UNC paths 
   $loc = $loc -replace '^[^:]+::', '' 

   # make path shorter like tabs in Vim, 
   # handle paths starting with \\ and . correctly 
   return ($loc -replace '\\(\.?)([^\\])[^\\]*(?=\\)','\$1$2') 
}

# Aliases
Set-Alias g git
Set-Alias light LightTable

function Reload-Profile {
  @(
      $Profile.AllUsersAllHosts,
      $Profile.AllUsersCurrentHost,
      $Profile.CurrentUserAllHosts,
      $Profile.CurrentUserCurrentHost
   ) | % {
    if($_ -and (Test-Path $_)){
      Write-Verbose "Running $_"
        . $_
    }
  }    
}

function ep() {
  vim $Profile
  . Reload-Profile
}

function open([string] $path) {
  if($path) {
    explorer $path
  } else {
    explorer .
  }
}
