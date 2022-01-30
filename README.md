# Projet de 3ème année : Création d'un système ambisonique d'ordre 2

## Somaire 

-Remerciement 

-Présentation du projet 

-Etat de l'art 

-Création des cables et enceintes / Carte son

-Cablage virtuel

-Ecriture du Code Matlab 

-Tests 

-Pour aller plus loin: premier jet code CUDA et portaudio

-Conclusion 

## Remerciements 

Avant d’ouvrir ce rapport, nous tenons tout d’abord à remercier notre professeur encadrant M. Nicolas Papazoglou qui nous a soutenus et guidés pendant cette période de projet. 

Ensuite, nous tenons particulièrement à remercier les techniciens Mme. Patricia Kittel et Mr. Eric de nous avoir aidé lors du déroulement de ce projet, que ce soit pour la soudure ou pour détecter les problèmes de court-circuit ou le prêt de matériel ou pour l’impression 3D de nos enceintes.

Nous aimerions aussi remercier tous les autres professeurs qui nous ont aidés avec leurs connaissances tels que M.Barès ou M.Reynal.

Sans l’aide de ces personnes nous n’aurions pas réussi autant et nous sommes heureux d’avoir pu travailler avec ce groupe de personnes lors de ces 4 mois de projet. 

## Présentation du projet 

![image](https://user-images.githubusercontent.com/56081832/149917688-af110af7-f690-4f0b-a3a8-6f2bafbe6644.png)


Le but de ce projet est de mettre en place un système ambisonique d'ordre 2. 

Un système ambisonique est un système de reproduction d'environment sonore qui nécessite plusieurs enceintes. Le but d'un système ambisonique de reproduction est de spatialiser le son de la façon la plus réaliste possible.

Une spécificité de ce projet est de vouloir implémenter ce système en temps réel. Pour cela, nous allons devoir coder sur CUDA, un language similaire au C mais qui utilise des librairies qui nous permettent d'utiliser la carte graphique de l'ordinateur. Cela nous permetterais de pourvoir placer la source sonore ou l'on veut en temps réel sans pré-traitement.

Pendant ce projet, nous devions donc faire un état de l'art de l'ambisonique, mettre en place le matériel pour avoir un système ambisonique d'ordre 2, coder les algoirthmes nécessaires et gérer la connectique ordinateur/enceintes.

## Etat de l'art

Pour cette partie, Mr.Papazoglou nous a fourni avec 7 documents PDF qui présentent les différentes technologies pour la spatialisation du son. Pour nos travaux, nous nous sommes principalement inspirée des travaux de Stéphanie Salaün sur les systèmes ambisoniques. 

## Création des cables et enceintes / Carte son 

Pour notre projet nous avons donc besoins d'au minimum 8 enceintes. Pour cela, nous avons commander des haut-parleurs 8 ohm avec des pré-ampli PAMP. En ce qui concerne le boitier nous avons fait appel au technicien mécanique de l'ENSEA, Mr. Eric pour nous imprimer 8 boitiers qui pourraient tenir nos haut-parleurs avec l'amplificateur et la connectique nécessaire. En terme de connectique, nous avons utilisé des cables XLRs et des cables d'alimentation normaux. Pour envoyer le son depuis l'ordinateur vers les enceintes, nous avons utilisé une carte son Scarlett 18i20 de Focusrite. Cette carte son, qui nous a été recommandé par Mr. Papazoglou, nous convenait car ce qui nous étaient importants à avoir son les 8 sorties Jack de la carte son. 

![image](https://user-images.githubusercontent.com/56081832/149923633-b2e2b30a-b908-4420-b0a8-16d17b72ff28.png)


Ayant besoin de cables sur-mesures nous avons dû faire toute la connectique à la main:

![image](https://user-images.githubusercontent.com/56081832/149944355-f1f0782b-13f1-41c8-a606-60a15d286645.png)

![image](https://user-images.githubusercontent.com/56081832/149944485-a2fa1285-3ed8-4348-8277-ef2372acb646.png)

![image](https://user-images.githubusercontent.com/56081832/149945122-f695db07-7f23-4b6c-b13c-b12022d5cc85.png)

![image](https://user-images.githubusercontent.com/56081832/149944765-98a52a60-3671-496c-9b48-2e114023d9b4.png)

![image](https://user-images.githubusercontent.com/56081832/149945434-688d52cf-8c1e-46db-b2c8-01ccef7bd5a5.png)

Une fois le montage fait et alimenté, on peut entendre un bruit rose venant des enceintes. Nous avons plusieurs théories pourquoi cela se produit: 

Le PAM8610 n'accepte que des entrées audios asymétriques, donc nous n'utilisons pas la capacité symétrique de l'XLR. De cela, nous n'avons pas cette réduction de bruit en plus.
Une connexion asymétrique est une connexion qui nécessite 3 fiches. Sur l'une des fiches se trouve la masse et sur les deux autres se trouve le signal mais qui sont en oppsosition de phase. L'idée derrière cela est qu'à la réception du signal, on retourne l'un des signaux et on les ajoutes. Ceci compensent le bruit que l'on a potentiellement récuperer le long du cable et cela augmente l'amplitude du signal final. Une connexion asymétrique est une connexion où l'on a seulement la masse et le signal. Il n'y a donc pas de compensation de bruit avec cette connexion

Une autre source potentiel de ce bruit vient peut etre directement de l'amplificateur lui-même.

Le PAM8610 peut délivrer jusqu'à 10 W et est alimenté à 12V.



## Cablage Virtuel

Une fois la salle mise en place, nous devions raccorder les sorties réel de la carte son aux sorties virtuelles de l'ordinateur. Pour cela, nous avons utiliser le logiciel fourni par Focusrite, Focusrite Control 

![image](https://user-images.githubusercontent.com/56081832/149952667-b9a619b0-5740-4ff3-b24a-8cf247c678c3.png)

Ce logiciel nous permet de faire les cablages dans la carte son.

![image](https://user-images.githubusercontent.com/56081832/149952923-3bf578c6-10d1-45f0-b6fd-a7367962b7fa.png)

Vu que nous voulons commander chaque haut-parleur comme une source mono, nous devons en premier rendre chaque sortie indépendante de l'autre.

![image](https://user-images.githubusercontent.com/56081832/149953096-aca510ac-cf14-48ff-8abb-8e44e5873ad4.png)

Ensuite, nous devons connecter la sorite virtuelle numéro i à la sortie réel numéro i. 

Après avoir paramétré l'interface de la carte son, nous devons paramétré les connexions interne a l'ordinateur. Pour cela, nous avons pensé à utiliser QJack. Ce logiciel permet de gérer les connexions interne de l'ordinateur. Il agit en tant qu'interface entre ALSA et les clients/logiciels qui veulent jouer de l'audio:

![image](https://user-images.githubusercontent.com/56081832/149956091-cf1a397e-f1b5-4aa9-a6f3-9a87504d587d.png)

![image](https://user-images.githubusercontent.com/56081832/149954973-824127b2-bf11-4dba-b94e-39ea4fc42a8a.png)

![image](https://user-images.githubusercontent.com/56081832/149955153-3c9654d5-1a9a-4355-b926-a7b1128e73d7.png)

QJack nous permet aussi de régler la fréquence d'échantillonnage des extraits ou de changer la taille des buffers utilisés, mais nous n'avons pas vraiment utilisée cette fonctionnalité.

Pour obtenir les Outputs Port "PulseAudio Jack Sink", il faut faire attention de bien installer le module Jack pour PulseAudio. Ces output ports sont les sorties virtuelles de l'ordinateur que l'on connecte aux entrées virtuels de la carte son.

Nous avons aussi installé d'autre logiciels qui facilite l'utilisation de QJack tels que Patchage et Calf Plugin:

Patchage:
![image](https://user-images.githubusercontent.com/56081832/149957788-2092dd18-cfe0-434c-9fa5-18bd43512745.png)

Calf Plugin:
![image](https://user-images.githubusercontent.com/56081832/149957865-7e74bca7-5f33-410e-847d-2ba2b5fa3500.png)


Apres la premiere mise en place, nous arrivons a connecter notre telephone via une entree Jack de la carte son vers les enceintes que l'on choisit. Nous n'arrivons pas a sortir du son depuis l'ordinateurs directement. QJack ne nous proposait pas de sorties virtuelles. En effet, lors de la premiere mise en place nous n'avions pas access aux PulseAudio Jack Sink. 

![image](https://user-images.githubusercontent.com/56081832/151679332-384418c3-6dc2-4e24-bd74-5ca54d9ef3f9.png)

Pour obtenir cela, nous devions telecharger et installer le package "Pulse-audio-module-jack". Une fois le module installer, nous pouvions jouer de l'audio venant de l'ordinateur, par exemple, depuis Youtube.

Cependant, nous n'avions que 2 sorties virtuelles, "front-left" et "front-right". Pour notre projet, nous avons besoins de 8 sorties virtuelles. Nous pensons que nous pouvons changer le fichier de configuration de PulseAudio et/ou de Qjack pour obtenir 8 sorties virtuelles mais nous avons decide de proceder differement.

Pour commander independammant chaque enceinte, nous avons decider d'utiliser le logiciel Ardour.

![image](https://user-images.githubusercontent.com/56081832/151679795-ced3977c-250f-42df-a312-3a254e976ebf.png)

![image](https://user-images.githubusercontent.com/56081832/151679789-f29ea3bc-50fc-4d61-a193-7d63c23e6228.png)

Ardour est une plateforme de travail pour audio qui nous permet de d'acceder directement a la carte son. Nous pouvons donc associer une sortie virtuelle par track. Ceci nous permet donc de commander chaque enceinte individuellement.




## Ecriture de code Matlab 

Nous devons maintenant spacialiser notre son. Pour cela, nous avons utilise les equations presentees par Mmd Stephanie Salaun Bertet. 
Pour spacialiser notre son, nous allons projeter notre son mono sur les harmoniques spheriques. Chaque harmonique represente une direction. Il suffit donc de priviligier une harmonique par rapport a une autre pour spacialiser notre son.

Vu que nous n'allons faire qu'une spacialisation en 2D et non pas en 3D, nous allons porjeter notre son mono sur les harmoniques cylindriques.

Pour faire cela, nous allons appliquer cette formule:

![image](https://user-images.githubusercontent.com/56081832/151680441-bd6fff74-3ac2-482c-a9ee-0870f69bfc8e.png)

avec N le nombre d'enceinte, C la matrice contenant les gains correspondants aux harmoniques cylindriques, Y la matrice contenant les harmoniques cylindriques, S le vecteur contenant les echantillions de l'audio que l'on veut traiter et Sn la matrice contenant les 8 pistes pour chaque enceintes. 


Voici la forme d'Y:
![image](https://user-images.githubusercontent.com/56081832/151681129-e0681e5f-31c1-48ed-b116-b1ee620d43d0.png)
 avec a une constante permettant la conversion degree vers radian.
 
 Voici la forme de C:

![image](https://user-images.githubusercontent.com/56081832/151681396-3b056307-bb1e-432e-a20d-4224210b4ed8.png)

On peut generaliser cette formule a l'ordre que l'on veut. Nous avons utiliser un ordre 2. Evidement, plus l'ordre est grand plus la spacialisation est precise, cependant, il faut aussi plus d'enceintes 

Avec ceci nous pouvons ecrire un code matlab qui permet de pre-traiter le signal pour le spacialiser.

Nous importons 1 fichier .wav que nous traitons pour nous sortir 8 fichiers .wav que l'on jouera depuis Ardour.

## Tests 

Comme premier test, nous avons mis en place un systeme HOA d'ordre 1 (dans la matrice Y il n'y a pas les termes en cos(2theta) et sin(2theta)) et il n'y a que 4 enceintes placees a 0, 90, 180 et 270 degrees. 
Lors de ce premier test, nous avons placer un son venant de 30 degree. Nous avons demander a plusieurs personnes d'essayer de placer la source. La majorite des participants on reussi a placer la source correctement +/- 10 degrees.

Une fois que nous avions fini la production des 4 dernieres enceintes nous avons pu commencer les tests avec 8 enceintes. Nous avons refait le meme test mais en placant la source a 315 degree. Les participants ont reussi a placer la source correctement a +/- 3 degrees.

Nous avons ajouter au code d'origine pour faire bouger la source de la facon dont on veut.

##  Pour aller plus loin: premier jet code CUDA et portaudio

Nous avons donc reussi a mettre en place un syteme ambisonique d'ordre 2 et de placer une source et la faire deplacer de la facon dont on veut en pretraitant le signal. Le but originelle etant de pouvoir deplacer la source en temps reel en faisant les calculs dans le GPU avec CUDA.

Nous avons ecrit un code CUDA qui permet le traitement du signal pour obtenir les 8 tracks. Pour cela, nous devons ecrire une fonction de multiplication de matrice dans le GPU.

Ce qui pose plus de probleme est la gestion de buffer et l'envoi de ces buffers sur le codec.
Pour cela, nous pensons utiliser PortAudio.

PortAudio est une library open-source qui permet de jouer et d'enregister de l'audio. Cette library gere les transfers de buffers vers le codec donc nous pensions pouvoir utiliser ceci pour commander nos enceintes via la Scarlett. Il existe deja des fichers code exemple qui permettent de detecter la carte son et le nombre de sorties disponbiles mais aussi des fichiers codes qui permettent d'envoyer les buffers directement au codec

Cependant, il semble que pour installer PortAudio, il faut desintaller PulseAudio. Ne connaissant pas completement les ramifications de desintaller PulseAudio et arrivant a la fin de notre projet nous avons decider de ne pas continuer.

On pensait utiliser une time machine pour sauvegarder notre travail jusqu'a la mais nous n'avons pas eu le temps pour faire cela.


## Conclusion 

Pendant ces 4 mois, nous avons reussi a construire un systeme ambisonique d'ordre 2 et de correctement spatiliser un son et de le deplacer de la facon dont on veut.
