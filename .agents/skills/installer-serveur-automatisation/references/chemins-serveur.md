# Chemins serveur

## VPS

Avantages :

- IP publique et SSH direct.
- Redémarrage et console depuis le panneau fournisseur.
- Snapshots et sauvegardes souvent disponibles.
- Plus simple pour une machine accessible depuis l'extérieur.

Points d'attention :

- Les prix et promotions changent ; vérifier au moment de l'achat.
- Un VPS pas cher a peu de RAM. 2 Go est le minimum utile ; 4 Go rend n8n et Node plus confortables.
- Le fournisseur ne sécurise pas votre application à votre place.
- Garder n8n en `127.0.0.1` et utiliser un tunnel SSH.

Hostinger est souvent plus guidé pour débutants. OVHcloud est très pertinent en France et expose davantage les notions infra. Pour un premier serveur, conseiller Ubuntu LTS, SSH par clé, snapshot, et un pare-feu qui n'ouvre que SSH.

Références :

- Hostinger SSH VPS : https://support.hostinger.com/en/articles/1583780-how-to-connect-to-your-vps-using-ssh
- Hostinger mise en route VPS : https://www.hostinger.com/tutorials/how-to-set-up-vps
- OVHcloud VPS premiers pas : https://help.ovhcloud.com/csm/en-gb-vps-getting-started?id=kb_article_view&sysparm_article=KB0047701
- OVHcloud Public Cloud SSH : https://help.ovhcloud.com/csm/en-gb-public-cloud-compute-connect-instance-ssh?id=kb_article_view&sysparm_article=KB0043284

## Serveur maison

Avantages :

- Pas de coût mensuel direct.
- Très bon support pédagogique pour comprendre réseau local, routeur, NAT, stockage et sauvegardes.
- Possibilité d'utiliser du matériel déjà disponible.

Points d'attention :

- L'IP locale du serveur n'est pas une IP publique.
- L'accès depuis Internet demande routeur, DNS, HTTPS, parfois gestion du CGNAT.
- Une coupure électrique ou une box redémarrée arrête les automatisations.
- Sécuriser les sauvegardes devient votre responsabilité.

Pour débuter, recommander un accès local ou SSH via VPN/tunnel plutôt qu'une exposition publique.

## Différence mentale

Sur VPS, le problème principal est "ne pas trop ouvrir Internet". Sur serveur maison, le problème principal est "comprendre quel réseau voit quoi".
