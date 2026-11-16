\# Attaques jouées



Poste de test uniquement. Chaque attaque est nettoyée juste après.



| Technique | Commande |

|---|---|

| T1547.001 | `Run-Atomic T1547.001 1` (Atomic Red Team, « Reg Key Run ») |

| T1087.001 | `Run-Atomic T1087.001 8` (Atomic Red Team, « Enumerate all accounts on Windows ») |

| T1053.005 | `Run-Atomic T1053.005 2` (Atomic Red Team, « Scheduled task Local ») |

| T1197 | `bitsadmin /transfer LabJob /download /priority normal https://example.com C:\\purple-lab\\evidence\\test\_bits.html` (simulation manuelle) |

| T1547.001 (variante) | `New-ItemProperty -Path "HKCU:\\Software\\Microsoft\\Windows\\CurrentVersion\\Run" -Name "LabRunPS" -Value "C:\\Windows\\System32\\notepad.exe" -PropertyType String`, supprimée juste après |



`Run-Atomic` est une petite fonction qui lance le test Atomic, attend 5 secondes, puis lance son nettoyage.

