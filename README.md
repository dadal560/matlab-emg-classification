# Surface EMG Gesture Analysis

Une chaîne de traitement MATLAB complète pour l'analyse, la segmentation et la classification de signaux électromyographiques de surface (sEMG).

![MATLAB](https://img.shields.io/badge/Language-MATLAB-orange)
![Status](https://img.shields.io/badge/Status-Academic%20Project-blue)
![University](https://img.shields.io/badge/Institution-La%20Rochelle%20Université-red)

## Description

Ce projet implémente un algorithme de traitement du signal capable de différencier deux gestes de la main à partir de données brutes sEMG de manière non invasive :

1.  **Double Tap :** Mouvements rapides, périodiques et intermittents.
2.  **Fist (Poing fermé) :** Contractions musculaires intenses, maintenues et générant une activité plus longue.

L'application couvre toute la chaîne : visualisation des signaux bruts, détection des phases d'activation, segmentation temporelle et extraction de caractéristiques pour la classification.

---

## Installation et Configuration

### Prérequis

* **MATLAB** (R2018b ou plus récent recommandé).
* **Signal Processing Toolbox** (nécessaire pour les fonctions de convolution).
* Jeu de données EMG (fichiers bruts).

### Installation

1.  **Clonez le dépôt**
    ```bash
    git clone https://github.com/dadal560/matlab-emg-classification.git
    cd matlab-emg-classification
    ```

2.  **Structure des dossiers**
    Le projet respecte l'architecture suivante :
    ```text
    matlab-emg-classification/
    │── data/                # Fichiers de données des signaux bruts
    ├── main.m           # Codes sources MATLAB
    │── results/             # Graphiques générés
    │── README.md            # Documentation du projet
    └── .gitignore
    ```

---

## Utilisation

### Lancement de l'analyse

1.  Exécutez le script principal :

    ```matlab
    >> main
    ```

### Sorties graphiques

L'application génère automatiquement les figures suivantes pour l'analyse :

* **Visualisation brute :** Affichage des 8 canaux pour observer les différences d'amplitude entre le "Double Tap" et le "Fist".
* **Détection d'activité :** Superposition de l'enveloppe lissée (rouge) et des zones d'activation détectées (vert).
* **Segmentation :** Visualisation individuelle de chaque contraction isolée.
* **Classification :** Nuage de points 2D (Moyenne vs Variance) montrant la séparation des classes.

---

## Architecture et Fonctionnalités

### 1. Prétraitement et Détection (Preprocessing)
Le signal brut est traité pour séparer le bruit de l'activité musculaire réelle :

* **Enveloppe :** Calcul de la valeur absolue du signal.
* **Lissage (Low-pass) :** Application d'un filtre moyenneur sur une fenêtre de **80 points** ($N=80$) pour ne conserver que la tendance générale et éliminer les variations rapides.
* **Seuillage :** Binarisation du signal. Si le signal lissé dépasse **0.5**, le muscle est considéré comme actif.

### 2. Segmentation Automatique
Une fois les zones d'activation identifiées, l'algorithme détecte les transitions pour découper le signal :

* Recherche des fronts montants (0 à 1) pour le début du segment.
* Recherche des fronts descendants (1 à 0) pour la fin du segment.
* Cette méthode permet d'isoler environ **10 segments courts** pour un geste de type "Double Tap".

### 3. Extraction de Caractéristiques (Feature Extraction)
Pour permettre la classification, deux descripteurs statistiques sont calculés sur chaque segment :

* **Moyenne (mean) :** Représente le niveau moyen d'activation musculaire.
* **Variance (var) :** Mesure la variabilité de l'activation.

### 4. Résultats de Classification
L'analyse montre une séparation nette :

* Le geste **Fist** présente une variance plus élevée, indiquant une contraction plus complexe.
* Le **Double Tap** se concentre dans des valeurs de variance plus faibles.
* Une droite de régression linéaire permet de séparer visuellement les deux groupes.

---

## Dépannage

**Problème : Aucune activation n'est détectée.**
* *Cause possible :* Le signal est trop faible par rapport au seuil fixé.
* *Solution :* Essayez de réduire la variable `Seuil` (ex: 0.3) dans le script principal.

**Problème : La segmentation coupe une seule contraction en plusieurs morceaux.**
* *Cause possible :* Le lissage est insuffisant.
* *Solution :* Augmentez la taille de la fenêtre `N` (ex: 100) pour lisser davantage l'enveloppe.

---

## Auteur et Crédits

- Auteur : Gwendal Henry
- Email : gwen.henry56@gmail.com
- Issues : [GitHub Issues](https://github.com/dadal560/flask-mailer/issues)

---

⭐ **N'oubliez pas de star le projet si il vous a été utile !**

