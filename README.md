# Projet de 3ème année : Création d'un système ambisonique d'ordre 2

## Somaire 

-Remerciement 

-Présentation du projet 

-Etat de l'art 

-Création des cables et enceintes / Carte son

-Ecriture du Code Matlab 

-Tests 

-Pour aller plus loin: premier jet code CUDA et portaudio

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

## Etat de lScreenshot from 2022-01-18 14-27-28'art 

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


Une fois la salle mise en place, nous devions raccorder les sorties réel de la carte son aux sorties virtuelles de l'ordinateur. Pour cela, nous avons utiliser le logiciel fourni par Focusrite 





