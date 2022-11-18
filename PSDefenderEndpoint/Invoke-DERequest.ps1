Function Invoke-DERequest
{
    <#
	.SYNOPSIS
	    Invoke custom api request

    .PARAMETER Uri
	    Url to api. For example https://api.securitycenter.microsoft.com/api/advancedqueries/run

    .PARAMETER Token
	    Authorization token.

	.PARAMETER Body
	    Request content.

	.EXAMPLE
        $Body = @{
            Query = "DeviceProcessEvents
|where InitiatingProcessFileName =~ 'powershell.exe'
|where ProcessCommandLine contains 'appdata'
|project Timestamp, FileName, InitiatingProcessFileName, DeviceId
|limit 2"
        }
        $Response = Invoke-DERequest -Token $Token -Uri https://api.securitycenter.microsoft.com/api/advancedqueries/run -Method POST -Body $Body

	.NOTES
		Author: Michal Gajda

    .LINK
        https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/exposed-apis-list?view=o365-worldwie
	#>
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true)]
        $Token,
        [Parameter(Mandatory = $true)]
        $Body,
        [Parameter(Mandatory = $true)]
        $Uri,
        [Parameter(Mandatory = $true)]
        [ValidateSet("GET", "POST", "PUT", "DELETE")]
        $Method = "GET"
    )

    Begin {}

    Process
	{
        $Headers = @{
            'Content-Type' = 'application/json'
            Accept = 'application/json'
            Authorization = "Bearer $Token"
        }

        $Request = @{
            Method = $Method
            Uri = $Uri
            Headers = $Headers
            Body = ($Body | ConvertTo-Json)
            ErrorAction = "Stop"
        }

        $Response = Invoke-RestMethod @Request
        Return $Response
    }

    End {}
}


# SIG # Begin signature block
# MIIuRQYJKoZIhvcNAQcCoIIuNjCCLjICAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCCzWLdsFIOCrB9S
# KITWZa/LV9mYZa6UrxBs4CWGOOpS1aCCJnkwggXJMIIEsaADAgECAhAbtY8lKt8j
# AEkoya49fu0nMA0GCSqGSIb3DQEBDAUAMH4xCzAJBgNVBAYTAlBMMSIwIAYDVQQK
# ExlVbml6ZXRvIFRlY2hub2xvZ2llcyBTLkEuMScwJQYDVQQLEx5DZXJ0dW0gQ2Vy
# dGlmaWNhdGlvbiBBdXRob3JpdHkxIjAgBgNVBAMTGUNlcnR1bSBUcnVzdGVkIE5l
# dHdvcmsgQ0EwHhcNMjEwNTMxMDY0MzA2WhcNMjkwOTE3MDY0MzA2WjCBgDELMAkG
# A1UEBhMCUEwxIjAgBgNVBAoTGVVuaXpldG8gVGVjaG5vbG9naWVzIFMuQS4xJzAl
# BgNVBAsTHkNlcnR1bSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTEkMCIGA1UEAxMb
# Q2VydHVtIFRydXN0ZWQgTmV0d29yayBDQSAyMIICIjANBgkqhkiG9w0BAQEFAAOC
# Ag8AMIICCgKCAgEAvfl4+ObVgAxknYYblmRnPyI6HnUBfe/7XGeMycxca6mR5rlC
# 5SBLm9qbe7mZXdmbgEvXhEArJ9PoujC7Pgkap0mV7ytAJMKXx6fumyXvqAoAl4Va
# qp3cKcniNQfrcE1K1sGzVrihQTib0fsxf4/gX+GxPw+OFklg1waNGPmqJhCrKtPQ
# 0WeNG0a+RzDVLnLRxWPa52N5RH5LYySJhi40PylMUosqp8DikSiJucBb+R3Z5yet
# /5oCl8HGUJKbAiy9qbk0WQq/hEr/3/6zn+vZnuCYI+yma3cWKtvMrTscpIfcRnNe
# GWJoRVfkkIJCu0LW8GHgwaM9ZqNd9BjuiMmNF0UpmTJ1AjHuKSbIawLmtWJFfzcV
# WiNoidQ+3k4nsPBADLxNF8tNorMe0AZa3faTz1d1mfX6hhpneLO/lv403L3nUlbl
# s+V1e9dBkQXcXWnjlQ1DufyDljmVe2yAWk8TcsbXfSl6RLpSpCrVQUYJIP4ioLZb
# MI28iQzV13D4h1L92u+sUS4Hs07+0AnacO+Y+lbmbdu1V0vc5SwlFcieLnhO+Nqc
# noYsylfzGuXIkosagpZ6w7xQEmnYDlpGizrrJvojybawgb5CAKT41v4wLsfSRvbl
# jnX98sy50IdbzAYQYLuDNbdeZ95H7JlI8aShFf6tjGKOOVVPORa5sWOd/7cCAwEA
# AaOCAT4wggE6MA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0OBBYEFLahVDkCw6A/joq8
# +tT4HKbROg79MB8GA1UdIwQYMBaAFAh2zcsH/yT2xc3tu5C84oQ3RnX3MA4GA1Ud
# DwEB/wQEAwIBBjAvBgNVHR8EKDAmMCSgIqAghh5odHRwOi8vY3JsLmNlcnR1bS5w
# bC9jdG5jYS5jcmwwawYIKwYBBQUHAQEEXzBdMCgGCCsGAQUFBzABhhxodHRwOi8v
# c3ViY2Eub2NzcC1jZXJ0dW0uY29tMDEGCCsGAQUFBzAChiVodHRwOi8vcmVwb3Np
# dG9yeS5jZXJ0dW0ucGwvY3RuY2EuY2VyMDkGA1UdIAQyMDAwLgYEVR0gADAmMCQG
# CCsGAQUFBwIBFhhodHRwOi8vd3d3LmNlcnR1bS5wbC9DUFMwDQYJKoZIhvcNAQEM
# BQADggEBAFHCoVgWIhCL/IYx1MIy01z4S6Ivaj5N+KsIHu3V6PrnCA3st8YeDrJ1
# BXqxC/rXdGoABh+kzqrya33YEcARCNQOTWHFOqj6seHjmOriY/1B9ZN9DbxdkjuR
# mmW60F9MvkyNaAMQFtXx0ASKhTP5N+dbLiZpQjy6zbzUeulNndrnQ/tjUoCFBMQl
# lVXwfqefAcVbKPjgzoZwpic7Ofs4LphTZSJ1Ldf23SIikZbr3WjtP6MZl9M7JYjs
# NhI9qX7OAo0FmpKnJ25FspxihjcNpDOO16hO0EoXQ0zF8ads0h5YbBRRfopUofbv
# n3l6XYGaFpAP4bvxSgD5+d2+7arszgowggXSMIIDuqADAgECAhAh1tBKTyUPyTI3
# /KpeEo3pMA0GCSqGSIb3DQEBDQUAMIGAMQswCQYDVQQGEwJQTDEiMCAGA1UEChMZ
# VW5pemV0byBUZWNobm9sb2dpZXMgUy5BLjEnMCUGA1UECxMeQ2VydHVtIENlcnRp
# ZmljYXRpb24gQXV0aG9yaXR5MSQwIgYDVQQDExtDZXJ0dW0gVHJ1c3RlZCBOZXR3
# b3JrIENBIDIwIhgPMjAxMTEwMDYwODM5NTZaGA8yMDQ2MTAwNjA4Mzk1NlowgYAx
# CzAJBgNVBAYTAlBMMSIwIAYDVQQKExlVbml6ZXRvIFRlY2hub2xvZ2llcyBTLkEu
# MScwJQYDVQQLEx5DZXJ0dW0gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkxJDAiBgNV
# BAMTG0NlcnR1bSBUcnVzdGVkIE5ldHdvcmsgQ0EgMjCCAiIwDQYJKoZIhvcNAQEB
# BQADggIPADCCAgoCggIBAL35ePjm1YAMZJ2GG5ZkZz8iOh51AX3v+1xnjMnMXGup
# kea5QuUgS5vam3u5mV3Zm4BL14RAKyfT6Lowuz4JGqdJle8rQCTCl8en7psl76gK
# AJeFWqqd3CnJ4jUH63BNStbBs1a4oUE4m9H7MX+P4F/hsT8PjhZJYNcGjRj5qiYQ
# qyrT0NFnjRtGvkcw1S5y0cVj2udjeUR+S2MkiYYuND8pTFKLKqfA4pEoibnAW/kd
# 2ecnrf+aApfBxlCSmwIsvam5NFkKv4RK/9/+s5/r2Z7gmCPspmt3FirbzK07HKSH
# 3EZzXhliaEVX5JCCQrtC1vBh4MGjPWajXfQY7ojJjRdFKZkydQIx7ikmyGsC5rVi
# RX83FVojaInUPt5OJ7DwQAy8TRfLTaKzHtAGWt32k89XdZn1+oYaZ3izv5b+NNy9
# 51JW5bPldXvXQZEF3F1p45UNQ7n8g5Y5lXtsgFpPE3LG130pekS6UqQq1UFGCSD+
# IqC2WzCNvIkM1ddw+IdS/drvrFEuB7NO/tAJ2nDvmPpW5m3btVdL3OUsJRXIni54
# TvjanJ6GLMpX8xrlyJKLGoKWesO8UBJp2A5aRos66yb6I8m2sIG+QgCk+Nb+MC7H
# 0kb25Y51/fLMudCHW8wGEGC7gzW3XmfeR+yZSPGkoRX+rYxijjlVTzkWubFjnf+3
# AgMBAAGjQjBAMA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0OBBYEFLahVDkCw6A/joq8
# +tT4HKbROg79MA4GA1UdDwEB/wQEAwIBBjANBgkqhkiG9w0BAQ0FAAOCAgEAcaUO
# zuTpvz841YlaxAJh+0zFFBcti09TaxAX/GWExxBJkN7bxyaTiCZvcNYCXjmg94+r
# lrWlE1yBFG0OgYIRG4pOxk+l3WIeRN8JWfRbdws36YsgxvgKTi5YHOsz0M+GYMna
# +4AvnkxghHg9IWTW+0EfGA/nyXVxvb1c3jSHPkGwDva51j8JE5YUL96aHVq5Vs41
# OrBfcE1e4ynxIyhyWbarwoxmJhx3LCZ2NYsop2mg+Tv1I92FEHTJkANWkeevukfU
# EpcRIuOiSZRs57eUS7otpNozi0ymRP9aPMYdZNi1MeSmPHqoVwvb7WEay/HOc3dj
# pIdvTFE41uRfx5+2gSrkhUh5WF47+NsCgmfBOdvDdEs9Nh75KZOIaFuoRBkh8Kfo
# gQ0s6JM2tDeyyrAbJnqaJR+amoCeSyo/+6Oa/nMyccKexnLhimgn8eQPtMRMpWGT
# +JcQByowJam5yHG472jMLX714H4Pgqhvtrpsg0N3zYqSF6GeW3gWPUXiM3Ld4WbK
# mdPJxSb9DWgERq622ZuMvhm+scbyGeNcAsos2G9KB9nJNdpAdfLEpxlvnkIQmHXm
# lYtgvO3FEteKztWYXFaWA8XudwY1/8/k7j8TYe7b2i2F8M2unbIYCUXDkqFyF/xH
# tqALLPHE3kNoCGpfO/B2Y/vMBiymxuIOtbm+JI8wggaUMIIEfKADAgECAhAr1K5w
# udBjWyrphMjWdKowMA0GCSqGSIb3DQEBDAUAMFYxCzAJBgNVBAYTAlBMMSEwHwYD
# VQQKExhBc3NlY28gRGF0YSBTeXN0ZW1zIFMuQS4xJDAiBgNVBAMTG0NlcnR1bSBU
# aW1lc3RhbXBpbmcgMjAyMSBDQTAeFw0yMjA3MjgwODU2MjZaFw0zMzA3MjcwODU2
# MjZaMFAxCzAJBgNVBAYTAlBMMSEwHwYDVQQKDBhBc3NlY28gRGF0YSBTeXN0ZW1z
# IFMuQS4xHjAcBgNVBAMMFUNlcnR1bSBUaW1lc3RhbXAgMjAyMjCCAiIwDQYJKoZI
# hvcNAQEBBQADggIPADCCAgoCggIBAMrFXu0fCUbwRMtqXliGb6KwhLCeP4vySHEq
# QBI78xFcjqQae26x7v21UvkWS+X0oTh61yTcdoZaQAg5hNcBqWbGn7b8OOEXkGwU
# vGZ65MWKl2lXBjisc6d1GWVI5fXkP9+ddLVX4G/pP7eIdAtI5Fh4rGC/x9/vNan9
# C8C4I56N525HwiKzqPSz6Z5N2XYM0+bT4VdYsZxyPRwLkjhcqdzg2tCB2+YP6ld+
# uBOkcfCrhFCeeTB4Y/ZalrZXaCGFIlBWjIyXb9UGspAaoDvP2LCSSRcnvrP49qII
# GD7TqHbDoYumubWDgx8/YE7M5Bfd7F14mQOqnr7ImCFS5Ty/nfSO7XVSQ6TrlIYX
# 8rLA4BSjnOu0WoYZTLOWyaekWPraAAhvzJQ3mXt6ruGa6VEljyzDTUfgEmSDpnxP
# 6OFSOOc4xBOXbkV8OO4ivGf0pIff+IOsysOwvuSSHfF1FxSerNZb3VcUneyQaT+o
# mC+kaGTPpvsyly53V/MUKuHVhgRIrGiWIJgN9Tr73oZXHk6mbuzkXiHhao/1AQrQ
# 35q+mtGKvnXtf62dsJFztYf/XceELTw/KJd1YL7hlQ9zGR/fFE+fx9pvLd2yZ3Y1
# PCtpaNzq6i7JZ2mRldC1XwikBtjoQ6GT2T3kyRn0lAU8Y4/TdN/4pptwouFk+75J
# sdToPQ6BAgMBAAGjggFiMIIBXjAMBgNVHRMBAf8EAjAAMB0GA1UdDgQWBBQjwTzM
# UzMZVo7Y4/POPPyoc0dW6jAfBgNVHSMEGDAWgBS+VAIvv0Bsc0POrAklTp5DRBru
# 4DAOBgNVHQ8BAf8EBAMCB4AwFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwgwMwYDVR0f
# BCwwKjAooCagJIYiaHR0cDovL2NybC5jZXJ0dW0ucGwvY3RzY2EyMDIxLmNybDBv
# BggrBgEFBQcBAQRjMGEwKAYIKwYBBQUHMAGGHGh0dHA6Ly9zdWJjYS5vY3NwLWNl
# cnR1bS5jb20wNQYIKwYBBQUHMAKGKWh0dHA6Ly9yZXBvc2l0b3J5LmNlcnR1bS5w
# bC9jdHNjYTIwMjEuY2VyMEAGA1UdIAQ5MDcwNQYLKoRoAYb2dwIFAQswJjAkBggr
# BgEFBQcCARYYaHR0cDovL3d3dy5jZXJ0dW0ucGwvQ1BTMA0GCSqGSIb3DQEBDAUA
# A4ICAQBrxvc9Iz4vV5D57BeApm1pfVgBjTKWgflb1htxJA9HSvXneq/j/+5kohu/
# 1p0j6IJMYTpSbT7oHAtg59m0wM0HnmrjcN43qMNo5Ts/gX/SBmY0qMzdlO6m1D9e
# gn7U49EgGO+IZFAnmMH1hLx+pse6dgtThZ4aqr+zRfRNoTFNSUxyOSo6cmVKfRbZ
# gTiLEcMehGJTeM5CQs1AmDpF+hqyq0X6Mv0BMtHU2wPoVlI3xrRQ167lM64/gl8d
# CYzMPF8l8W89ds2Rfro9Y1p5dI0L8x60opb1f8n5Hf4ayW9Kc7rgUdlnfJc4cYdv
# V0JxWYpSZPN5LJM54xSKrveXnYq1NNIuovqJOM9mixVMJ2TTWPkfQ2pl0H/Zokxx
# XB4qEKAySa6bfcijoQiOaR5wKQR+0yrc7KIdqt+hOVhl5uUti9cZxA8JMiNdX6Sa
# asglnJ9olTSMJ4BRO6tCASEvJeeCzX6ZViKRDHbFQCaMZ1XdxlwR6Cqkfa2p5EN1
# DKQSjxI1p6lddQmc9PTVGWM8dpbRKtHHBoOQvfWEdigP3EI7RGZqWTonwr8AaMCg
# TzYbFpuZed3lG7yi0jwUJo9/ryUNFA82m9CpzLcaAKaLQ0s1uboR6zaWSt9fqUAS
# Nz9zD+8IiGlyUqKIAFViQMqqyHej0vK7G2gPqEy5GDdxL/DBaTCCBrkwggShoAMC
# AQICEQCZo4AKJlU7ZavcboSms+o5MA0GCSqGSIb3DQEBDAUAMIGAMQswCQYDVQQG
# EwJQTDEiMCAGA1UEChMZVW5pemV0byBUZWNobm9sb2dpZXMgUy5BLjEnMCUGA1UE
# CxMeQ2VydHVtIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MSQwIgYDVQQDExtDZXJ0
# dW0gVHJ1c3RlZCBOZXR3b3JrIENBIDIwHhcNMjEwNTE5MDUzMjE4WhcNMzYwNTE4
# MDUzMjE4WjBWMQswCQYDVQQGEwJQTDEhMB8GA1UEChMYQXNzZWNvIERhdGEgU3lz
# dGVtcyBTLkEuMSQwIgYDVQQDExtDZXJ0dW0gQ29kZSBTaWduaW5nIDIwMjEgQ0Ew
# ggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCdI88EMCM7wUYs5zNzPmNd
# enW6vlxNur3rLfi+5OZ+U3iZIB+AspO+CC/bj+taJUbMbFP1gQBJUzDUCPx7BNLg
# id1TyztVLn52NKgxxu8gpyTr6EjWyGzKU/gnIu+bHAse1LCitX3CaOE13rbuHbtr
# xF2tPU8f253QgX6eO8yTbGps1Mg+yda3DcTsOYOhSYNCJiL+5wnjZ9weoGRtvFgM
# HtJg6i671OPXIciiHO4Lwo2p9xh/tnj+JmCQEn5QU0NxzrOiRna4kjFaA9ZcwSaG
# 7WAxeC/xoZSxF1oK1UPZtKVt+yrsGKqWONoK6f5EmBOAVEK2y4ATDSkb34UD7JA3
# 2f+Rm0wsr5ajzftDhA5mBipVZDjHpwzv8bTKzCDUSUuUmPo1govD0RwFcTtMXcfJ
# tm1i+P2UNXadPyYVKRxKQATHN3imsfBiNRdN5kiVVeqP55piqgxOkyt+HkwIA4gb
# mSc3hD8ke66t9MjlcNg73rZZlrLHsAIV/nJ0mmgSjBI/TthoGJDydekOQ2tQD2Du
# p/+sKQptalDlui59SerVSJg8gAeV7N/ia4mrGoiez+SqV3olVfxyLFt3o/OQOnBm
# jhKUANoKLYlKmUpKEFI0PfoT8Q1W/y6s9LTI6ekbi0igEbFUIBE8KDUGfIwnisEk
# Bw5KcBZ3XwnHmfznwlKo8QIDAQABo4IBVTCCAVEwDwYDVR0TAQH/BAUwAwEB/zAd
# BgNVHQ4EFgQU3XRdTADbe5+gdMqxbvc8wDLAcM0wHwYDVR0jBBgwFoAUtqFUOQLD
# oD+Oirz61PgcptE6Dv0wDgYDVR0PAQH/BAQDAgEGMBMGA1UdJQQMMAoGCCsGAQUF
# BwMDMDAGA1UdHwQpMCcwJaAjoCGGH2h0dHA6Ly9jcmwuY2VydHVtLnBsL2N0bmNh
# Mi5jcmwwbAYIKwYBBQUHAQEEYDBeMCgGCCsGAQUFBzABhhxodHRwOi8vc3ViY2Eu
# b2NzcC1jZXJ0dW0uY29tMDIGCCsGAQUFBzAChiZodHRwOi8vcmVwb3NpdG9yeS5j
# ZXJ0dW0ucGwvY3RuY2EyLmNlcjA5BgNVHSAEMjAwMC4GBFUdIAAwJjAkBggrBgEF
# BQcCARYYaHR0cDovL3d3dy5jZXJ0dW0ucGwvQ1BTMA0GCSqGSIb3DQEBDAUAA4IC
# AQB1iFgP5Y9QKJpTnxDsQ/z0O23JmoZifZdEOEmQvo/79PQg9nLF/GJe6ZiUBEyD
# BHMtFRK0mXj3Qv3gL0sYXe+PPMfwmreJHvgFGWQ7XwnfMh2YIpBrkvJnjwh8gIlN
# lUl4KENTK5DLqsYPEtRQCw7R6p4s2EtWyDDr/M58iY2UBEqfUU/ujR9NuPyKk0bE
# cEi62JGxauFYzZ/yld13fHaZskIoq2XazjaD0pQkcQiIueL0HKiohS6XgZuUtCKA
# 7S6CHttZEsObQJ1j2s0urIDdqF7xaXFVaTHKtAuMfwi0jXtF3JJphrJfc+FFILgC
# bX/uYBPBlbBIP4Ht4xxk2GmfzMn7oxPITpigQFJFWuzTMUUgdRHTxaTSKRJ/6Uh7
# ki/pFjf9sUASWgxT69QF9Ki4JF5nBIujxZ2sOU9e1HSCJwOfK07t5nnzbs1LbHuA
# IGJsRJiQ6HX/DW1XFOlXY1rc9HufFhWU+7Uk+hFkJsfzqBz3pRO+5aI6u5abI4Qw
# s4YaeJH7H7M8X/YNoaArZbV4Ql+jarKsE0+8XvC4DJB+IVcvC9Ydqahi09mjQse4
# fxfef0L7E3hho2O3bLDM6v60rIRUCi2fJT2/IRU5ohgyTch4GuYWefSBsp5NPJh4
# QRTP9DC3gc5QEKtbrTY0Ka87Web7/zScvLmvQBm8JDFpDjCCBrkwggShoAMCAQIC
# EQDn/2nHOzXOS5Em2HR8aKWHMA0GCSqGSIb3DQEBDAUAMIGAMQswCQYDVQQGEwJQ
# TDEiMCAGA1UEChMZVW5pemV0byBUZWNobm9sb2dpZXMgUy5BLjEnMCUGA1UECxMe
# Q2VydHVtIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MSQwIgYDVQQDExtDZXJ0dW0g
# VHJ1c3RlZCBOZXR3b3JrIENBIDIwHhcNMjEwNTE5MDUzMjA3WhcNMzYwNTE4MDUz
# MjA3WjBWMQswCQYDVQQGEwJQTDEhMB8GA1UEChMYQXNzZWNvIERhdGEgU3lzdGVt
# cyBTLkEuMSQwIgYDVQQDExtDZXJ0dW0gVGltZXN0YW1waW5nIDIwMjEgQ0EwggIi
# MA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDpEh8ENe25XXrFppVBvoplf053
# 0W0lddNmjtv4YSh/f7eDQKFaIqc7tHj7ox+u8vIsJZlroakUeMS3i3T8aJRC+eQs
# 4FF0GqvkM6+WZO8kmzZfxmZaBYmMLs8FktgFYCzywmXeQ1fEExflee2OpbHVk665
# eXRHjH7MYZIzNnjl2m8Hy8ulB9mR8wL/W0v0pjKNT6G0sfrx1kk+3OGosFUb7yWN
# nVkWKU4qSxLv16kJ6oVJ4BSbZ4xMak6JLeB8szrK9vwGDpvGDnKCUMYL3NuviwH1
# x4gZG0JAXU3x2pOAz91JWKJSAmRy/l0s0l5bEYKolg+DMqVhlOANd8Yh5mkQWaME
# vBRE/kAGzIqgWhwzN2OsKIVtO8mf5sPWSrvyplSABAYa13rMYnzwfg08nljZHghq
# uCJYCa/xHK9acev9UD7Y+usr15d7mrszzxhF1JOr1Mpup2chNSBlyOObhlSO16rw
# rffVrg/SzaKfSndS5swRhr8bnDqNJY9TNyEYvBYpgF95K7p0g4LguR4A++Z1nFIH
# WVY5v0fNVZmgzxD9uVo/gta3onGOQj3JCxgYx0KrCXu4yc9QiVwTFLWbNdHFSjBC
# t5/8Q9pLuRhVocdCunhcHudMS1CGQ/Rn0+7P+fzMgWdRKfEOh/hjLrnQ8BdJiYrZ
# NxvIOhM2aa3zEDHNwwIDAQABo4IBVTCCAVEwDwYDVR0TAQH/BAUwAwEB/zAdBgNV
# HQ4EFgQUvlQCL79AbHNDzqwJJU6eQ0Qa7uAwHwYDVR0jBBgwFoAUtqFUOQLDoD+O
# irz61PgcptE6Dv0wDgYDVR0PAQH/BAQDAgEGMBMGA1UdJQQMMAoGCCsGAQUFBwMI
# MDAGA1UdHwQpMCcwJaAjoCGGH2h0dHA6Ly9jcmwuY2VydHVtLnBsL2N0bmNhMi5j
# cmwwbAYIKwYBBQUHAQEEYDBeMCgGCCsGAQUFBzABhhxodHRwOi8vc3ViY2Eub2Nz
# cC1jZXJ0dW0uY29tMDIGCCsGAQUFBzAChiZodHRwOi8vcmVwb3NpdG9yeS5jZXJ0
# dW0ucGwvY3RuY2EyLmNlcjA5BgNVHSAEMjAwMC4GBFUdIAAwJjAkBggrBgEFBQcC
# ARYYaHR0cDovL3d3dy5jZXJ0dW0ucGwvQ1BTMA0GCSqGSIb3DQEBDAUAA4ICAQC4
# k1l3yUwV/ZQHCKCneqAs8EGTnwEUJLdDpokN/dMhKjK0rR5qX8nIIHzxpQR3TAw2
# IRw1Uxsr2PliG3bCFqSdQTUbfaTq6V3vBzEebDru9QFjqlKnxCF2h1jhLNFFplbP
# JiW+JSnJTh1fKEqEdKdxgl9rVTvlxfEJ7exOn25MGbd/wGPwuSmMxRJVO0wnqgS7
# kmoJjNF9zqeehFSDDP8ZVkWg4EZ2tIS0M3uZmByRr+1Lkwjjt8AtW83mVnZTyTsO
# b+FNfwJY7DS4FmWhkRbgcHRetreoTirPOr/ozyDKhT8MTSTf6Lttg6s6T/u08mDW
# w6HK04ZRDfQ9sb77QV8mKgO44WGP31vXnVKoWVJpFBjPvjL8/Zck/5wXX2iqjOaL
# StFOR/IQki+Ehn4zlcgVm22ZVCBPF+l8nAwUUShCtKuSU7GmZLKCmmxQMkSiWILT
# m8EtVD6AxnJhoq8EnhjEEyUoflkeRF2WhFiVQOmWTwZRr44IxWGkNJC6tTorW5rl
# 2Zl+2e9JLPYf3pStAPMDoPKIjVXd6NW2+fZrNUBeDo2eOa5Fn7Brs/HLQff5Xgri
# s5MeUbdVgDrF8uxO6cLPvZPo63j62SsNg55pTWk9fUIF9iPoRbb4QurjoY/woI1R
# AOKtYtTic6aAJq3u83RIPpGXBSJKwx4KJAOZnCDCtTCCBsAwggSooAMCAQICED8v
# Bp9ca4iemmXFUwZ0lhUwDQYJKoZIhvcNAQELBQAwVjELMAkGA1UEBhMCUEwxITAf
# BgNVBAoTGEFzc2VjbyBEYXRhIFN5c3RlbXMgUy5BLjEkMCIGA1UEAxMbQ2VydHVt
# IENvZGUgU2lnbmluZyAyMDIxIENBMB4XDTIyMDQxNDA5MjEzOFoXDTI1MDQxMzA5
# MjEzN1owZjELMAkGA1UEBhMCUEwxETAPBgNVBAcMCFdhcnN6YXdhMSEwHwYDVQQK
# DBhQb3dlckNsb3VkcyBNaWNoYWwgR2FqZGExITAfBgNVBAMMGFBvd2VyQ2xvdWRz
# IE1pY2hhbCBHYWpkYTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAJ63
# 7GRbgQJUvUNKP3FzAYN7fJOtedwq479SwdCMMbfBMoQxkm6QLyAdec8qWu2D0fcq
# 10b0vnkD7HnlUKXkqlrLgBOvEBQp2zkHpm7bZqh7e16leVpCTw875q6+1P6vRzMm
# 9MDv/DsW+blX20kFM7JFfRmwbKmJ+i/yxkWCEv2lVAGpz5oBbH8WyDyzUlKCDHmI
# 5JCUu/HEtv3uaGksMXGhuCqd1uMKq4swRXlypjr44OFUkEAQfjjblSQwRWRfnSDj
# Y8Wgd579kDj7lozHxF/27WkDrJWq9wegnBeO6i7av/Hqyz5v1JxTK9QhyNeiTIC1
# O3KtQ7ATaNYO/OeFs+aW2GfaXOyzrIBpNN6vJOBxXR/yeGzZAWhrxNkwWL982Mvy
# itaymr/RnUfA02QPUyHYHomcP+6c7Ld+PvswGEydbNJVMcf5lgMbBgOyCZRt/yIP
# oy8QbMvCLI/zeIvqu9yyRKwo2hw8HUvKlM/5O+4YYh2ZCF41+PVjaazro7+w7bv7
# 0kDiNbE0UVBDplMhNOXt99/3VujN4qMj4ITvFsC04Ob4ayLXtiuGB5RWTVilU4qM
# GGdeOMwn0yH4JVZ/ECsSz8DRlkfNd4AJibFoyyjyFdTkVIJRMy3gyPE8VqbPn17R
# /3yoouRV8WKhCpT8P8na7j/5QUl6DNmD3dvqIP7VAgMBAAGjggF4MIIBdDAMBgNV
# HRMBAf8EAjAAMD0GA1UdHwQ2MDQwMqAwoC6GLGh0dHA6Ly9jY3NjYTIwMjEuY3Js
# LmNlcnR1bS5wbC9jY3NjYTIwMjEuY3JsMHMGCCsGAQUFBwEBBGcwZTAsBggrBgEF
# BQcwAYYgaHR0cDovL2Njc2NhMjAyMS5vY3NwLWNlcnR1bS5jb20wNQYIKwYBBQUH
# MAKGKWh0dHA6Ly9yZXBvc2l0b3J5LmNlcnR1bS5wbC9jY3NjYTIwMjEuY2VyMB8G
# A1UdIwQYMBaAFN10XUwA23ufoHTKsW73PMAywHDNMB0GA1UdDgQWBBR1wCgJh2UM
# Eox+qLHhPcQgQAHlMTBLBgNVHSAERDBCMAgGBmeBDAEEATA2BgsqhGgBhvZ3AgUB
# BDAnMCUGCCsGAQUFBwIBFhlodHRwczovL3d3dy5jZXJ0dW0ucGwvQ1BTMBMGA1Ud
# JQQMMAoGCCsGAQUFBwMDMA4GA1UdDwEB/wQEAwIHgDANBgkqhkiG9w0BAQsFAAOC
# AgEAFfEqwEUuMoDP0K9UzZC/r7gzJQAkNPdazaL72odSx3AaSt1e8g7vP4VfGE8j
# ThfBxk01yOHJBjowg7ENYhVwndCE7QtJy5kJ47jdlIsyuQ3JcFtocLJYgZTVCUOb
# cCHy6jQcxdwQMCZpQHVzYCTgBF9O6dOVI/7hx3tzcy+Zni05BwcpMoV3REAWlr3K
# cR38OgBesAJ0M8BzdyUTM99vDmMkbBuz03KyTlLKI0oJC0wCdieoZF9GQuNvve00
# 8fUztSdSqcRUCqz63rhrtAIhRINIghMYQHhuGUVQi7ACF6RmPvI8is/C/ZNjyrsK
# XI3hs5NKmGH8kZMGVb12BI8XltAJ5buzeMCCAufPjGDd6iNm5I+Fdh0vkDHRjJpm
# hercrYK8/T9JhmHTFOnvmc0jrS1X0Oyikj/KaQHB9gVLvsqZ6WiGy3YECMJGYk0s
# Nkkrrq9ReVqsA2GOAvkH9ZTLEi481p/o8L0DNbPUYfE1t41QJmCMP3CWkgsMfmCx
# h2KYCFO+B+1TIwq/IvjaspWkZlb0vz+/3/6+uR/7p/G58fGCSyxwAfRCqh/H75iW
# rhlDY/Omsj1gE0uSbC5JCF/4h1P+PC7ZxhQ31u45kmjf1G0WxUtAwZ8W6WI3dIBW
# 18U37Z/jCxG2nersGWXALiR7gp22R50s1QU9SPXRoEaRJpwxggciMIIHHgIBATBq
# MFYxCzAJBgNVBAYTAlBMMSEwHwYDVQQKExhBc3NlY28gRGF0YSBTeXN0ZW1zIFMu
# QS4xJDAiBgNVBAMTG0NlcnR1bSBDb2RlIFNpZ25pbmcgMjAyMSBDQQIQPy8Gn1xr
# iJ6aZcVTBnSWFTANBglghkgBZQMEAgEFAKCBhDAYBgorBgEEAYI3AgEMMQowCKAC
# gAChAoAAMBkGCSqGSIb3DQEJAzEMBgorBgEEAYI3AgEEMBwGCisGAQQBgjcCAQsx
# DjAMBgorBgEEAYI3AgEVMC8GCSqGSIb3DQEJBDEiBCBvoI6h/83Z58M0iERDHdXc
# nnvoYXsIf9d7smZArYPqxTANBgkqhkiG9w0BAQEFAASCAgCFQNsHwXANaYD7yy+A
# 5vcsu9nNHZPH2svEB2ScSFqvsX2SQrH1wYCZfKcHLWFjuBlhLfPc1N7Nnhy2CHHx
# HFD+w/JWSJbTY8b0m1RbIPL4POcJljanB4H5jgVFkR2vEhG3JwpAsFMDhCKtiOcB
# 0v4XboTDzJEi9BjHpm/RIrjCT598R5f/EKZckjKNqyejDZ5//mjrigyccPyJStja
# 6vubf4XgvqhwwFrI2sm2TEBkwnqkp7StBHfqoXX32FGlU0e2u2CEoZChO5dfmTx5
# tMkkZt/IdWShh8ShH1fY981S/397qP+nINAvLkUnpJe6k9GImH7FqwiSHY27bGmC
# RwyUU5cbZPp9aldqbSDJVmS+cfMvgArAgtyieQAXuc1aeD/ilDalyOat0mNuJ0uB
# HkVTLzDY2z3kmH1a2kdiTgJtlKV5FU4HtAVpBdOaTA7NUCOJNoeoY3LEDbye8OF5
# El6LQgCgywyK3vHL6ZJvc9AoIwjpbHMhWyJzTXImtTkVdYHTAwbxga4+vSotYEJN
# 8aqtXMAPHtpZTMl0w8dubwNEoDaW6gQHUtP9+dppizD38yjQ98cEFORIPpZsKdPp
# kC+28BVpH5xrxv+s8B9rGzT7S79FBR2oNhzlBprbQO2+G+Leecgcrs3HvliKyObA
# H80MniHgXYYR6yBeBTFx9/Est6GCBAIwggP+BgkqhkiG9w0BCQYxggPvMIID6wIB
# ATBqMFYxCzAJBgNVBAYTAlBMMSEwHwYDVQQKExhBc3NlY28gRGF0YSBTeXN0ZW1z
# IFMuQS4xJDAiBgNVBAMTG0NlcnR1bSBUaW1lc3RhbXBpbmcgMjAyMSBDQQIQK9Su
# cLnQY1sq6YTI1nSqMDANBglghkgBZQMEAgIFAKCCAVYwGgYJKoZIhvcNAQkDMQ0G
# CyqGSIb3DQEJEAEEMBwGCSqGSIb3DQEJBTEPFw0yMjExMTgxNjE4NDNaMDcGCyqG
# SIb3DQEJEAIvMSgwJjAkMCIEIAO5mmRJdJhKlbbMXYDTRNB0+972yiQEhCvmzw5E
# IgeKMD8GCSqGSIb3DQEJBDEyBDATCVL0au24GuHxPPXgibo6ms8ZTv+sWW94uvCD
# AzJe3073rUZ9I1MblTkbTsHHP04wgZ8GCyqGSIb3DQEJEAIMMYGPMIGMMIGJMIGG
# BBS/T2vEmC3eFQWo78jHp51NFDUAzjBuMFqkWDBWMQswCQYDVQQGEwJQTDEhMB8G
# A1UEChMYQXNzZWNvIERhdGEgU3lzdGVtcyBTLkEuMSQwIgYDVQQDExtDZXJ0dW0g
# VGltZXN0YW1waW5nIDIwMjEgQ0ECECvUrnC50GNbKumEyNZ0qjAwDQYJKoZIhvcN
# AQEBBQAEggIAV/3hBAoKeV+7h4NePI+V7pTB8uPVVCntn08D5ccpneF9rZ0tq9ew
# xc+MOIXwTbGxWt3wbiTn2yUPMjpVx5FSQCOooYrHMFMHu8+Sz6s0quBoD0gFQjh3
# +j9/x3D9IKGMYh9/FZHMS003+dzIZeaMpPO6UAWzR8g2PLrZNOEY/rK4h/H3+QYI
# +LcRQXfYg0jdU0Bz+7Q7kpclN6NzXRaz0R7xGllR54A2Zp0q+k4+pa+Dk76IINLA
# VY+MqjxU5QZz/a57YNIdykR+n6M8ygT4BdIFDz1tM0TPtPJWBdC6QIYluLwmgY/A
# 36po7KS7npqHpqdohxc5l/eWoNZ8jdJlCd6nDYXfRHjhUrYubKMZd9NRZP5R7lTB
# 4N7PwFDaxKIZVkZSSEql9fRVd5vWqGL92nqSiSFD4k543tviMDFkkMmY4mppoI2X
# m21g2KY8ONGSGIlkO03BfgflDfktgF3N2i6mOEdw6u2C1iUJKlHIUoQch6+bPrOu
# aiihzQvtwf/yOi1AqjX5O1n65RxUnbe5rUSKEgiTM84YbJ/Eq819k/Ixr1y8bhoH
# mxQJhLdTEgs/BBLD3topsdvXFGGhUodWAFXZUaa8PTV4TgNXhujx+FsLYkJIRSqT
# JSs5VpUYzpg81aUtfVR1CjBS4JaejDokqEoLxIyff4lzam+0ksCnkWc=
# SIG # End signature block
