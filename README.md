# Surface EMG Signal Analysis

**Auteur :** Gwendal Henry (La Rochelle Université)
**Sujet :** Traitement du signal biomédical (sEMG)
**Langage :** MATLAB

## Description
Ce projet documente l'analyse de signaux électromyographiques de surface pour caractériser deux gestes de la main distincts :
1.  **Double Tap :** Mouvements rapides et intermittents.
2.  **Fist (Poing fermé) :** Contractions musculaires maintenues avec une forte intensité.

L'objectif est de visualiser les signaux bruts, de détecter automatiquement les phases d'activation, de segmenter les données et d'extraire des caractéristiques discriminantes pour la classification.

## Chaîne de traitement

### 1. Prétraitement et Détection d'activité
Pour distinguer les phases de repos des phases d'activité, la méthode suivante est appliquée :
* **Enveloppe :** Calcul de la valeur absolue du signal brut.
* **Lissage :** Application d'un filtre moyenneur avec une fenêtre de **80 points** (N=80) pour ne garder que la tendance générale.
* **Seuillage :** Un seuil d'activation est fixé à **0.5**. Si le signal lissé est supérieur à 0.5, le muscle est considéré comme actif.

### 2. Segmentation Temporelle
Le signal binaire d'activation est utilisé pour isoler chaque contraction. L'algorithme repère les transitions (passages de 0 à 1 et de 1 à 0) pour découper le signal en segments individuels.
* Cela permet d'isoler environ 10 segments courts pour le geste "Double Tap".
* Les segments du "Fist" apparaissent plus longs.

### 3. Extraction de caractéristiques (Feature Extraction)
Pour classifier les gestes, deux métriques statistiques sont calculées sur chaque segment isolé :
* **Moyenne (mean) :** Indique le niveau moyen d'activation musculaire.
* **Variance (var) :** Mesure la variabilité du signal.

## Résultats
L'analyse de l'espace des caractéristiques (Moyenne vs Variance) révèle une séparation nette entre les deux gestes :
* Le geste **Fist** présente une variance significativement plus élevée, reflétant une contraction complexe et variable.
* Le **Double Tap** se regroupe dans une zone de variance plus faible.
* Une régression linéaire permet de visualiser la frontière de décision, validant la possibilité d'une classification automatique.

## Structure du projet

```text
├── data/           # Données brutes des 8 canaux EMG
├── src/            # Scripts d'analyse MATLAB
├── results/        # Figures (Signaux bruts, Segmentation, Nuages de points)
└── README.md       # Rapport technique
