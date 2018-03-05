% Entradas
Vf = [9.7 19.5 29.2 38.9];
Vq = [10.5 20.8 31.5 41.4];
I = [100 200 300 400]*10^(-3);
T1 = 25;

% Média de Rf e Rq
Rfvec = Vf./(3*I);
Rqvec = Vq./(3*I);
Rfm = 0;
Rqm = 0;
for i = 1:4
  Rfm = Rfm + Rfvec(i);
  Rqm = Rqm + Rqvec(i);
end

Rfm = Rfm/4;
Rqm = Rqm/4;

% Estimativa de T2
T2 = T1 + ((Rqm - Rfm)/Rfm)*(234.5 + T1);

Ra = Rqm + Rqm*((75-T2)/(234.5 + T2));

