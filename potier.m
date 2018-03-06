%% Método Potier
clear;
% Entradas
deltaVl = 158.4;    %4.4cm * 36
Ra = 38.671 ;       % R75 do laboratorio 2
Vt = 282.5;         % Tensao de regime do ensaio
fp = 0.8;
Ia = 800*10^(-3);   % Corrente de regime do ensaio

% Passo 1: Calculo de Xl
Xl = deltaVl/(sqrt(3)*Ia);

% Passo 2: Calculo de Xp
Xp = 1.20*Xl;

% Passo 3: Determinacao da tensao de Potier (Vp)
Vpfase = Vt/sqrt(3) + Ra*(Ia * (cos(acos(fp)) - j*sin(acos(fp)))) + j*Xp*(Ia * (cos(acos(fp)) - j*sin(acos(fp))));

Vplinha = abs(Vpfase)*sqrt(3);

Vplinhacm = Vplinha/36;   % Depende da escala escolhinda para o grafico

% Passo 4: Fator de saturacao (Ks)
IfvpCAcm = 8.8;
IfvpEntreferrocm = 8.05;

IfvpCA = IfvpCAcm*30;   % Depende da escala de if
IfvpEntreferro = IfvpEntreferrocm*30;

Ks = IfvpCA/IfvpEntreferro;

% Passo 5: Determinar Xs(n/sat)
Vtcm = Vt/36;    %Depende da escala de Va e eh usado para marcar Vt no grafico
%Projeta o ponto onde Vt se encontra para a reta cc e verifica o valor de Ia
Iazs = 3.5*80*10^(-3);

Zsnsat = Vt/(sqrt(3)*Iazs);

Xsnsat = sqrt(Zsnsat^2 - Ra^2);

% Passo 6: Determinar Xms
Xms = (Xsnsat - Xl)/Ks;

% Passo 7: Determinar Xs(sat)
Xssat = Xms + Xp;

% Passo 8: Determinar Ef
Xdsat = Xssat;
Xqsat = 0.57*Xdsat;

Eaux = Vt/sqrt(3) + Ra*(Ia*(cos(acos(fp)) - j*sin(acos(fp)))) + j*Xqsat*(Ia * (cos(acos(fp)) - j*sin(acos(fp))));

absEf = abs(Eaux) + Ia*sin((acos(fp) + angle(Eaux))*180/pi)*(Xdsat - Xqsat);
%Ef = Vt/sqrt(3) + Ra*(Ia * (cos(acos(fp)) - j*sin(acos(fp)))) + j*Xssat*(Ia * (cos(acos(fp)) - j*sin(acos(fp))))
Ef = absEf*exp(-j*angle(Eaux));

absEflinha = absEf*sqrt(3);

% Como Ef nao pode ser representado no papel milimetrado com a escala
% escolhida, deve-se fazer uma extrapolacao para a parte curva da curva
% caracteristica da maquina do tipo: Va = a*if/(b + if). Para determinar os
% parametros 'a' e 'b', deve-se escolher dois pontos pertencentes à parte
% curva do gráfico e resolver o sistema de equações:
syms a b;

P1 = [300*10^(-3), 13.9*36];
P2 = [12*30*10^(-3), 15.65*36];

% Va = a*if/(b + if) => Va*b + Va*if = a*if
% a*if - b*Va = - Va*if
eq1 = a*P1(1) - b*P1(2) == P1(1)*P1(2);
eq2 = a*P2(1) - b*P2(2) == P2(1)*P2(2);

[A,B] = equationsToMatrix([eq1, eq2], [a, b]);

X = linsolve(A,B);


% Determinação da reta de Potier
mp = (Vplinha-0)/(IfvpCA*10^(-3)-0)     %Coeficiente angular da reta de Potier
% Vp = mp*if => if = Vp/m
ifEf = (absEflinha/mp) ;           %Determina a abscissa de E0

% Calculo de E0
E0 = X(1).*ifEf/(X(2) + ifEf)

% Calculo da regulacao
Reg = (E0 - Vt)/Vt

% Cálculo do fator de forma
basecm = 11;
baseif = basecm*30*10^(-3);
alfa = baseif/Ia;
