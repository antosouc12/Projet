%% Initialisation des valeurs

N=8;  % Le nombre d'enceintes 

a=pi/180;   %Conversion angle:radian
theta=300;  %L'angle de placement de la source 

%% Initialisation des matrices 

C=[1 sqrt(2) 0 sqrt(2) 0;        %%
   1 sqrt(2)/2 sqrt(2)/2 0 sqrt(2);
   1 0 sqrt(2) -1*sqrt(2) 0;
   1 -1*sqrt(2)/2 sqrt(2)/2 0 -1*sqrt(2);
   1 -1*sqrt(2) 0 sqrt(2) 0 ;
   1 -1*sqrt(2)/2 -1*sqrt(2)/2 0 sqrt(2);
   1 0 -1*sqrt(2) -1*sqrt(2) 0;
   1 sqrt(2)/2 -1*sqrt(2)/2 0 -1*sqrt(2)];


Y=[1;          %% 
   sqrt(2)*cos(a*theta);
   sqrt(2)*sin(a*theta);
   sqrt(2)*cos(2*a*theta);
   sqrt(2)*sin(2*a*theta)];

%% Audio read;

[s,fs]=audioread('VehCar.wav');  %Lecture du fichier audio .wav
s=transpose(s);  % On transpose la matrice pour avoir les dimensions correctes de la matrice

%% Upsample 

s=upsample441(s); % Certains extraits audios que l'on a utilisés etaient échantillonnés a une fréquence Fe=44,1 kHz.
                  % Le logiciel que l'on utilise fonctionnait avec une fréquence d'échantillonnage Fe=48kHz.
                  % Nous devons donc changer la fréquence d'échantillonnage de l'extrait.



%% Synthèse 

G=C*Y/8;  %Création des pistes audios pour les 8 enceintes 
Sn=G*s'; %Les enceintes sont ordonnées dans le sens Trigonométrique. L'enceinte numéro 1 étant devant l'auditeur et l'enceinte numéro 2 étant à la gauche de la première 

%%

Sn=mouv135225(s',1); %% Cette fonction crée les 8 pistes pour les 8 enceintes pour donner l'impression que la source se déplace d'un angle de 135° vers 225°

%% 

Sn=mouv(w480,1); %% Cette fonction crée les 8 pistes pour les 8 enceintes pour donner l'impression que la source se déplace d'un angle de 0° vers 360°


%% Out

%On ecrit les sorties contenues dans Sn dans des fichiers .wav pour les jouers depuis un autre logiciel.

audiowrite('Carsorite0.wav',Sn(1,:),48000);
audiowrite('Carsorite45.wav',Sn(2,:),48000);
audiowrite('Carsorite90.wav',Sn(3,:),48000);
audiowrite('Carsorite135.wav',Sn(4,:),48000);
audiowrite('Carsorite180.wav',Sn(5,:),48000);
audiowrite('Carsorite225.wav',Sn(6,:),48000);
audiowrite('Carsorite270.wav',Sn(7,:),48000);
audiowrite('Carsorite315.wav',Sn(8,:),48000);
