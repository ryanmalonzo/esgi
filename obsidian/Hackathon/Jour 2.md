## Conférence dev

### Architecture

Client : Phaser

Rôle du serveur (architecture initiale) :
- partager la position des joueurs
- faire le *signaling WebRTC*
	- aider les machines à se trouver pour s'envoyer des données
- Besoin de temps réel : Websockets

WebRTC = peer-to-peer

Soucis de performance :
- Sur une carte à 100 utilisateurs, la position d'un joueur doit être partagée à 99 autres, toutes les 0.2 secondes, soit environ 500 messages par seconde
- Node.js est lent car single-threaded

Pistes d'amélioration :
- JSON => Protobuf (compression binaire)
- Envoi partiel : suivi du viewport (= la zone de la carte que le joueur voit) côté serveur et donc envoi des coordonnées des joueurs qui sont dans cette viewport

### WebRTC

- Etablir des connexions directes entre clients (peer-to-peer)
- Architecture full mesh : chacun est connecté à tous les autres

Limitations : CPU et connexion réseau (ADSL...)

Donc besoin d'introduire quand même un serveur intermédiaire, le Selective Forwarding Unit (SFU) server
Par exemple, lors d'une présentation, ce serveur reçoit le flux du présentateur et le diffuse à tous les autres, sans meshing

API compliquée, qui change beaucoup et qui peut varier de navigateur à navigateur
Utiliser des libs (https://github.com/feross/simple-peer)

iframe WorkAdventure sandboxed : pas de fetch à l'extérieur
Solution : appeler David

### Echange de données

WA.state : variables serveur, associées à la carte
Plutôt utilisées pour stocker un état sur la carte (état de la porte booléen)

Sécurité : n'importe qui peut modifier n'importe quelle variable à l'aide de cette API
Pour ce hackathon, ne pas s'en soucier

Limitation large sur la taille max. des variables aujourd'hui : environ 16 Mo

Player variables (inventaire !!!)
WA.**player**.state
Privées ou publiques, persistent à travers un refresh ou pas

Autre manière de partager de l'information : envoyer des événements
WA.event + un listener de l'autre côté (on sait qui a envoyé l'événement, la donnée qu'elle contient)
Lorsque l'événement est envoyé, il est perdu : on n'en garde pas la trace

**\[!] Les player variables sont aussi restreintes par le viewport**
Tandis que les événements sont dispatchés à toute la map

### Démo

Tiled : appuyer sur H pour highlight le layer courant
Floor layer : layer sur lequel se trouve le Woka

Variables sont stockées en RAM dans le serveur back
La donnée existe en RAM tant qu'il y a un utilisateur connecté dans la room
Pour persister la donnée sur la BDD de WorkAdventure, ajouter une propriété persist à true dans Tiled mais seulement en prod, pas en localhost