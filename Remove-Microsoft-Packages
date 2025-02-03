# Script to Remove Microsoft Packages with Error Handling
# 
# Problem:
# When attempting to remove certain Microsoft packages using PowerShell, you may encounter errors such as 0x80073D19,
# which typically occur when a user is logged off. This can cause the script to fail, requiring manual intervention to rerun the script.
#
# Solution:
# This script addresses the issue by incorporating error handling and retry logic. It attempts to remove each specified package
# up to three times if an error occurs, with a brief pause between attempts. This ensures that transient issues do not prevent
# the script from completing successfully.
#
# How It Helps:
# - Automated Retries: Automatically retries the removal process up to three times if an error occurs, reducing the need for manual intervention.
# - Error Logging: Provides clear error messages and retry attempts, making it easier to diagnose and address issues.
# - Efficiency: Ensures that all specified packages are removed efficiently, even in the presence of transient errors.

$appnames = @("GetHelp", "YourPhone", "Surface")

foreach ($appname in $appnames) {
    $retryCount = 0
    $maxRetries = 3
    $success = $false

    while (-not $success -and $retryCount -lt $maxRetries) {
        try {
            Get-AppxPackage -AllUsers -Name *$appname* | Remove-AppxPackage -AllUsers
            Get-AppxProvisionedPackage -Online | Where PackageName -Like "*$appname*" | Remove-AppxProvisionedPackage -Online
            $success = $true
        } catch {
            Write-Host "Error removing $appname. Retrying... ($($retryCount + 1)/$maxRetries)"
            $retryCount++
            Start-Sleep -Seconds 5
        }
    }

    if (-not $success) {
        Write-Host "Failed to remove $appname after $maxRetries attempts."
    }
}
