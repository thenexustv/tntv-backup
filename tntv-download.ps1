# Don't forget about PowerShell's security policy
# as administrator, run: Set-ExecutionPolicy RemoteSigned
# or set by the command line when run: PowerShell -ExecutionPolicy RemoteSigned .\tntv-download.ps1

# should each series have its own subfolder?
$ryanStyle = $TRUE

# defaults to the directory the script is in
# see also http://stackoverflow.com/questions/5466329
$downloadDirectory = split-path -parent $MyInvocation.MyCommand.Definition

$urlbase = "https://s3.amazonaws.com/the-nexus-tv/podcasts/"

$originalDir = $pwd
cd $downloadDirectory
function getseries ($1) {
    $i=1
	while (getpodcast $1 $i $TRUE) {
	    $i++
	}
}
function getpodcast ($1, $2, $returnSomething = $FALSE) {
    $mp3 = "$1$2.mp3"
	if ($ryanStyle) {
		$folder = "$downloadDirectory\$1\"
	    $filename = "$folder$mp3"
		if (-not (test-path $folder -pathType container)) {
			new-item $folder -ItemType directory
		}
	} else {
		$filename = "$downloadDirectory\$mp3"
	}
    if (-not (test-path $filename)) {
	    start-sleep -s 2 # just to be nice
	    $wc = new-object System.Net.WebClient
		write-host "Downloading $mp3"
		try {
			$wc.DownloadFile("$urlbase$1/$mp3",$filename)
		} catch [Exception] {
			write-host "$mp3 not released yet"
			if ($returnSomething) { return $FALSE }
			return
		}
		write-host "Download $mp3 complete"
	}
	if ($returnSomething) { return $TRUE }
	return
}

# Each series is downloaded below
# After each series is downloaded,
# exceptions to the series conventions are downloaded
# ---

# At The Nexus
getseries atn
getpodcast atn 20x
getpodcast atn 31x
getpodcast atn 50x
getpodcast atn 50_64
getpodcast atn 56x
getpodcast atn 61x

# Control Structure
getseries cs
getpodcast cs 0 # i'm special!

# Eight Bit
getseries eb

# Nexus Special
getseries ns
getpodcast ns 5x

# The Fringe
getseries tf
getpodcast tf 1x

# The Universe
getseries tu
getpodcast tu 18x




cd $originalDir
