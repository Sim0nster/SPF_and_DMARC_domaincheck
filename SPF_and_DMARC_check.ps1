# Array mit  Domains
$domains = @("insertdomain.com;")

foreach ($domain in $domains) {
  
        # Auflösung des SPF-Records
        $spfResult = Resolve-DnsName -Name $domain -Type TXT | Where-Object { $_.Strings -like "v=spf1*" }

        # Ausgabe der SPF-Records
        foreach ($spf in $spfResult) {
           Write-Host "$domain SPF:" $spf.Strings
        }

        # Auflösung des DMARC-Records
        $dmarcResult = Resolve-DnsName -Name "_dmarc.$domain" -Type TXT | Where-Object { $_.Strings -like "*v=DMARC*" }

        # Ausgabe der DMARC-Records
        foreach ($dmarc in $dmarcResult) {
            Write-Host "$domain DMARC:" $dmarc.Strings `n
        }
}