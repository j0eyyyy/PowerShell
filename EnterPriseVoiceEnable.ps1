<#
Enterprise Voice is a feature in Microsoft Teams that allows you to use Teams as your organisation's phone system. It includes features like call routing, call control, and voicemail.
When you enable a user for enterprise voice, you are giving them the ability to make and receive calls through Teams. This means that they can call and receive calls from landlines, mobile phones, and other users of Teams, regardless of if they are using SFB on-prem, Teams OC, or DR.
#>

# Connect to Microsoft Teams
Connect-MicrosoftTeams

# Check if enterprise voice is enabled. Change the UPN to the users email address

$emailaddress = "UPN" 
Get-CsOnlineUser -Identity $emailaddress | ft DisplayName,FeatureTypes,EnterpriseVoiceEnabled


# If False
$emailaddress = "UPN"
Set-CsPhoneNumberAssignment -Identity $emailaddress -EnterpriseVoiceEnabled $true
