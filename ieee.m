%% Universidade Federal de Campina Grande
%% Máquinas Elétricas
% Autor: Lucas Eliseu Gonçalves de Arruda
% Experimento 3: Reatância de dispersão

% Método IEEE

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

Vplinha = abs(Vpfase)*sqrt(3);

Vplinhacm = Vplinha/36;   % Depende da escala escolhinda para o grafico

% Passo 3: Componentes da corrente de campo
Ifgcm = 4.9;
Ifsicm = 13.8;
Ifscm = 8.8;

Ifg = Ifgcm*30;
Ifsi = Ifsicm*30;
Ifs = Ifscm*30;

Ifl = Ifs + sqrt((Ifg + Ifsi*sin(acos(fp)))^2 + (Ifsi*cos(acos(fp)))^2);

% Passo 4: Determinação de Ef
Iflcm = Ifl/30;

% Com o valor obtido para Ifl não corresponde a um valor ensaiado na curva
% CA, deve-se realizar extrapolação: Va = a*if/(b + if)

syms a b;

P1 = [300*10^(-3), 13.9*36];
P2 = [12*30*10^(-3), 15.65*36];

% Va = a*if/(b + if) => Va*b + Va*if = a*if
% a*if - b*Va = - Va*if
eq1 = a*P1(1) - b*P1(2) == P1(1)*P1(2);
eq2 = a*P2(1) - b*P2(2) == P2(1)*P2(2);

[A,B] = equationsToMatrix([eq1, eq2], [a, b]);

X = linsolve(A,B);

% Assim, o Ef pode ser determinado como:
Ef = X(1)* Ifl*10^(-3)/(X(2) + Ifl*10^(-3))

% Passo 5: Calculo da regulacao
reg = (Ef - Vt)/Vt 


