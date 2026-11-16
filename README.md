\# Purple Team Lab minimal



J'ai monté un petit lab purple team sur mon poste Windows : je joue quelques attaques, je regarde les traces qu'elles laissent, puis je mesure ce que les règles de détection publiques repèrent. Là où elles ne voient rien, j'écris la mienne.



\## Outils

Sysmon (configuration SwiftOnSecurity) pour les traces, Atomic Red Team et quelques commandes manuelles pour les attaques, Chainsaw avec les règles Sigma de la communauté pour la détection, ATT\&CK Navigator pour la visualisation.



\## Premier tour : 4 techniques classiques

Les règles de la communauté détectent les quatre.



| Technique | Attaque | Détectée |

|---|---|---|

| T1547.001 | Clé Run ajoutée avec reg.exe | Oui |

| T1087.001 | Liste des comptes locaux | Oui |

| T1053.005 | Création d'une tâche planifiée | Oui |

| T1197 | Téléchargement avec bitsadmin | Oui |



\## Deuxième tour : une variante plus discrète

Même technique (T1547.001), mais la valeur de la clé Run est ajoutée avec PowerShell au lieu de reg.exe. Chainsaw avec les règles de la communauté ne l'a pas détectée. J'ai écrit la règle `detections/run\_key\_powershell.yml` : elle repère une modification de clé Run faite par powershell.exe. Testée sur mes logs, elle détecte la variante.



\## Résultats

Avant ma règle : !\[avant](reports/heatmap\_avant.png)



Après ma règle : !\[après](reports/heatmap\_apres.png)



La matrice complète est dans `reports/matrice.csv`.



Ce que j'en retiens : les règles publiques couvrent bien les attaques classiques, mais il suffit de changer d'outil (PowerShell au lieu de reg.exe) pour passer sous le radar. Et une fois qu'on a vu la trace dans les logs, écrire sa propre règle va assez vite.



\## Limites

Un seul poste, cinq scénarios, pas de SIEM. Ma règle a été testée sur une seule exécution de la variante : elle peut produire des faux positifs ailleurs. Certains noms de règles de la communauté qui apparaissent dans les résultats viennent de mes propres commandes de vérification, pas des attaques. Les attaques sont décrites dans `attacks/commandes.md`.



\## Suite possible

Règles réseau avec Suricata, validation automatique des règles Sigma en CI, plus de techniques.

