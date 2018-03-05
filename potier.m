% Entradas
deltaVl = 158.4;    %4.4cm * 36
Ra = 38.671 ;       % R75 do laboratório 2
Vt = 282.5;         % Tensão de regime do ensaio
fp = 0.8;
Ia = 800*10^(-3);   % Corrente de regime em ensaio

% Passo 1: Cálculo de Xl
Xl = deltaVl/(sqrt(3)*Ia);

% Passo 2: Cálculo de Xp
Xp = 1.20*Xl;

% Passo 3: Determinação da tensão de Potier (Vp)
Vpfase = Vt/sqrt(3) + Ra*(Ia * (cos(acos(fp)) - j*sin(acos(fp)))) + j*Xp*(Ia * (cos(acos(fp)) - j*sin(acos(fp))));

Vplinha = abs(Vpfase)*sqrt(3);

Vplinhacm = Vplinha/36;   % Depende da escala escolhinda para o gráfico

% Passo 4: Fator de saturação (Ks)
IfvpCAcm = 8.8;
IfvpEntreferrocm = 8.05;

IfvpCA = IfvpCAcm*30;   % Depende da escala de if
IfvpEntreferro = IfvpEntreferrocm*30;

Ks = IfvpCA/IfvpEntreferro;

% Passo 5: Determinar Xs(n/sat)
Vtcm = Vt/36;    %Depende da escala de Va e é usado para marcar Vt no gráfico
%Projeta o ponto onde Vt se encontra para a reta cc e verifica o valor de Ia
Iazs = 3.5*80*10^(-3);

Zsnsat = Vt/(sqrt(3)*Iazs);

Xsnsat = sqrt(Zsnsat^2 - Ra^2);


