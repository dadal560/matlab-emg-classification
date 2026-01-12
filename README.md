# Surface EMG Gesture Analysis

Une chaîne de traitement MATLAB complète pour l'analyse, la segmentation et la classification de signaux électromyographiques de surface (sEMG).

![MATLAB](https://img.shields.io/badge/Language-MATLAB-orange)
![Status](https://img.shields.io/badge/Status-Academic%20Project-blue)
![University](https://img.shields.io/badge/Institution-La%20Rochelle%20Université-red)

## 📋 Description

Ce projet implémente un algorithme de traitement du signal capable de différencier deux gestes de la main à partir de données brutes sEMG de manière non invasive :

1.  **Double Tap :** Mouvements rapides, périodiques et intermittents.
2.  **Fist (Poing fermé) :** Contractions musculaires intenses, maintenues et générant une activité plus longue.

L'application couvre toute la chaîne : visualisation des signaux bruts, détection des phases d'activation, segmentation temporelle et extraction de caractéristiques pour la classification.

---

## ⚙️ Installation et Configuration

### Prérequis

* **MATLAB** (R2018b ou plus récent recommandé).
* **Signal Processing Toolbox** (nécessaire pour les fonctions de convolution).
* Jeu de données EMG (fichiers bruts).

### Installation

1.  **Clonez le dépôt**
    ```bash
    git clone [https://github.com/votre-username/semg-gesture-analysis.git](https://github.com/votre-username/semg-gesture-analysis.git)
    cd semg-gesture-analysis
    ```

2.  **Structure des dossiers**
    Le projet respecte l'architecture suivante :
    ```text
    semg-gesture-analysis/
    │── data/                # Fichiers de données des signaux bruts
    │── src/                 # Codes sources MATLAB
    │   ├── main.m           # Point d'entrée principal
    │   ├── detection.m      # Algorithme de lissage et seuillage
    │   └── features.m       # Calcul des caractéristiques (Moy/Var)
    │── results/             # Graphiques générés
    │── README.md            # Documentation du projet
    └── .gitignore
    ```

### Configuration des Paramètres

Les paramètres clés de l'algorithme sont définis pour optimiser la détection :

```matlab
% Paramètres de lissage
N = 80;                 % Taille de la fenêtre du filtre moyenneur

% Paramètres de détection
Seuil = 0.5;            % Seuil d'activation (Trigger)
