%% Método IEEE
clear;
% Entradas
deltaVl = 158.4;    %4.4cm * 36
Ra = 38.671 ;       % R75 do laboratorio 2
Vt = 282.5;         % Tensao de regime do ensaio
fp = 0.8;
Ia = 800*10^(-3);   % Corrente de regime do ensaio

% Passo 1: Calculo de Xl
Xp = deltaVl/(sqrt(3)*Ia);

% Passo 2: Determinacao da tensao de Potier (Vp)
Vpfase = Vt/sqrt(3) + Ra*(Ia * (cos(acos(fp)) - j*sin(acos(fp)))) + j*Xp*(Ia * (cos(acos(fp)) - j*sin(acos(fp))));

% Passo 3: Componentes da corrente de campo
Ifgcm = 4.9;
Ifsicm = 13.8;
Ifscm = 8.8;

Ifg = Ifgcm*30;
Ifsi = Ifsicm*30;
Ifs = Ifscm*30;

Ifl = Ifs + sqrt((Ifg + Ifsi*sin(acos(fp)))^2 + (Ifsi*cos(acos(fp)))^2);



% Passo 4