# Dépannage

## Quel localhost ?

`localhost` signifie "la machine sur laquelle la commande tourne".

- Dans le navigateur local : votre ordinateur.
- Dans une session SSH : le serveur.
- Dans n8n sur le serveur : le serveur.

Un tunnel relie les deux :

```bash
ssh -N -L 5678:127.0.0.1:5678 utilisateur@adresse-du-serveur
```

## Port occupé

```bash
ss -ltnp | grep ':5678'
```

Changer le port local si besoin :

```bash
ssh -N -L 15678:127.0.0.1:5678 utilisateur@adresse-du-serveur
```

## Logs systemd utilisateur

```bash
systemctl --user status n8n.service
journalctl --user -u n8n.service -n 80 --no-pager
```

## GitHub CLI pas connecté

```bash
gh auth status
gh auth login
```

## OAuth n8n échoue

Causes fréquentes :

- Callback configuré sur le mauvais `localhost`.
- n8n non public alors que le fournisseur exige une URL publique.
- URL HTTPS manquante.
- Mauvais client ID ou mauvais projet fournisseur.

Pour l'atelier, revenir en mock ou API-token tant que le callback public n'est pas le sujet.
