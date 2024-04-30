## Présentation générale

Mardi et jeudi après-midi : réunions courtes avec le client
Préparer les réunions

2 Mini-challenges : notifications sur le calendrier
Individuel, petit lot à gagner

Jeudi soir : pizza
Nocturne (optionnelle)

Conférences techniques : pour les trois spécialités

Feuilles d'appel : 9h45 - 10h pour le matin
Après-midi : 17h (2 feuilles)

1 marketing / 1 designer / 2 ou 3 développeurs à peu près

Note de groupe sur le suivi (environ 20%)

Rien n'empêche de s'entraider sur les diverse compétences / disciplines

30 marketers 30 designers 90 développeurs
soit 150 étudiants

Lien direct de la vidéo
Rentre dans la note de CC
Jusqu'à 13h00
Pas de brief et pas d'IA
Face cam ou pas

## WorkAdventure

Hybridité / univers du travail
Idée vient du confinement
The Coding Machine
WorkAdventure est née d'un hackathon
Habbo / Zelda 3 / Pokémon :')

Cas d'utilisation
- Bureaux virtuels
- Evénementiel (conférences, speaker...)

Recréer du lien en étant tous à distance

Mais également
- Onboarding
- Escape game
=> Partie "scriptable" de WorkAdventure

Plateforme ouverte, extensible

Problématique : trouver des cas d'utilisation qui n'étaient pas prévus au départ

Idées suggérées :
- GPS = ça bouge son avatar dans le jeu
- Rencontres

Licence AGPL + Commons Clause

WorkAdventure est une plateforme distribuée
Design des cartes à travers un outil appelé Tiled

2D car plus facile, tourne dans un navigateur et consomme moins à longueur de journée
Moteur 2D simplifié dans ce sens
-1% du CPU, pas d'impact sur la batterie des PC portables

Modèle économique : SaaS (vente d'aventures WorkAdventure)

URL : play.staging/workadventu.re/{url}
Les cartes de WorkAdventure sont des fichiers JSON avec des images importées (les tiles)

Point de départ du projet : créer une carte et l'héberger sur un serveur web (GitHub Pages)

Pour aller plus loin :
Servir des cartes dynamiques / générées (par exemple en PHP)

Projet d'exemple
https://github.com/workadventure/map-starter-kit

Personnages / bonhommes  = "Woka"

Dans l'URL, anchor #down-the-stairs => le personnage apparaît directement à la layer (Entrée)

WorkAdventure est vu comme un navigateur de cartes, comme une plateforme et pas seulement comme un outil

WorkAdventure charge le fichier au démarrage uniquement, il n'est pas actualisé dynamiquement

### Scripting API

Client-side
JavaScript / TypeScript

Injection de code sur WorkAdventure donc faille XSS ?
Problématique : Isoler les contextes => le code des créateurs de cartes doit être isolé de WorkAdventure
Solution : iframe qui communique avec WorkAdventure à travers la postMessage API
https://developer.mozilla.org/en-US/docs/Web/API/Window/postMessage

```html
<iframe sandbox="allow-scripts">
```

Possibilités : 
- Suivre le trajet du joueur
- Modifier la carte
- Jouer des sons
- Intégrer des sites web dans le jeu
		Soit qui s'ouvrent à côté du jeu sur la même fenêtre
		Soit qui s'ouvrent au milieu du jeu lui-même
- Afficher des boîtes de dialogue
- Ajouter des éléments dans le menu
- Gérer des portes et des sonnettes
- ...

La Scripting API ne fonctionne qu'en local
Pour partager des informations aux autres joueurs, au niveau du serveur, il faut passer par des "variables" serveur
On a aussi les player variables (par exemple pour conserver un inventaire ou le nombre de points remportés à un jeu)

Communication en bulle = 4 personnes max. parce que WebRTC = peer-to-peer

Brainstorming projet
Mardi midi ordre de passage pour présenter ses réflexions au client

======

- Garry's Mod : reprise du mode Murder (1 murder et les autres innocents)
- Traduction dynamique (texte/voix)
- Cache-cache à l'école : se cacher, les profs peuvent nous tirer dessus, salles blanches/rouges
- Contenu exclusif
- Pixel War à la Reddit
- Univers doom-like (maps regénérées avec du sang partout) pour zigouiller ses collègues
- Overcooked (produits défectueux => les amener au bon endroit et les réparer)
- Casino (Robin)
- Shopify (boutique avec une carte de produits, API Shopify)
- Gestion d'inventaire, drop des items par événements et échanges
- Lethal Company : jeu d'horreur, énigme à plusieurs, fuir un monstre
- Salles de karaoke
- Flop Story (comme Love Story) téléréalité
- Speed dating : une queue en attente pour rentrer dans une pièce
- Visionnage de vidéos en partage
- Vente aux enchères
- Immobilier : hub de départ avec un agent immobilier et plusieurs offres de biens avec des images puis visiter la carte du bien immobilier
- Regarder les jeux olympiques
- Espaces de collaboration pour les médecins
- Prop Hunt
- Radio Map : plusieurs salons pour chaque chaîne de radio
- Grand espace avec plusieurs personnes de différents domaines dans la santé
- Relier WorkAdventure à Discord ou à Twitch
- WorkAdventure pour les développeurs : visualiser nos repositories GitHub, code reviews, peer programming
- Battle de résolution de tickets Jira, résoudre le plus de tickets le plus rapidement