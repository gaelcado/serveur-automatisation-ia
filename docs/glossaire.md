# Glossaire serveur, automatisation et agents IA

Ce glossaire donne des définitions courtes. L'agent doit y renvoyer quand un mot technique ralentit l'utilisateur.

## Machines et réseau

**Machine locale** : l'ordinateur devant vous. Votre navigateur, Codex App ou Claude App tournent souvent ici.

**Machine distante** : une autre machine accessible par réseau. Elle peut être un VPS, un serveur maison ou un serveur de développement.

**Serveur** : machine qui reste disponible pour exécuter des services, scripts et automatisations.

**VPS** : serveur virtuel loué chez un hébergeur. Il a souvent une IP publique et un accès SSH.

**Serveur maison** : machine chez vous. Elle est souvent derrière une box Internet et une IP locale.

**IP** : adresse réseau d'une machine. Exemple local : `192.168.1.42`. Exemple public : adresse fournie par un hébergeur.

**DNS** : système qui relie un nom de domaine à une adresse IP.

**NAT** : mécanisme de votre box qui permet à plusieurs appareils locaux de partager une connexion Internet.

**CGNAT** : NAT géré par l'opérateur. Il peut empêcher d'exposer facilement un serveur maison sur Internet.

**Port** : porte logique d'un service. SSH utilise souvent `22`, n8n utilise souvent `5678`.

**localhost** : "cette machine-ci". Dans votre navigateur local, `localhost` est votre ordinateur. Dans une session SSH, `localhost` est le serveur.

**Tunnel SSH** : pont sécurisé qui rend un service distant accessible sur votre machine locale.

**Bridge** : pont de travail entre votre agent local et le serveur. Il peut être SSH, Codex App SSH, Claude Remote Control, ou un tunnel.

## Linux serveur

**Shell** : interface texte où l'on lance des commandes.

**Terminal** : fenêtre ou panneau qui affiche un shell.

**Commande** : instruction lancée dans le shell.

**sudo** : permet d'exécuter une commande avec des droits administrateur.

**Utilisateur non-root** : compte normal avec droits limités. Recommandé pour travailler.

**root** : administrateur complet du système. Puissant, donc risqué.

**PATH** : liste des dossiers où le shell cherche les commandes.

**Variable d'environnement** : valeur disponible pour un programme, souvent utilisée pour config ou secrets.

**systemd** : gestionnaire de services Linux. Il démarre, arrête et surveille des programmes.

**Service** : programme lancé et surveillé en arrière-plan, par exemple n8n.

**Timer systemd** : déclencheur planifié pour lancer une tâche à intervalles réguliers.

**Logs** : traces d'exécution utiles pour comprendre ce qui s'est passé.

**nvm** : outil pour installer et choisir une version de Node.js par utilisateur.

**Node.js** : environnement JavaScript côté serveur. n8n et plusieurs CLIs l'utilisent.

## Sécurité et authentification

**Clé SSH** : paire de fichiers utilisée pour se connecter sans mot de passe.

**Clé publique** : partie partageable d'une clé SSH. Elle finit souvent par `.pub`.

**Clé privée** : partie secrète d'une clé SSH. Ne jamais la coller dans un chat.

**Token** : jeton secret qui donne accès à un service ou une API.

**Clé API** : secret utilisé par un programme pour appeler une API.

**OAuth** : méthode d'autorisation où un service donne accès sans révéler votre mot de passe.

**Device-code** : flux d'authentification où un CLI affiche un code public à saisir dans un navigateur.

**Secret** : toute information qui donne un accès privé : token, mot de passe, clé API, secret OAuth, clé privée.

**.env** : fichier local de variables d'environnement. Il ne doit pas être commité.

**Credentials n8n** : secrets stockés dans n8n pour connecter des services.

**Pare-feu** : outil qui contrôle quels ports sont accessibles.

**HTTPS** : HTTP sécurisé. Nécessaire pour exposer proprement un service public.

**Reverse proxy** : service qui reçoit le trafic web public et le transmet à une application interne.

## Automatisation

**n8n** : outil visuel pour orchestrer des workflows et connecter des services.

**Workflow** : suite d'étapes automatisées.

**Node n8n** : bloc dans un workflow n8n.

**Webhook** : URL qui déclenche une automatisation quand elle reçoit une requête.

**Cron** : système de planification historique sur Unix/Linux.

**Worker** : programme qui traite des tâches en arrière-plan.

**Retry** : nouvelle tentative automatique après un échec.

**Idempotence** : propriété d'une action qui peut être relancée sans créer de dégâts ou doublons.

**Mock** : fausse donnée ou faux service utilisé pour tester sans compte réel.

**Validation humaine** : étape où une personne confirme avant une action sensible.

**Journalisation** : écriture de logs ou traces pour audit et dépannage.

## IA et agents

**Agent IA** : système capable d'utiliser des outils, lire un contexte, proposer ou effectuer des actions.

**Codex** : agent OpenAI orienté code, terminal, fichiers, app, CLI et automatisations.

**Claude Code** : agent Anthropic orienté code, terminal, IDE, Remote Control et automatisations.

**CLI** : interface en ligne de commande.

**App** : interface graphique locale ou web.

**Remote Control** : surface permettant de piloter ou suivre une session distante depuis web/mobile, selon l'outil.

**Codex App SSH** : connexion de Codex App à un hôte SSH pour travailler dans un dossier distant.

**codex exec** : mode non interactif de Codex pour scripts et jobs.

**Codex app-server** : interface avancée pour piloter Codex depuis un client. À garder local-only et protégé.

**MCP** : Model Context Protocol, standard pour connecter des outils et données à un agent.

**Skill** : dossier d'instructions, scripts et références qui enseigne à l'agent une capacité précise.

**Skill de setup** : skill qui initialise le contexte local, choisit le chemin utilisateur et nettoie la fin de phase. Ici : `$setup-projet-automatisation`.

**Skill de reset** : skill qui encadre une remise à zéro du dépôt avec garde-fous. Ici : `$reset-projet-automatisation`.

**Context repo** : dépôt qui contient les règles, docs et scripts dont l'agent a besoin pour agir correctement.

**AGENTS.md** : fichier d'instructions durable injecté par Codex et d'autres harnesses compatibles pour comprendre les règles du projet.

**CLAUDE.md** : fichier de contexte utilisé par Claude Code. Ici, c'est un lien vers `AGENTS.md` pour éviter deux versions divergentes.

**USER.example.md** : modèle versionné du carnet de bord utilisateur. Il sert à créer un `USER.md` local sans partir d'une page vide.

**USER.md** : carnet de bord local du projet, créé depuis `USER.example.md` et ignoré par git. Il décrit le niveau, les machines, les services, les automatisations et les règles personnelles, sans secret.

**Cycle de vie du contexte** : règle de maintenance qui dit quand enrichir, condenser, archiver ou supprimer du contexte pour éviter les contradictions.

**.agents/skills** : emplacement principal des skills maintenues dans ce dépôt.

**.claude/skills** : emplacement projet lu par Claude Code pour les skills. Ici, c'est un lien vers `.agents/skills`.
