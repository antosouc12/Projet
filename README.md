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

## Etat de l'art 

Pour cette partie, Mr.Papazoglou nous a fourni avec 7 documents PDF qui présentent les différentes technologies pour la spatialisation du son. Pour nos travaux, nous nous sommes principalement inspirée des travaux de Stéphanie Salaün sur les systèmes ambisoniques. 

## Création des cables et enceintes / Carte son 

Pour notre projet nous avons donc besoins d'au minimum 8 enceintes. Pour cela, nous avons commander des haut-parleurs 8 ohm avec des pré-ampli PAMP. En ce qui concerne le boitier nous avons fait appel au technicien mécanique de l'ENSEA, Mr. Eric pour nous imprimer 8 boitiers qui pourraient tenir nos haut-parleurs avec l'amplificateur et la connectique nécessaire. En terme de connectique, nous avons utilisé des cables XLRs et des cables d'alimentation normaux. Pour envoyer le son depuis l'ordinateur vers les enceintes, nous avons utilisé une carte son Scarlett 18i20 de Focusrite. Cette carte son, qui nous a été recommandé par Mr. Papazoglou, nous convenait car ce qui nous étaient importants à avoir son les 8 sorties Jack de la carte son. 

![image](https://user-images.githubusercontent.com/56081832/149923633-b2e2b30a-b908-4420-b0a8-16d17b72ff28.png)


Ayant besoin de cables sur-mesures nous avons dû faire toute la connectique à la main 

