
# 📋 Task Manager – Ruby on Rails 8

Une application de gestion de tâches développée dans le cadre d’un exercice technique Ruby on Rails.  
A simple task management application built as part of a Ruby on Rails technical assessment.

---

## 🚀 Fonctionnalités principales / Core Features

- Création, édition et suppression de **listes de tâches**  
  Create, edit, and delete **task lists**
- Ajout, édition, suppression de **tâches** dans chaque liste  
  Add, edit, delete **tasks** within each list
- Marquage des tâches comme **terminées / non terminées**  
  Mark tasks as **complete / incomplete**
- Vue d’ensemble sur la page d’accueil : *X tâches complétées sur Y*  
  Homepage shows task completion summary: *X completed out of Y*
- Filtrage des tâches dans une liste : *toutes / complétées / non complétées*  
  Filter tasks in a list: *all / completed / incomplete*
- Empêche la suppression d’une liste si elle contient des tâches incomplètes  
  Prevent list deletion if it contains incomplete tasks
- Scopes ActiveRecord et méthodes personnalisées (ex : `percent_complete`)  
  ActiveRecord scopes and custom methods (e.g., `percent_complete`)
- Flash messages et validations avec affichage des erreurs  
  Flash messages and validation error handling

---

## 🧱 Stack technique / Technical Stack

- **Ruby** : ≥ 3.2  
- **Rails** : 8.0.1  
- **Base de données / Database** : PostgreSQL (`pg`)
- **Serveur web / Web server** : Puma
- **Pipeline d’assets / Asset pipeline** : Propshaft, Importmap
- **Frontend** : Turbo / Stimulus / CSS Bundling
- **Outils de développement / Dev tools** :
  - `pry-byebug` pour le debugging / for debugging
  - `brakeman` pour la sécurité / for security scanning
  - `rubocop-rails-omakase` pour le linting / for code linting

---

## ⚙️ Installation & Lancement / Setup & Run

### 1. Cloner le dépôt / Clone the repository

```bash
git clone https://github.com/your-account/task-manager.git
cd task-manager
```

### 2. Installer les dépendances / Install dependencies

```bash
bundle install
```

### 3. Configurer la base PostgreSQL / Configure PostgreSQL database

Créez un fichier `.env` ou configurez les variables d’environnement selon votre système.  
Create a `.env` file or configure environment variables if needed.

```bash
rails db:create db:migrate db:seed
```

### 4. Lancer le serveur / Start the server

```bash
bin/dev
```

Ou / Or:

```bash
rails server
```

Puis ouvrez / Then open: [http://localhost:3000](http://localhost:3000)

---

## 📁 Structure & conventions / Structure & Conventions

- **MVC classique** avec relations imbriquées  
  Classic **MVC** with nested associations (`has_many`, `belongs_to`)
- **Routes imbriquées** : `/lists/:list_id/tasks`  
  **Nested routes**: `/lists/:list_id/tasks`
- **Formulaires DRY** avec partials  
  **DRY forms** using Rails helpers and partials
- **Feedback utilisateur** via flash messages et validations  
  **User feedback** through flash messages and validation errors

---

## 🎯 Bonus techniques (optionnels) / Optional Bonus Features

- Enum pour priorité de tâche (`low`, `medium`, `high`)  
  Enum for task priority (`low`, `medium`, `high`)
- Formulaire imbriqué pour créer une liste et ses tâches  
  Nested form to create a list and its first tasks at once
- Optimisation SQL (évite les requêtes N+1)  
  SQL optimization (avoids N+1 queries with `includes`)

---

## 📝 À propos de l’exercice / About the Exercise

Ce projet a été développé pour démontrer la compréhension des conventions Ruby on Rails :  
This project was built to demonstrate understanding of Ruby on Rails conventions:

- Associations, validations, scopes, callbacks
- Code organisation claire / Clean code organization
- UX minimale (flash, erreurs) / Minimal user experience design
- Optimisation des requêtes / Query optimization

---

Merci pour votre attention 🙏  
Thanks for reading 🙏
