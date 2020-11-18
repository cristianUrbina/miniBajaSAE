%Cálculo de tracción
%Código propiedad de Escudería RamVolution ITESM Tampico

clc
clear all
close all 
format bank 

%Specs 
masa = 300; %kg
peso = masa*9.81; %Newtons 
areafrontal = 1.23; %m^2
dllanta = 0.6; %metros
rllanta = dllanta/2; %metros
cf = 0.75; %coeficiente de fricción
cr = 0.03; %coeficiente de rodamiento
cd = 0.4; %coeficiente de resistencia aerodinámica
daire = 1.2; %kg/m^3 
df = 0.42;  %distribución frontal (%)
dt = 0.58;  %distribución trasera (%)
eficiencia_motor = 0.75; % (%)
velocidad_llantas = 16.67; %m/s

%Fuerzas de resistencia 
ra = 1/2*cd*daire*(velocidad_llantas)^2*areafrontal; %resistencia aerodinámica
rr = cr*peso; %resistencia al giro de las llantas

%Cálcular esfuerzo tractivo en una pendiente
for k=5:5:40 %ángulo de inclinación
    FT = peso*sind(k);
    esfuerzo_total = ra+rr+FT;
    FTmax = cf*(peso*cosd(k)*dt); 
    
    if esfuerzo_total<FTmax
        a = esfuerzo_total;
    end
end

%Obtener el ratio en marcha baja
torqueW = a*rllanta; %N*m
marcha_baja = torqueW/(18.98*eficiencia_motor); 

%Obtener el ratio en marcha alta  
velocidad_angular = velocidad_llantas/rllanta; 
RPM_llantas = (velocidad_angular*60)/(2*pi); 
marcha_alta = 3800/RPM_llantas; 

%Calcular ratios y dientes de sprockets
%Marcha baja
R1_baja = 2.7; %CVT high ratio 
R_final = marcha_baja/R1_baja; 
R2_baja = 2; 
R3_baja = R_final/2; 

Na = 10; %dientes de sprocket 
Nc = 7;  %dientes de sprocket

Nb_baja = round(Na*R2_baja); %dientes de sprocket
Nd_baja = round(Nc*R3_baja); %dientes de sprocket

%Marcha alta
R1_alta = 0.9; %CVT low ratio
R_final_alta = marcha_alta/R1_alta; 
R2_alta = 2; 
R3_alta = R_final_alta/2; 

Nd_alta = round(Nc*R3_alta); %dientes de sprocket

%Resultados
fprintf('Sprockets de entrada \n')
fprintf('Na = %g \n', Na)
fprintf('Nb = %g \n',Nb_baja)

fprintf('\n')

fprintf('Sprockets para la marcha baja \n')
fprintf('Nc = %g dientes \n',Nc)
fprintf('Nd = %g dientes \n',Nd_baja)

fprintf('\n')

fprintf('Sprockets para la marcha alta \n')
fprintf('Nc = %g dientes \n',Nc)
fprintf('Nd = %g dientes \n',Nd_alta)
