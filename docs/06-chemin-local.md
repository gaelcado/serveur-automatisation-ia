# 06 - Chemin local sans serveur

Ce chemin est utile si vous voulez apprendre, prototyper ou automatiser ponctuellement sans louer de VPS ni configurer un serveur maison.

Il convient bien quand :

- l'automatisation se lance à la main ;
- les fichiers restent sur votre ordinateur ;
- vous n'avez pas besoin d'un webhook public ;
- vous ne voulez pas maintenir un service allumé en continu ;
- vous voulez comprendre avant d'installer plus loin.

## Ce qui change par rapport au serveur

En local, votre ordinateur joue tous les rôles :

```text
ordinateur local -> fichiers -> scripts -> agent IA -> validation humaine
```

Il n'y a pas de tunnel SSH, pas de service distant, pas d'ouverture réseau à gérer. En revanche, l'automatisation ne tourne pas si votre ordinateur est éteint ou si l'agent n'est pas lancé.

## Setup minimal

Demandez à l'agent :

```text
Je veux rester en local pour l'instant.

Aide-moi à vérifier Git, Node ou Python selon le besoin, puis construis une première automatisation avec données locales ou fictives. Pas de serveur, pas de service public, pas de secret dans le chat.
```

Selon le projet, l'agent peut vérifier :

```bash
git --version
python3 --version
node --version
npm --version
```

N'installez que ce qui est nécessaire à votre première automatisation.

## Quand utiliser n8n local

n8n peut aussi tourner sur votre ordinateur pour apprendre l'interface et construire des workflows simples.

À garder en tête :

- `http://localhost:5678` désigne votre ordinateur local ;
- les fichiers lus par n8n sont ceux accessibles depuis votre machine ;
- les workflows ne tournent pas si n8n est fermé ;
- les connecteurs OAuth peuvent demander une configuration plus avancée.

Pour une découverte rapide, préférez données fictives, fichiers CSV, webhook local testé manuellement, ou appels API avec comptes de test.

## Quand rester en scripts

Un script local est souvent meilleur qu'un workflow n8n si vous voulez :

- renommer, nettoyer ou classer des fichiers ;
- lire un CSV ou un dossier ;
- produire un rapport ;
- tester un prompt IA sur quelques exemples ;
- comprendre la logique avant l'orchestration.

Pattern recommandé :

```text
fichiers locaux -> script Python/JS -> sortie vérifiable -> brouillon IA si utile -> validation humaine
```

## Passer au serveur plus tard

Passez au chemin serveur quand vous avez besoin de :

- déclenchements programmés quand votre ordinateur est éteint ;
- webhooks joignables depuis l'extérieur ;
- workflows n8n persistants ;
- logs serveur ;
- accès distant depuis Codex ou Claude ;
- intégrations longues ou partagées.

Quand ce moment arrive, revenez à [00-checklist-setup-agentique.md](00-checklist-setup-agentique.md), phase 1.

## Checkpoint local

```text
Chemin local choisi: oui/non
Outils nécessaires:
Données de test:
Première action utile:
Risque secret:
Critère de réussite:
Moment prévu pour passer au serveur:
```
