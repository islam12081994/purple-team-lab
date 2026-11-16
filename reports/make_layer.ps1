$rows = Import-Csv C:\purple-lab\reports\matrice.csv
foreach ($col in 'detecte_avant','detecte_apres') {
  $techniques = @()
  foreach ($r in $rows) {
    $score = 0
    if ($r.$col -eq 'Oui') { $score = 100 }
    if ($r.$col -eq 'Partiel') { $score = 50 }
    $techniques += @{ techniqueID = $r.technique; score = $score; comment = $r.regle }
  }
  $layer = @{
    name = "Couverture lab ($col)"
    domain = "enterprise-attack"
    versions = @{ layers = "4.5"; navigator = "5.0.0" }
    techniques = @($techniques)
    gradient = @{ colors = @("#ff6666","#ffe766","#66ff66"); minValue = 0; maxValue = 100 }
  }
  $name = $col -replace 'detecte_',''
  $layer | ConvertTo-Json -Depth 6 | Set-Content "C:\purple-lab\reports\layer_$name.json" -Encoding ascii
}