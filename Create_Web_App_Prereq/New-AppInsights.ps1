function New-AppInsights {
    [cmdletbinding(DefaultParameterSetName = 'AppInsights')]
    param(
        [parameter(Position = 0,
            ParameterSetName = 'AppInsights',
            Mandatory = $true,
            HelpMessage = 'Enter the name of your app insights',
            ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('AppInsightsName')]
        [string]$Name,

        [parameter(Position = 1,
            ParameterSetName = 'AppInsights',
            Mandatory = $true,
            HelpMessage = 'Enter the location of your app insights')]
        [ValidateNotNullOrEmpty()]
        [Alias('region')]
        [string]$Location,

        [parameter(Position = 2,
            ParameterSetName = 'AppInsights',
            Mandatory = $true,
            HelpMessage = 'Enter the resource group of your app insights')]
        [ValidateNotNullOrEmpty()]
        [Alias('RG')]
        [string]$resourceGroupName   
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
        $appinsightsParams = @{
            'ResourceGroupName' = $resourceGroupName
            'Name' = $Name
            'Location' = $Location
        }

        New-AzApplicationInsights @appinsightsParams
    }

}

