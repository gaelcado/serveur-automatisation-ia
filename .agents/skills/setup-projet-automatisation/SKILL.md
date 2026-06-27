---
name: setup-projet-automatisation
description: Initialiser et piloter le setup agent-driven de ce dépôt public d'automatisation IA. Utiliser quand l'utilisateur ouvre le dépôt pour la première fois, veut configurer son contexte local USER.md, choisir entre local/VPS/serveur maison/serveur existant, préparer Codex ou Claude à guider l'installation, vérifier les symlinks AGENTS/CLAUDE/skills, lancer la checklist de setup, ou nettoyer et condenser le contexte en fin de setup sans secrets.
---

# Setup projet automatisation

Skill d'entrée du dépôt. Guider l'utilisateur et son agent depuis "j'ouvre le repo" jusqu'à un état clair : chemin choisi, contexte local créé, prochain checkpoint connu, et ancien contexte nettoyé.

## Workflow

1. Lire `README.md`, puis `USER.md` s'il existe.
2. Si `USER.md` manque, lire `USER.example.md` et proposer de le créer.
3. Lancer le diagnostic non-mutant :

   ```bash
   .agents/skills/setup-projet-automatisation/scripts/setup_contexte_projet.sh --plan
   ```

4. Identifier les faits déjà connus et leurs preuves : prompt utilisateur, fichier existant, commande de diagnostic, ou réponse explicite.
   Si l'utilisateur apporte une fiche cas d'usage, l'utiliser comme source de faits pour le mini brief, pas comme une recette complète.
5. Demander les informations manquantes avant toute personnalisation de `USER.md` :
   - objectif concret ;
   - niveau d'explication souhaité ;
   - point de départ : local seulement, VPS, serveur maison, serveur existant, ou "je ne sais pas".
6. Identifier le chemin : local seulement, VPS, serveur maison, serveur existant, ou à confirmer.
7. Charger seulement la doc utile :
   - `docs/06-chemin-local.md` pour local seulement.
   - `docs/00-checklist-setup-agentique.md` pour chemin serveur.
   - `docs/01-choisir-son-serveur.md` si le choix local/VPS/maison/existant est flou.
   - `docs/07-cycle-de-vie-du-contexte.md` pour mise à jour, changement de chemin ou cleanup.
8. Après accord utilisateur, créer ou réparer le contexte local :

   ```bash
   .agents/skills/setup-projet-automatisation/scripts/setup_contexte_projet.sh --apply
   ```

9. Mettre à jour `USER.md` uniquement avec l'état durable confirmé, sans secret.
10. Si une machine Linux doit être installée, passer à `$installer-serveur-automatisation`.
11. En fin de setup, lancer le cleanup de contrôle :

   ```bash
   .agents/skills/setup-projet-automatisation/scripts/setup_contexte_projet.sh --cleanup
   ```

12. Résumer : état, preuve, prochain pas, contexte supprimé ou à oublier.

## Politique anti-invention

- Ne pas deviner le niveau, l'objectif, le chemin, le fournisseur, l'OS, l'agent utilisé ou les préférences.
- Ne pas écrire une option du modèle comme si elle était choisie.
- Si l'information vient de l'environnement local, la formuler comme observation, pas comme préférence utilisateur.
- Si l'information manque, écrire `à confirmer` ou demander une réponse courte.
- Avant d'écrire une valeur personnalisée dans `USER.md`, pouvoir citer la source : utilisateur, fichier existant, commande, ou diagnostic.

## Règles UX

- Dire explicitement où lancer chaque commande : dépôt local, serveur, ou interface web.
- Ne jamais demander de secret dans le chat.
- Ne pas charger toutes les docs d'un coup.
- Commencer par 2 ou 3 questions maximum quand le point de départ est inconnu.
- Pour débutant : une décision à la fois, vocabulaire court, lien vers `docs/glossaire.md`.
- Pour curieux technique : expliquer le modèle mental.
- Pour dev : donner préconditions, commandes et vérifications.

## Fin de setup

Le setup est terminé seulement quand :

- `USER.md` existe localement ou l'utilisateur a choisi de ne pas le créer ;
- le chemin actuel est noté : local, VPS, serveur maison ou serveur existant ;
- le prochain checkpoint est explicite ;
- les automatisations actives ont un mode test/mock, des validations humaines, des cas limites et des actions interdites explicites quand ces informations sont connues ;
- les pistes abandonnées sont supprimées, condensées ou listées dans `Contexte à oublier ou archiver` ;
- `git status --short` ne montre pas de contexte personnel suivi par git ;
- les symlinks `CLAUDE.md` et `.claude/skills` sont présents ou le choix de ne pas les réparer est noté.

Si l'utilisateur veut repartir de zéro ou revenir à l'état upstream, utiliser `$reset-projet-automatisation`.
