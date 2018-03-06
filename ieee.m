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