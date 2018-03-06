%% Universidade Federal de Campina Grande
%% Máquinas Elétricas
% Autor: Lucas Eliseu Gonçalves de Arruda
% Experimento 3: Reatância de dispersão

% Método Blondel

clear;
% Entradas
deltaVl = 158.4;    %4.4cm * 36
Ra = 38.671 ;       % R75 do laboratorio 2
Vt = 282.5;         % Tensao de regime do ensaio
fp = 0.8;
Ia = 800*10^(-3);   % Corrente de regime do ensaio

% Passo 1: Calculo de Xl
Xl = deltaVl/(sqrt(3)*Ia);

% Passo 2: Calculo de E':
% Eh preciso primeiro determinar os valores de Xd e Xq:
Iazs = 3.5*80*10^(-3);

Zsnsat = Vt/(sqrt(3)*Iazs);

Xsnsat = sqrt(Zsnsat^2 - Ra^2);

Xd = Xsnsat;
Xq = 0.57*Xd;

Eaux = Vt/sqrt(3) + Ra*(Ia*(cos(acos(fp)) - j*sin(acos(fp)))) + j*Xq*(Ia * (cos(acos(fp)) - j*sin(acos(fp))));
delta = angle(Eaux);

% Passo 3: Ed
Ed_fase = (Vt/sqrt(3))*cos(delta) + Xl*Ia*sin(delta + acos(fp)) + Ra*Ia*cos(delta + acos(fp));

Ed_linha_abs = abs(Ed_fase)*sqrt(3);

Ed_linha_cm = Ed_linha_abs/36;

% Passo 4: Entrar com Ed na curva CA e verificar respectivo valor de If
Rdcm = 4.7;
Rd = Rdcm*30;

% Passo 5: Determinar O'A'
OAcm = 13.8;
OA = OAcm*30;

If1 = OA;

% Passo 6: Determinar C'A' = A
m_entreferro = (12*36 - 0)/(7.6*30*10^(-3) - 0);
If2 = deltaVl/m_entreferro;

A = If1*10^(-3) -If2;

% Passo 7: Excitacao necessaria para compensar a reacao de armadura no eixo direto
Ad = A*sin(delta + acos(fp));

% Passo 8: Excitacao de campo total
F = Rd*10^(-3) + Ad

Fcm = (F*10^(3))/30

% Passo 9: Determinacao do valor de Ef
% Com o valor de F, é preciso fazer extrapolação para determinar Ef:
syms a b;

P1 = [300*10^(-3), 13.9*36];
P2 = [12*30*10^(-3), 15.65*36];

% Va = a*if/(b + if) => Va*b + Va*if = a*if
% a*if - b*Va = - Va*if
eq1 = a*P1(1) - b*P1(2) == P1(1)*P1(2);
eq2 = a*P2(1) - b*P2(2) == P2(1)*P2(2);

[A,B] = equationsToMatrix([eq1, eq2], [a, b]);

X = linsolve(A,B);

Ef = X(1)* F/(X(2) + F)


% Passo 10: Regulacao
reg = (Ef - Vt)/Vt;












