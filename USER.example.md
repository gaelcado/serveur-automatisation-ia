# USER - contexte vivant local

Ce fichier est un modèle. Copiez-le en `USER.md` ou demandez à votre agent de le faire.

`USER.md` est ignoré par git : il sert de carnet de bord local et personnel. Il aide l'agent à personnaliser l'accompagnement sans redemander les mêmes informations.

Gardez-le factuel, court et utile. Ne mettez jamais de secret dedans.

## État courant

Cette section doit rester courte. Elle remplace les anciens états quand le projet avance.

```text
Dernière mise à jour:
Phase actuelle:
Prochain checkpoint:
Blocage principal:
```

## Profil

- Niveau actuel : inconnu
- Style d'explication préféré : inconnu
- Système local : inconnu
- Agent utilisé : Codex / Claude / autre / inconnu

## Objectif principal

```text
À compléter : quel résultat concret voulez-vous obtenir ?
```

## Chemin choisi

- Chemin : local seulement / VPS / serveur maison / serveur existant / inconnu
- Fournisseur ou machine : inconnu
- OS serveur : inconnu
- Accès SSH validé : non
- Alias SSH : aucun

## Décisions actives

Ne garder ici que les décisions encore vraies.

```text
Décision:
Raison:
Preuve:
Date:
```

## Services et outils

```text
GitHub CLI:
Node/nvm:
n8n:
Codex CLI:
Claude Code:
systemd utilisateur:
tunnel SSH:
```

## Authentifications

Noter uniquement les statuts, jamais les secrets.

```text
GitHub:
Codex/OpenAI:
Claude:
n8n owner:
Google/Microsoft/Airtable/Twilio/autre:
```

## Automatisations

Pour chaque automatisation, garder une fiche courte.

```text
Nom:
Objectif:
Entrée:
Rôle script:
Rôle IA:
Sortie:
Validation humaine:
Fréquence:
Secrets nécessaires:
Statut:
```

## Contexte à oublier ou archiver

Utilisez cette section quand une ancienne piste est abandonnée. L'agent doit ensuite enlever ou condenser ce contexte dans les sections actives.

```text
Élément obsolète:
Pourquoi:
Action: supprimer / condenser / garder en archive locale
```

## Règles personnelles

```text
Actions interdites:
Comptes à ne pas connecter:
Données sensibles:
Niveau d'autonomie autorisé à l'agent:
```

## Journal de décisions

Ce journal doit rester condensé. Quand il devient long, demander à l'agent de le résumer en décisions actives et d'archiver le détail dans un fichier local ignoré.

```text
AAAA-MM-JJ - Décision - Preuve ou raison
```
