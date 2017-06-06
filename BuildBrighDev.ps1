Param(
	[string]$action
)

$root  = "c:\build"
$logs = "logs"
$node_dist = "node-v6.10.3-x64.msi"
$node_install = "https://nodejs.org/dist/v6.10.3/$node_dist"
$installs="installs"
$node_install_out = "$root\$logs\node_install.log"


function build 
{
	echo "Building BrightWebApp"
	New-Item -ItemType directory -Path $root
	New-Item -ItemType directory -Path $root\$logs
	New-Item -ItemType directory -Path $root\$installs

	# ------ Install Node
	Invoke-WebRequest -Uri $node_install -OutFile $root\$installs\$node_dist
	msiexec.exe /I $root\$installs\$node_dist /quiet

	# ------ Install Grunt
	Invoke-Expression "npm install grunt-cli grunt"
	Invoke-Expression "npm install"


}

function clean 
{
	Remove-Item -Path $root\$logs
	Remove-Item -Path $root\$installs
	Remove-Item -Path $root	
	
}


Invoke-Expression $action	