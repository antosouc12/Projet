# Projet de 3ème année : Création d'un système ambisonique du second ordre

## Sommaire 

-Remerciements

-Présentation du projet 

-Etat de l'art 

-Création des câbles et enceintes / Carte son

-Câblage virtuel

-Ecriture du Code Matlab 

-Tests 

-Pour aller plus loin: premier jet code CUDA et portaudio

-Conclusion 

## Remerciements 

Avant d’ouvrir ce rapport, nous souhaitons remercier notre professeur encadrant M. Nicolas Papazoglou qui nous a soutenus et guidés tout au long de ce projet. 

Nous tenons particulièrement à remercier les techniciens Mme. Patricia Kittel et Mr. Eric de nous avoir aidé, que ce soit pour la soudure, pour identifier les problèmes de court-circuit, pour le prêt de matériel et pour l’impression 3D de nos enceintes.

Nous aimerions aussi remercier les autres professeurs qui nous ont apporté leur aide: M.Barès, M.Reynal et M. Duprey.

Sans l’aide de ces personnes nous n’aurions pas été capable d'aller aussi loin dans nos objectifs et nous sommes heureux d’avoir pu travailler avec ce groupe de personnes durant de ces 4 mois de projet. 

## Présentation du projet 

![image](https://user-images.githubusercontent.com/56081832/149917688-af110af7-f690-4f0b-a3a8-6f2bafbe6644.png)


Le but de notre projet est de mettre en place un système ambisonique du second ordre. 

Un système ambisonique est un système de reproduction d'environnment sonore qui nécessite l'utilisation de plusieurs enceintes. Le but d'un système ambisonique de reproduction est de spatialiser le son de la façon la plus réaliste possible.

Une spécificité de ce projet est de vouloir implémenter ce système en temps réel. Pour cela, nous allons devoir coder sur CUDA, un language similaire au C mais qui utilise des librairies permettant d'utiliser la carte graphique de l'ordinateur. Cela nous permetterais de pourvoir placer la source sonore ou l'on veut en temps réel sans pré-traitement.

Pour ce projet, nous devions donc réaliser un état de l'art de l'ambisonique, mettre en place le matériel pour créer un système ambisonique d'ordre 2, coder les algorithmes nécessaires et gérer les connectiques ordinateur/enceintes.

## Etat de l'art

Pour cette partie, Mr.Papazoglou nous a fourni 7 documents PDF qui présentaient les différentes technologies pour la spatialisation du son. Pour nos travaux, nous nous sommes principalement inspirés des travaux de Stéphanie Salaün sur les systèmes ambisoniques. 

## Création des câbles et enceintes / Carte son 

Pour notre projet, nous avions besoin d'au minimum 8 enceintes. Pour cela, nous avons commandé des haut-parleurs 8 ohm avec des pré-ampli PAMP. En ce qui concerne le boitier, nous avons fait appel au technicien mécanique de l'ENSEA, M. Eric pour nous imprimer 8 boitiers qui pourraient contenir nos haut-parleurs avec l'amplificateur et la connectique nécessaire. En terme de connectiques, nous avons utilisé des cables XLRs et des cables d'alimentation normaux. Pour envoyer le son depuis l'ordinateur vers les enceintes, nous avons utilisé une carte son Scarlett 18i20 de Focusrite. Cette carte son, qui nous a été recommandée par M. Papazoglou, nous convenait car ce qui nous avions besoin des 8 sorties Jack de la carte son. 

![image](https://user-images.githubusercontent.com/56081832/149923633-b2e2b30a-b908-4420-b0a8-16d17b72ff28.png)


Ayant besoin de cables sur-mesure, nous avons dû réaliser toutes les connectiques à la main:

![image](https://user-images.githubusercontent.com/56081832/149944355-f1f0782b-13f1-41c8-a606-60a15d286645.png)

![image](https://user-images.githubusercontent.com/56081832/149944485-a2fa1285-3ed8-4348-8277-ef2372acb646.png)

![image](https://user-images.githubusercontent.com/56081832/149945122-f695db07-7f23-4b6c-b13c-b12022d5cc85.png)

![image](https://user-images.githubusercontent.com/56081832/149944765-98a52a60-3671-496c-9b48-2e114023d9b4.png)

![image](https://user-images.githubusercontent.com/56081832/149945434-688d52cf-8c1e-46db-b2c8-01ccef7bd5a5.png)

Une fois le montage fait et alimenté, on peut entendre un bruit rose provenant des enceintes. Nous avons plusieurs théories permettant d'expliquer ce phénomen: 

Le PAM8610 n'accepte que des entrées audios asymétriques, ce qui signifie que nous n'utilisions pas la capacité symétrique de l'XLR. De cela, nous n'avons pas cette réduction de bruit supplémentaire.
Une connexion symétrique est une connexion qui nécessite 3 fiches. Sur l'une des fiches se trouve la masse et sur les deux autres se trouve le signal mais qui sont en oppsosition de phase. L'idée derrière cela est qu'à la réception du signal, on retourne l'un des signaux et on les ajoute. Ceci compensent le bruit que l'on a potentiellement récuperer le long du câble et cela augmente l'amplitude du signal final. Une connexion asymétrique est une connexion où l'on a seulement la masse et le signal. Il n'y a donc pas de compensation de bruit avec cette connexion

Une autre source potentiel de ce bruit serait l'amplificateur lui-même.

Le PAM8610 peut délivrer jusqu'à 10 W et est alimenté à 12V.



## Cablage Virtuel

Une fois la salle mise en place, nous devions raccorder les sorties réelles de la carte son aux sorties virtuelles de l'ordinateur. Pour cela, nous avons utilisé le logiciel fourni par Focusrite, Focusrite Control 

![image](https://user-images.githubusercontent.com/56081832/149952667-b9a619b0-5740-4ff3-b24a-8cf247c678c3.png)

Ce logiciel nous permet de réaliser les câblages dans la carte son.

![image](https://user-images.githubusercontent.com/56081832/149952923-3bf578c6-10d1-45f0-b6fd-a7367962b7fa.png)

Vu que nous voulions commander chaque haut-parleurs comme une source mono, nous devions en premier lieu rendre chaque sortie indépendante les unes des autres.

![image](https://user-images.githubusercontent.com/56081832/149953096-aca510ac-cf14-48ff-8abb-8e44e5873ad4.png)

Ensuite, nous devions connecter la sortie virtuelle numéro i à la sortie réelle numéro i. 

Après avoir paramétré l'interface de la carte son, nous avons paramétré les connexions internes a l'ordinateur. Pour cela, nous avons pensé à utiliser QJack. Ce logiciel permet de gérer les connexions internes de l'ordinateur. Il agit en tant qu'interface entre ALSA et les clients/logiciels qui veulent jouer de l'audio:

![image](https://user-images.githubusercontent.com/56081832/149956091-cf1a397e-f1b5-4aa9-a6f3-9a87504d587d.png)

![image](https://user-images.githubusercontent.com/56081832/149954973-824127b2-bf11-4dba-b94e-39ea4fc42a8a.png)

![image](https://user-images.githubusercontent.com/56081832/149955153-3c9654d5-1a9a-4355-b926-a7b1128e73d7.png)

QJack nous permet aussi de régler la fréquence d'échantillonnage des extraits ou de changer la taille des buffers utilisés, même si nous n'avons finalement pas utilisé
cette fonctionnalité.

Pour obtenir les Outputs Port "PulseAudio Jack Sink", il fallait attention de bien installer le module Jack pour PulseAudio. Ces output ports sont les sorties virtuelles de l'ordinateur que l'on connecte aux entrées virtuelles de la carte son.

Nous avons aussi installé d'autre logiciels qui facilite l'utilisation de QJack tels que Patchage et Calf Plugin:

Patchage:
![image](https://user-images.githubusercontent.com/56081832/149957788-2092dd18-cfe0-434c-9fa5-18bd43512745.png)

Calf Plugin:
![image](https://user-images.githubusercontent.com/56081832/149957865-7e74bca7-5f33-410e-847d-2ba2b5fa3500.png)


Après la première mise en place, nous arrivions a connecter notre téléphone via une entrée Jack de la carte son vers les enceintes que l'on choisissait au préablable. Nous n'arrivions cependant pas a émettre du son depuis l'ordinateurs directement. QJack ne nous proposait pas de sorties virtuelles. Nous n'avions pas encore accèss aux PulseAudio Jack Sink. 

![image](https://user-images.githubusercontent.com/56081832/151679332-384418c3-6dc2-4e24-bd74-5ca54d9ef3f9.png)

Pour remédier à cela, nous avons téléchargé et installé le package "Pulse-audio-module-jack". Une fois le module installé, nous avons pu emettre de l'audio provenant de l'ordinateur, par exemple, depuis Youtube.

Cependant, nous n'avions que 2 sorties virtuelles, "front-left" et "front-right". Pour notre projet, nous avions besoin de 8 sorties virtuelles. Nous pensions que nous pouvions changer le fichier de configuration de PulseAudio et/ou de Qjack pour obtenir 8 sorties virtuelles mais nous avons finalement decidé de proceder différemment.

Pour commander indépendamment chaque enceinte, nous avons utilisé le logiciel Ardour.

![image](https://user-images.githubusercontent.com/56081832/151679795-ced3977c-250f-42df-a312-3a254e976ebf.png)

![image](https://user-images.githubusercontent.com/56081832/151679789-f29ea3bc-50fc-4d61-a193-7d63c23e6228.png)

Ardour est une plateforme de travail pour audio qui nous permet d'acceder directement a la carte son. Nous pouvons donc associer une sortie virtuelle par track. Ceci nous permet donc de commander chaque enceinte individuellement.




## Ecriture de code Matlab 

Nous devons maintenant spacialiser notre son. Pour cela, nous avons utilisé les équations presentées par Mme Stephanie Salaun Bertet. 
Pour spacialiser notre son, nous projetons notre source mono sur les harmoniques spheriques. Chaque harmonique represente une direction. Il suffit donc de priviligier une certaine harmonique par rapport a une autre pour spacialiser notre son.

Dans notre cas, nous effectuons une spacialisation en 2D (c'est-à-dire dans le plan), nous allons projetons donc notre source mono en utilisant les harmoniques cylindriques.

Pour faire cela, nous appliquons la formule suivante:

![image](https://user-images.githubusercontent.com/56081832/151680441-bd6fff74-3ac2-482c-a9ee-0870f69bfc8e.png)

avec N le nombre d'enceinte, C la matrice contenant les gains correspondants aux harmoniques cylindriques, Y la matrice contenant les harmoniques cylindriques, S le vecteur contenant les échantillions de la source audio que l'on veut traiter et Sn la matrice contenant les 8 pistes pour chaque enceintes. 


Voici la forme d'Y:
![image](https://user-images.githubusercontent.com/56081832/151681129-e0681e5f-31c1-48ed-b116-b1ee620d43d0.png)
 avec a une constante permettant la conversion degrée/radian.
 
Voici la forme de C:

![image](https://user-images.githubusercontent.com/56081832/151681396-3b056307-bb1e-432e-a20d-4224210b4ed8.png)

On peut généraliser cette formule à l'ordre que l'on veut, dans ce cas-ci, le second ordre. Evidement, plus l'ordre est grand plus la spacialisation est précise, cependant, il faut aussi plus d'enceintes.

Avec ceci nous pouvons écrire un code matlab qui permet de pre-traiter le signal pour le spacialiser.

Nous importons un fichier .wav que nous traitons pour nous sortir 8 fichiers .wav que l'on jouera depuis Ardour.

## Tests 

Comme premier test, nous avons mis en place un systeme HOA d'ordre 1 (dans la matrice Y il n'y a pas les termes en cos(2theta) et sin(2theta)) et il n'y a que 4 enceintes placées a 0, 90, 180 et 270 degrés. 
Lors de ce premier test, nous avons cherché à créer une source virtuelle placée à 30 degrée/11h (0° étant en face de nous). Nous avons demandé à une dizaine de personnes d'essayer de situer la source. La majorité des participants a reussi à placer la source correctement à +/- 10 degrés.

Une fois que nous avions fini la production des 4 dernières enceintes nous avons pu commencer les tests avec 8 enceintes. Nous avons refait le mme test mais en placant la source a 315 degrés cette foi-ci et sans en informer nos 'testeurs'. Les participants sont de nouveau parvenus à placer la source correctement a +/- 3 degrés.

Nous avons de plus modifié le code d'origine dans le but de permettre le mouvement de la source virtuelle autour de l'utilisateur. 

##  Pour aller plus loin: premier jet code CUDA et portaudio

Nous avons donc reussi a mettre en place un syteme ambisonique d'ordre 2 et à placer une source et la faire se deplacer de la manière souhaitée en pre-traitant le signal. Le but originel etant de pouvoir deplacer la source en temps reel en effectuant les calculs dans le GPU avec CUDA.

Nous avons écrit le code CUDA qui permet le traitement du signal pour obtenir les 8 tracks. Pour cela, nous devions écrire une fonction de multiplication de matrice dans le GPU.

La gestion de buffer et l'envoi de ceux-ci sur le codec sont les tâches les plus complexes.
Pour cela, nous pensions utiliser PortAudio.

PortAudio est une librarie open-source qui permet de jouer et d'enregister de l'audio. Cette librarie gère les transfers de buffers vers le codec donc nous pensions pouvoir utiliser celle-ci pour commander nos enceintes via la Scarlett. Il existe déjà des fichers code exemples qui permettent de détecter la carte son et le nombre de sorties disponbiles mais aussi des fichiers code qui permettent d'envoyer les buffers directement au codec

Cependant, il semble que pour installer PortAudio, il faille désintaller PulseAudio. Ne connaissant pas complètement les implications de la désinstallation de PulseAudio et arrivant a la fin de notre projet nous avons décideé de ne pas continuer.

Nous pensions utiliser une time machine pour sauvegarder notre travail jusque là mais nous n'avons pas eu le temps.


## Conclusion 

Pendant ces 4 mois, nous avons reussi a construire un systeme ambisonique du second order et à correctement spatiliser une source mono ainsi qu'à la faire se deplacer dans l'espace. Nous avons été amenés à travailler avec divers encadrants, pour mettre en place le code, travailler sur la théorie ambisonique et imprimer en 3D les boitiers des enceintes. Nous avons réalisé les soudures et les cablages nous même, et nous avons mis en places l'ensemble des enceintes et connectiques dans la salle anéchoïque de l'ENSEA. Nous avons travaillé sous matlab et cuda dans le but de réaliser le traitement du signal et la spacialisatione et nous avons utiliser les logiciels Focusrite et Ardour pour la partie routage des sources. Notre système ambisonique du second ordre est fonctionnel ce qui constituait la majeure partie de nos objectifs initiaux.
