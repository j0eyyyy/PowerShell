# This script uninstalls the specified .NET Runtime version and cleans up any remaining files.

# Define the version to uninstall
$runtimeVersion = "6.0.36"

# Check if the .NET Core Uninstall Tool is installed
# This tool is necessary to remove .NET runtimes from your system.
if (-not (Get-Command dotnet-core-uninstall -ErrorAction SilentlyContinue)) {
    Write-Output "The .NET Core Uninstall Tool is not installed. Please install it first."
    exit 1
}

# Uninstall the specified .NET Runtime version
# The --yes flag automatically confirms the uninstallation without manual intervention.
Write-Output "Uninstalling .NET Runtime version $runtimeVersion..."
dotnet-core-uninstall remove --runtime $runtimeVersion --yes

# Check if the uninstallation was successful
# $? checks if the previous command was successful.
if ($?) {
    Write-Output ".NET Runtime version $runtimeVersion uninstalled successfully."

    # Clean up remaining files (if any)
    # This section removes any leftover files from the uninstalled runtime.
    $runtimePath = "C:\Program Files\dotnet\shared\Microsoft.NETCore.App\$runtimeVersion"
    if (Test-Path $runtimePath) {
        Write-Output "Cleaning up remaining files..."
        Remove-Item -Recurse -Force $runtimePath
        Write-Output "Cleanup completed."
    } else {
        Write-Output "No remaining files found."
    }
} else {
    Write-Output "Failed to uninstall .NET Runtime version $runtimeVersion."
}
