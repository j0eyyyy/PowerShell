# ============================================================
# IT TESTING RING GROUP CREATION SCRIPT
# ============================================================
# Standardised creation of Entra ID security groups
# for phased / ring-based IT testing
# ============================================================


# ==============================
# CONFIGURATION SECTION
# ==============================
# New users should only edit values in this section

$Prefix      = '$SG-U'
$Purpose     = 'ITTest'
$ServiceName = 'WINUPD'

$BaseDescription = "IT Test security group used for validating $ServiceName changes prior to production rollout."

$Rings = @(
    @{ RingNumber = '00'; RingName = 'Pilot' },
    @{ RingNumber = '01'; RingName = 'Ring1' },
    @{ RingNumber = '02'; RingName = 'Ring2' },
    @{ RingNumber = '03'; RingName = 'Ring3' }
)


# ==============================
# SCRIPT EXECUTION
# ==============================

foreach ($Ring in $Rings) {

    $DisplayName = "$Prefix-$Purpose-$ServiceName-$($Ring.RingNumber)-$($Ring.RingName)"

    # MailNickname must be unique and free of symbols
    $MailNick = ($DisplayName -replace '[^a-zA-Z0-9]', '').ToLower()

    # Build description using standard base plus ring metadata
    $Description = "$BaseDescription Ring=$($Ring.RingNumber)-$($Ring.RingName); Purpose=$Purpose; Service=$ServiceName"

    Write-Host "Processing group: $DisplayName" -ForegroundColor Cyan

    # Check for existing group to allow safe re-runs
    $ExistingGroup = Get-MgGroup -Filter "displayName eq '$DisplayName'" -ErrorAction SilentlyContinue

    if ($ExistingGroup) {
        Write-Host "  Skipping - group already exists" -ForegroundColor Yellow
        continue
    }

    # Create security group with assigned membership
    New-MgGroup `
        -DisplayName $DisplayName `
        -Description $Description `
        -SecurityEnabled `
        -MailEnabled:$false `
        -MailNickname $MailNick `
        -GroupTypes @()

    Write-Host "  Group created successfully" -ForegroundColor Green
}

Write-Host "All ITTest groups for $ServiceName processed." -ForegroundColor Green
