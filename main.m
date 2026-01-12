clear all
close all

% 1. CRÉATION DU DOSSIER DE SAUVEGARDE
output_dir = 'results';
if ~exist(output_dir, 'dir')
    mkdir(output_dir);
end

%  Chargement et visualisation des données "double_tap" 
signales = load("data/double_tapMat.dat"); 
temp = signales(:, 1);                 

f1 = figure('Visible', 'on'); % On nomme la figure f1
for i = 2:9
    signale = signales(:, i);          
    subplot(8,1,i-1)                  
    plot(temp,signale) 
    ylabel(['S', num2str(i-1)])
end
xlabel('Temps (s)')
% SAUVEGARDE FIGURE 1
saveas(f1, fullfile(output_dir, '1_double_tap_raw.png'));

%  Chargement et visualisation des données "fist" 
signales2 = load("data/fistMat.txt");
temp2 = signales2(:, 1);

f2 = figure('Visible', 'on');
for i = 2:9
    signale = signales2(:, i);
    subplot(8,1,i-1)
    plot(temp2,signale)
    ylabel(['S', num2str(i-1)])
end
xlabel('Temps (s)')
% SAUVEGARDE FIGURE 2
saveas(f2, fullfile(output_dir, '2_fist_raw.png'));

% Comparaison du 9ème signal 
f3 = figure('Visible', 'on'); 
subplot(2,1,1)
plot(temp,signales(:, 9))
title('double\_tap signal 9')
subplot(2,1,2)
plot(temp2,signales2(:, 9))
title('fist signal 9')
% SAUVEGARDE FIGURE 3
saveas(f3, fullfile(output_dir, '3_comparison_signal9.png'));

% Détection d'activité 
f4 = figure('Visible', 'on'); 
enveloppe1 = abs(signales(:, 9));   
enveloppe2 = abs(signales2(:, 9));
S1 = 0.5;                            
S2 = 0.5;                             
N = 80;                              
tabh = ones(1,N)/N;
tab1 = conv(enveloppe1, tabh, 'same'); 
tab2 = conv(enveloppe2, tabh, 'same');
hauteur_ligne = 12;                    
activation_1 = tab1 > S1;            
activation_2 = tab2 > S2;
ligne_activation_1 = activation_1 * hauteur_ligne; 
ligne_activation_2 = activation_2 * hauteur_ligne;

% Affichage des activations
subplot(2,1,1)
plot(temp,tab1,'r') 
ylim([0.2 15])
hold on
plot(temp, ligne_activation_1, 'g') 
hold off
ylabel('Amplitude')
title('double\_tap activation')

subplot(2,1,2)
plot(temp2,tab2,'r')
ylim([0.2 15])
hold on
plot(temp2, ligne_activation_2, 'g')
hold off
ylabel('Amplitude')
title('fist activation')
% SAUVEGARDE FIGURE 4
saveas(f4, fullfile(output_dir, '4_detection_activation.png'));

% Segmentation du signal "fist" basé sur l'activation
f5 = figure('Visible', 'on');
signal_brut = signales2(:, 9);
act_double = double(activation_2);
diff_act = diff([0; act_double]);
idx_debut = find(diff_act == 1); 
idx_fin = find(diff_act == -1) - 1; 
if length(idx_debut) > length(idx_fin)
    idx_fin(end + 1) = length(act_double); 
end
num_segments = length(idx_debut);
longueur_signal = length(signal_brut);

subplot(11,1,1)
plot(temp2,signal_brut)
title('Signal Brut Complet (fist)')
ylabel('Amplitude')

for k = 5:num_segments
    start_idx = idx_debut(k);
    end_idx = idx_fin(k);
    
    signal_segment_zero_padded = zeros(longueur_signal, 1);
    signal_segment_zero_padded(start_idx:end_idx) = signal_brut(start_idx:end_idx);
    
    subplot(7, 1, k-3);
    plot(temp2, signal_segment_zero_padded, 'm');
    ylim([min(signal_brut) * 1.1, max(signal_brut) * 1.1]);
    title(['Segment ', num2str(k)]);
    ylabel('Amplitude')
end
xlabel('Temps (s)')
% SAUVEGARDE FIGURE 5
saveas(f5, fullfile(output_dir, '5_segmentation.png'));

% Extraction des caractéristiques 
f6 = figure('Visible', 'on');
signal_dt = signales(:, 9);
act_double_dt = double(tab1 > S1);
diff_act_dt = diff([0; act_double_dt]);
idx_debut_dt = find(diff_act_dt == 1);
idx_fin_dt = find(diff_act_dt == -1) - 1;

if length(idx_debut_dt) > length(idx_fin_dt)
    idx_fin_dt(end + 1) = length(act_double_dt);
end

num_segments_dt = length(idx_debut_dt);
features_dt_x = zeros(num_segments_dt, 1);
features_dt_y = zeros(num_segments_dt, 1);

for k = 1:num_segments_dt
    segment = signal_dt(idx_debut_dt(k):idx_fin_dt(k));
    features_dt_x(k) = mean(segment); 
    features_dt_y(k) = var(segment); 
end

signal_f = signales2(:, 9);
features_f_x = zeros(num_segments, 1);
features_f_y = zeros(num_segments, 1);

for k = 1:num_segments
    segment = signal_f(idx_debut(k):idx_fin(k));
    features_f_x(k) = mean(segment);
    features_f_y(k) = var(segment);
end

all_x = [features_dt_x; features_f_x];
all_y = [features_dt_y; features_f_y];

% Affichage du nuage de points avec ligne de séparation
hold on
scatter(features_dt_x, features_dt_y, 50, 'filled', 'MarkerFaceAlpha', 0.7)
scatter(features_f_x, features_f_y, 50, 'filled', 'MarkerFaceAlpha', 0.7)

a = 1.5;      
b = 19.5;     
x_fit = linspace(min(all_x), max(all_x), 100);
y_fit = a * x_fit + b;
plot(x_fit, y_fit, 'k-', 'LineWidth', 1.5);

xlabel('Moyenne du segment')
ylabel('Variance du segment')
title('Nuage de points des segments')
% SAUVEGARDE FIGURE 6
saveas(f6, fullfile(output_dir, '6_classification.png'));

disp(['Terminé. Toutes les figures sont enregistrées dans le dossier : ', output_dir]);