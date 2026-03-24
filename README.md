#  GuideMe — L'Uber des guides touristiques locaux
**GuideMe** est une application mobile Flutter née d'un projet sur l'uberisation des services. L'idée est simple : permettre à n'importe quel touriste de trouver un guide local indépendant en quelques clics.

##  Le Concept

Trouver un bon guide local est souvent un casse-tête (prix opaques, disponibilité incertaine, barrière de la langue). 
Cette plateforme connecte deux types d'utilisateurs :
* **Le Touriste :** Cherche un guide selon son budget, sa langue et sa destination.
* **Le Guide :** Propose ses services, gère ses réservations et valide ses prestations.

---

##  Architecture & Clean Code
**Frontend :**
```text
lib/
├── core/                # Global utilities, configs and services
├── features/
│   ├── auth/            # Authentication feature
│   ├── guides/          # Tourist guide feature
│   │   ├── data/        # Mock data sources
│   │   ├── domain/      # Entities and business models
│   │   └── presentation/# UI pages and widgets
│   ├── booking/         # Guide reservation
│   ├── payment/         # Payment simulation
│   └── reviews/         # Guide rating system
└── shared/              # Shared UI components
```
### Structure du projet :
* **`core/`** : Configuration globale, thèmes et services partagés.
* **`features/`** : Le cœur de l'app découpé par fonctionnalités (Auth, Booking, Guides, Payment, Reviews). Chaque feature possède ses propres couches *Data*, *Domain* et *Presentation*.
* **`shared/`** : Composants UI réutilisables (boutons, cartes, champs de saisie).

**Stack technique :**
* **Framework :** Flutter 
* **State Management :** Bloc / Flutter Bloc
* **Navigation :** GoRouter
* **Données :** Utilisation de sources "Mock" pour valider le flux utilisateur complet.

---
**Backend :**
Architecture RESTful avec Spring Boot, organisée en couches :

```
src/main/java/com/touristguide/
├── config/              # Configuration Spring (Sécurité, DataSeeder)
├── features/            # Fonctionnalités métier
│   ├── auth/            # Authentification
│   │   ├── controller/  # Endpoints REST
│   │   ├── dto/         # Objets de transfert de données
│   │   ├── model/       # Entités JPA
│   │   ├── repository/  # Accès aux données
│   │   └── service/     # Logique métier
│   ├── booking/         # Réservations
│   ├── guides/          # Gestion des guides
│   ├── payment/         # Paiements
│   └── reviews/         # Avis et évaluations
├── security/            # Sécurité (JWT, filtres)
│   ├── filters/         # Filtres de sécurité
│   └── jwt/             # Gestion des tokens JWT
├── shared/              # Utilitaires partagés
│   ├── exception/       # Gestion des exceptions
│   └── response/        # Réponses API standardisées
└── TouristGuideApplication.java  # Classe principale
```
- **Couches :** Controller (présentation), Service (logique métier), Repository (accès données), Model (entités)
- **Base de données :** MySQL avec Spring Data JPA
- **Sécurité :** Spring Security avec JWT
- **Configuration :** application.properties

---
- **Framework :** Spring Boot 3.2.5
- **Java :** Version 17
- **Build :** Maven
- **Sécurité :** Spring Security
- **Base de données :** Spring Data JPA avec MySQL
- **Validation :** Bean Validation

--- 

##  Fonctionnalités du MVP

### Côté Voyageur :
- [x] Inscription et connexion sécurisée.
- [x] Recherche multicritères (Destination, Budget, Langue).
- [x] Consultation des profils détaillés des guides.
- [x] Réservation en temps réel et simulation de paiement.
- [x] Système d'évaluation (avis et notes) après la prestation.

### Côté Guide :
- [x] Réception et gestion des demandes de réservation.
- [x] Validation de la fin de mission.
- [x] Suivi simplifié des revenus (simulation).

---

## Installation et Configuration

### Clonage du projet
```bash
git clone <url-du-repo>
cd Mobile_dev_project
```

### Configuration de la base de données
1. Installer MySQL
2. Créer une base de données : `tourist_guide`
3. Configurer les credentials dans `application.properties` (backend)

---

## Démarrage du Frontend (Flutter)

1. Aller dans le dossier frontend :
   ```bash
   cd frontend/flutter_final
   ```

2. Installer les dépendances :
   ```bash
   flutter pub get
   ```

3. Générer les fichiers de code (si nécessaire) :
   ```bash
   flutter pub run build_runner build
   ```

4. Lancer l'application :
   - Pour Android :
     ```bash
     flutter run
     ```
   - Pour iOS (sur macOS) :
     ```bash
     flutter run --platform ios
     ```
   - Pour le web :
     ```bash
     flutter run --platform web
     ```

L'application se lance sur l'émulateur ou l'appareil connecté.

---

## Démarrage du Backend (Spring Boot)

1. Aller dans le dossier backend :
   ```bash
   cd tourist-guide-backend\5\tourist-guide-backend
   ```

2. Configurer la base de données dans `src/main/resources/application.properties` :
   ```properties
   spring.datasource.url=jdbc:mysql://localhost:3306/tourist_guide
   spring.datasource.username=votre_username
   spring.datasource.password=votre_password
   ```

3. Compiler et lancer :
   ```bash
   mvn clean install
   mvn spring-boot:run
   ```

Le serveur démarre sur `http://localhost:8080`.

---
## Objectif du projet

Ce projet démontre comment une interface mobile peut transformer un service traditionnel en une marketplace dynamique. L'objectif était de simplifier l'interaction humaine tout en garantissant une structure technique solide et prête pour une mise en production réelle (intégration backend).


