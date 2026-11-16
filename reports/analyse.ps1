$motifs = [ordered]@{
  'T1547.001' = 'Atomic Red Team'
  'T1087.001' = '(?i)net1?\s+(user|localgroup)|cmdkey'
  'T1053.005' = '(?i)schtasks[^"]{0,200}/create'
  'T1197'     = '(?i)LabJob|bitsadmin[^"]{0,200}/transfer'
}
$avant = @()
$apres = @()
if (Test-Path C:\purple-lab\evidence\avant.json) { $avant = Get-Content C:\purple-lab\evidence\avant.json -Raw | ConvertFrom-Json }
if (Test-Path C:\purple-lab\evidence\apres.json) { $apres = Get-Content C:\purple-lab\evidence\apres.json -Raw | ConvertFrom-Json }
$lignes = @('technique,detecte_avant,detecte_apres,regle')
foreach ($t in $motifs.Keys) {
  $p = $motifs[$t]
  $ha = @($avant | Where-Object { ($_ | ConvertTo-Json -Depth 20 -Compress) -match $p })
  $hb = @($apres | Where-Object { ($_ | ConvertTo-Json -Depth 20 -Compress) -match $p })
  $noms = (@($hb | ForEach-Object { $_.name }) + @($ha | ForEach-Object { $_.name }) | Where-Object { $_ } | Sort-Object -Unique) -join ' / '
  $noms = $noms -replace ',', ';'
  $av = 'Non'
  if ($ha.Count -gt 0) { $av = 'Oui' }
  $ap = 'Non'
  if (($ha.Count + $hb.Count) -gt 0) { $ap = 'Oui' }
  $lignes += "$t,$av,$ap,$noms"
}
$lignes | Set-Content C:\purple-lab\reports\matrice.csv -Encoding ascii
Import-Csv C:\purple-lab\reports\matrice.csv | Format-Table -AutoSize -Wrap