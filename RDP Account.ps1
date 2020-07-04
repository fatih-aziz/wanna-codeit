Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Form, create form container
$form = New-Object System.Windows.Forms.Form
$form.Text = 'RDP Account'
$form.Size = New-Object System.Drawing.Size(500, 500)
$form.StartPosition = 'CenterScreen'

# Button, create button
$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(35, 250)
$okButton.Size = New-Object System.Drawing.Size(75, 23)
$okButton.Text = 'Remote'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

# Button, create button
$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(150, 250)
$cancelButton.Size = New-Object System.Drawing.Size(75, 23)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

# Label, to put sometext
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10, 20)
$label.Size = New-Object System.Drawing.Size(280, 20)
$label.Text = 'Select computer to connect:'
$form.Controls.Add($label)

# ListBox object, create object that will contain selections.
$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Location = New-Object System.Drawing.Point(10, 40)
$listBox.Size = New-Object System.Drawing.Size(400, 20)
$listBox.Height = 200


# Selections, just copy-paste to make more
[void]$listBox.Items.Add('PC1 - john@192.168.0.1')
[void]$listBox.Items.Add('PC2 - johnconor@192.168.1.1')
[void]$listBox.Items.Add('PC3 - johnconor@192.168.1.1')

$form.Controls.Add($listBox)

$form.Topmost = $true

$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
	# Get selection
	$x = $listBox.SelectedItem
	
	# RemoteDesktop Credential, im using ip, username, and password here.
	
	$defaultUsername = "john"
	$defaultPass = "Johnstar2912"
	$defaultRemoteIP = "192.168.10.1"
	
	if (Select-String -InputObject $x -Pattern 'PC1')
	{
		$User = $defaultUsername
		$Pass = $defaultPass
		$Server = $defaultRemoteIP
	}
	elseif (Select-String -InputObject $x -Pattern 'PC2')
	{
		# Customize as youwish
		$User = "johnconor"
		$Pass = "john"
		$Server = "192.160.1.1"
	}
	elseif (Select-String -InputObject $x -Pattern 'PC3')
	{
		# Customize as youwish
		$User = "johnconor"
		$Pass = "john"
		$Server = "192.160.1.1"
	}
	
	$status = cmdkey /generic:TERMSRV/$Server /user:$User /pass:$Password
	
	mstsc /v:$Server
}