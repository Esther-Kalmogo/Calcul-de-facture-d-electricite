# Wattly

Application mobile Flutter permettant de calculer, suivre et historiser sa consommation électrique, en se basant sur les relevés réels du compteur (ancien/nouvel indice) et les tarifs en vigueur au Maroc.

## Contexte du projet

Wattly est né d'une méthode manuelle utilisée pour estimer une facture d'électricité avant même de recevoir le relevé officiel : à partir de l'ancien et du nouvel indice du compteur, on peut calculer précisément la consommation et anticiper le montant à payer. Ce projet formalise cette méthode dans une application mobile.

Projet réalisé dans le cadre de ma formation en Licence Informatique Appliquée, 2ème année.

## Fonctionnalités

- **Facture réelle** : calcul de la facture à partir des indices du compteur (ancien → nouvel indice), avec :
  - Application des tranches tarifaires progressives (ONEE)
  - Calcul des taxes (TVA, TPPAN), calibré sur une facture réelle
  - Validation des saisies (champs vides, valeurs invalides, indices incohérents)
- **Historique** : liste de toutes les factures enregistrées, mise à jour automatique en temps réel
- **Profil utilisateur** : formulaire local (nom, email, ville), sans compte en ligne, données stockées uniquement sur l'appareil

## Stack technique

- **Flutter / Dart** — framework de développement mobile
- **Hive** — base de données locale (NoSQL, légère, stockage persistant sur l'appareil)

## Méthodologie de calcul

Les tarifs par tranche et le taux de taxes appliqués ont été **calibrés et vérifiés à partir d'une vraie facture** (SRM-CS, Casablanca-Settat), afin de rester le plus proche possible de la réalité, sans prétendre à une précision officielle à 100%.

## Captures d'écran

*(à ajouter)*

## Installation

```bash
git clone https://github.com/Esther-Kalmogo/Calcul-de-facture-d-electricite.git
cd Calcul-de-facture-d-electricite
flutter pub get
flutter run
```

## Pistes d'évolution

- Prédiction de la prochaine facture à partir de l'historique
- Mode électricité prépayée 
- Extension au suivi de la consommation d'eau
- Export PDF de l'historique

## Auteur

Esther Kalmogo — Étudiante en Licence Informatique Appliquée
