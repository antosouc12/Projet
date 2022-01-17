%% Test

N=8;

a=pi/180;
theta=300;

C=[1 sqrt(2) 0 sqrt(2) 0; 
   1 sqrt(2)/2 sqrt(2)/2 0 sqrt(2);
   1 0 sqrt(2) -1*sqrt(2) 0;
   1 -1*sqrt(2)/2 sqrt(2)/2 0 -1*sqrt(2);
   1 -1*sqrt(2) 0 sqrt(2) 0 ;
   1 -1*sqrt(2)/2 -1*sqrt(2)/2 0 sqrt(2);
   1 0 -1*sqrt(2) -1*sqrt(2) 0;
   1 sqrt(2)/2 -1*sqrt(2)/2 0 -1*sqrt(2)];



Y=[1;
   sqrt(2)*cos(a*theta);
   sqrt(2)*sin(a*theta);
   sqrt(2)*cos(2*a*theta);
   sqrt(2)*sin(2*a*theta)];
%% Audio read;


[s,fs]=audioread('VehCar.wav');
%[s,fs]=audioread('Université-de-Cergy-Pontoise-2.wav');
s=transpose(s);

%%

s=upsample441(s);

%%

audiowrite('Urban.wav',s,48000);

%% 

load('playback_48000.mat')

%% Synthèse 
disp(size(C));
disp(size(Y));
G=C*Y/8;
disp(size(G));
disp(size(s'));
Sn=G*s';
disp(size(G));
disp(size(s));
disp(size(Sn));

%% Test

sound(w480,48000);

%%

Sn=mouv135225(s',1);

%% 

S=mouv(w480,1);


%% Out

audiowrite('Carsorite0.wav',Sn(1,:),48000);
audiowrite('Carsorite45.wav',Sn(2,:),48000);
audiowrite('Carsorite90.wav',Sn(3,:),48000);
audiowrite('Carsorite135.wav',Sn(4,:),48000);
audiowrite('Carsorite180.wav',Sn(5,:),48000);
audiowrite('Carsorite225.wav',Sn(6,:),48000);
audiowrite('Carsorite270.wav',Sn(7,:),48000);
audiowrite('Carsorite315.wav',Sn(8,:),48000);