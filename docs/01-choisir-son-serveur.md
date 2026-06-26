# 01 - Choisir son serveur

Vous avez besoin d'une machine qui reste disponible pendant vos automatisations seulement si elles doivent tourner sans vous, recevoir des webhooks ou rester accessibles à distance.

Si vous n'avez encore rien, ne commencez pas par installer n8n. Commencez par choisir le type de chemin. Le reste dépend de cette décision.

## Choix rapide avec l'agent

Demandez à votre agent :

```text
Aide-moi à choisir entre local seulement, VPS, serveur maison ou serveur déjà existant. Pose-moi seulement les questions nécessaires : budget, matériel disponible, besoin d'accès depuis l'extérieur, besoin d'automatisation continue, niveau réseau, et objectif d'automatisation.
```

Repère par niveau :

- **Débutant** : local seulement pour apprendre, puis VPS Ubuntu LTS si une machine continue devient utile.
- **Curieux technique** : serveur maison ou VPS conviennent ; choisissez selon ce que vous voulez apprendre.
- **Dev** : choisissez selon les contraintes réseau, sécurité, coût et disponibilité.

## Chemin 0 : local seulement

Le chemin local est le plus simple si vous voulez apprendre, manipuler des fichiers, tester un prompt, ou lancer une automatisation à la main.

Choisissez local seulement si :

- vous n'avez pas besoin de webhook public ;
- votre ordinateur peut rester ouvert pendant l'action ;
- vous acceptez de lancer les workflows manuellement ;
- vous voulez éviter SSH, firewall, DNS, NAT et services systemd au départ.

Lire : `docs/06-chemin-local.md`.

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

## Chemin C : serveur déjà existant

Si vous avez déjà une machine Linux :

- Vérifiez que vous pouvez vous connecter en SSH.
- Vérifiez que vous avez un utilisateur avec `sudo`.
- Vérifiez l'OS avec `cat /etc/os-release`.
- Ne réinstallez rien avant d'avoir lancé le diagnostic du dépôt.

Checkpoint :

```text
Serveur existant: oui/non
SSH fonctionnel: oui/non
Utilisateur sudo: oui/non
OS: ...
```

## Chemin France : Hostinger

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

## Chemin France : OVHcloud

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

Choisissez local seulement si vous voulez apprendre ou prototyper sans infrastructure. Choisissez un VPS si vous voulez une machine simple à joindre en SSH depuis l'extérieur. Choisissez un serveur maison si vous voulez apprendre en profondeur le réseau local et l'hébergement personnel.

Quand la décision est prise, revenez à `docs/00-checklist-setup-agentique.md`. Pour le local seulement, suivez plutôt `docs/06-chemin-local.md`.

Demandez aussi à l'agent de noter la décision dans `USER.md` : chemin choisi, raison principale, prochain checkpoint, et pistes abandonnées à supprimer ou archiver.
