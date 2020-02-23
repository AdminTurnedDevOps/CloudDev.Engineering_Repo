function New-WebApp {
    [cmdletbinding(ConfirmImpact = 'low', DefaultParameterSetName = 'WebApp')]
    param(
        [parameter(Position = 0,
            ParameterSetName = 'WebApp',
            Mandatory = $true,
            HelpMessage = 'Enter name of web app',
            ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('AppName')]
        [string]$Name,

        [parameter(Position = 1,
            ParameterSetName = 'WebApp',
            Mandatory = $true,
            HelpMessage = 'Enter name of resource group that you want your web app and app service plan to exist in',
            ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('RG')]
        [string]$resourceGroupName,

        [parameter(Position = 3,
            ParameterSetName = 'WebApp',
            Mandatory = $true,
            HelpMessage = 'Enter your region',
            ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('location')]
        [string]$region
    )

    begin {
        $account = Get-AzContext
        if (-not($account)) {
            Write-Warning 'No Azure account set...'
            Write-Output 'Setting subscription...'
            Set-AzContext
        }
    }
    process {
        $appServicePlanParams = @{
            'ResourceGroupName' = $resourceGroupName
            'Location'          = $region
            'ResourceType'      = 'microsoft.web/serverfarms'
            'ResourceName'      = $Name + '-appplan'
            'Kind'              = 'Windows'
            'Properties'        = @{reserved = "false" }
            'sku'               = @{name = "F1"; tier = "Basic"; size = "F1"; family = "F"; capacity = "1" }
        }
        try {

            New-AzResource @appServicePlanParams
        }

        catch {
            $pscmdlet.ThrowTerminatingError($_)
        }

        $appServiceParams = @{
            'ResourceGroupName' = $resourceGroupName
            'Name'              = $Name
            'Location'          = $region
            'AppServicePlan'    = $Name + '-appplan'
        }

        try {
            New-AzWebApp @appServiceParams
        }

        catch {
            $pscmdlet.ThrowTerminatingError($_)
        }
    }

    end { }
}