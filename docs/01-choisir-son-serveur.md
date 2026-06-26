# 01 - Choisir son serveur

Vous avez besoin d'une machine qui reste disponible pendant vos automatisations. Deux chemins sont possibles : louer un VPS ou utiliser un serveur maison.

## Chemin A : VPS

Un VPS est une petite machine Linux louée chez un hébergeur. C'est le chemin le plus direct si vous voulez une machine accessible par SSH depuis n'importe où.

Cherchez plutôt :

- Ubuntu LTS récent.
- 2 Go de RAM minimum ; 4 Go est plus confortable pour n8n, Node, Codex et Claude Code.
- Accès SSH par clé publique.
- Snapshot ou sauvegarde avant les manipulations risquées.
- Pare-feu simple : SSH ouvert, n8n fermé au public.

## Chemin B : serveur maison

Un serveur maison est une machine chez vous : mini-PC, vieux laptop, NAS Linux, Raspberry Pi récent. C'est très utile si vous voulez comprendre votre propre infrastructure.

Points à comprendre :

- Votre serveur a souvent une IP locale (`192.168.x.x`) derrière une box.
- Le `localhost` du serveur n'est pas le `localhost` de votre ordinateur.
- L'accès depuis Internet dépend du routeur, du NAT, parfois du CGNAT de l'opérateur.
- L'IP publique peut changer.
- Les coupures électriques et le Wi-Fi instable deviennent des sujets d'infrastructure.

Pour débuter, travaillez en réseau local, via VPN, Tailscale, WireGuard ou SSH déjà configuré. N'exposez un service public qu'après avoir compris HTTPS, DNS, reverse proxy et authentification.

## Parcours France : Hostinger

Hostinger est souvent choisi par des débutants parce que le panneau de gestion est guidé et que les VPS KVM proposent des images prêtes à l'emploi. Vérifiez toujours les prix et options au moment de l'achat.

À regarder pendant la création :

- Choisir une localisation proche de la France si disponible.
- Choisir Ubuntu LTS.
- Ajouter une clé SSH dès la création si le panneau le propose.
- Activer les sauvegardes/snapshots si le budget le permet.
- Garder les ports applicatifs fermés ; utiliser un tunnel SSH pour n8n.

Références fournisseur :

- Hostinger, connexion SSH VPS : https://support.hostinger.com/en/articles/1583780-how-to-connect-to-your-vps-using-ssh
- Hostinger, tutoriel de mise en route VPS : https://www.hostinger.com/tutorials/how-to-set-up-vps

## Parcours France : OVHcloud

OVHcloud est très présent en France et donne une bonne exposition aux notions d'infrastructure : VPS simple, Public Cloud, clés SSH, pare-feu réseau, snapshots.

À regarder pendant la création :

- Pour débuter, un VPS Ubuntu est plus simple que Public Cloud.
- Importer une clé SSH dans le Manager si possible.
- Noter l'utilisateur initial indiqué par OVHcloud selon l'image.
- Garder l'accès public limité à SSH au départ.
- Prendre un snapshot avant les manipulations avancées.

Références fournisseur :

- OVHcloud, premiers pas avec un VPS : https://help.ovhcloud.com/csm/en-gb-vps-getting-started?id=kb_article_view&sysparm_article=KB0047701
- OVHcloud, se connecter en SSH à une instance Public Cloud : https://help.ovhcloud.com/csm/en-gb-public-cloud-compute-connect-instance-ssh?id=kb_article_view&sysparm_article=KB0043284

## Décision rapide

Choisissez un VPS si vous voulez une machine simple à joindre en SSH depuis l'extérieur. Choisissez un serveur maison si vous voulez apprendre en profondeur le réseau local et l'hébergement personnel.
