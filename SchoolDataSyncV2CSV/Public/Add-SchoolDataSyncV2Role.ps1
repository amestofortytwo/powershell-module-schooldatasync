<#
.SYNOPSIS
Adds a user to the School Data Sync V2 users collection

.EXAMPLE
Add-SchoolDataSyncV2User -sourcedId "1234" -username "test@fortytwo.io"
#>
function Add-SchoolDataSyncV2Role {
    [CmdletBinding()]

    Param(
        [Parameter(Mandatory = $true)]
        [String] $userSourcedId,

        [Parameter(Mandatory = $true)]
        [String] $orgSourcedId,

        [Parameter(Mandatory = $true)]
        [ValidateSet("principal", "chair", "professor", "researcher", "adjunct", "affiliate", "occupationalTherapist", "physicalTherapist", "speechTherapist", "visionTherapist", "paraprofessional", "specialServices", "advisor", "proctor", "nurse", "officeStaff", "lecturer", "itAdmin", "administrator", "teacher", "faculty", "staff", "teacherAssistant", "assistant", "instructor", "substitute", "coach", "alumni", "student", "other")]
        [String] $role,

        [Parameter(Mandatory = $false)]
        [String] $sessionSourcedId = $null,

        [Parameter(Mandatory = $false)]
        [ValidateSet("it", "pr", "pk", "tk", "kg", "01", "1", "02", "2", "03", "3", "04", "4", "05", "5", "06", "6", "07", "7", "08", "8", "09", "9", "10", "11", "12", "13", "14", "ps", "ug", "other", "ps1", "ps2", "ps3", "ps4", "undergraduate", "graduate", "postgraduate alumni", "adultEducation")]        
        [String] $grade = $null,

        [Parameter(Mandatory = $false)]
        [Boolean] $isPrimary,

        [Parameter(Mandatory = $false)]
        [DateTime] $roleStartDate,

        [Parameter(Mandatory = $false)]
        [DateTime] $roleEndDate
    )

    Process {
        if (!$script:Users.ContainsKey($userSourcedId)) {
            Write-Error "User with sourcedId $userSourcedId not found"
            return
        } 
        
        if (!$script:Orgs.ContainsKey($orgSourcedId)) {
            Write-Error "Org with sourcedId $orgSourcedId not found"
            return
        } 
        
        $key = "$($userSourcedId)-$($orgSourcedId)-$($role)"

        if ($script:Roles.ContainsKey($key)) {
            Write-Error "Role combination for user $userSourcedId, org $orgSourcedId and role $role already exists"
            return
        }

        $script:Roles[$key] = @{
            userSourcedId    = $userSourcedId
            orgSourcedId     = $orgSourcedId
            role             = $role
            sessionSourcedId = $sessionSourcedId
            grade            = $grade
            isPrimary        = $isPrimary
            roleStartDate    = $roleStartDate ? $roleStartDate.ToString("yyyy-MM-dd") : $null
            roleEndDate      = $roleEndDate ? $roleEndDate.ToString("yyyy-MM-dd") : $null
        }
    }
}