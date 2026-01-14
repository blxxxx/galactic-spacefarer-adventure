# Galactic Spacefarer Adventure

A SAP Cloud Application Programming (CAP) Model project designed to manage the profiles of intergalactic spacefarers. This application provides a comprehensive system for tracking spacefarer details, skills, and organizational roles across the galaxy.

## Features

### 🚀 Spacefarer Management
- **Profile Management**: CRUD operations for Spacefarer entities.
- **Detailed Attributes**: Track attributes such as:
  - Name & Email
  - Suite Color
  - Stardust Collection Count
  - Wormhole Navigation Skill
  - Origin Planet

### 🛡️ Data Validation & Integrity
- **Input Validation**: 
  - Mandatory fields ensure data completeness.
  - **Email Format**: Strict regex-based validation for email addresses.
  - **Skill Ranges**: Wormhole Navigation Skill is validated to be within a 0-10 scale.
  - **Position Requirements**: 
    - Ensures Spacefarer meets `minStardust` and `minWormholeNavigationSkill` required for their position.
    - Validates on both **CREATE** and **UPDATE** operations.
- **Relational Data**: Strong associations between Spacefarers and their:
  - **Departments** (e.g., Exploration, Defense)
  - **Positions** (e.g., Captain, Navigator)
  - **Origin Planets**

### 💻 User Interface (Fiori Elements)
- **Draft-Enabled**: Support for draft editing states.
- **List Report**: Overview of all spacefarers with key metrics.
- **Object Page**: Detailed view separated into logical sections:
  - **General Information**: Personal and skill-based details.
  - **Job Details**: Department and Position assignments.
- **Value Helps**: Integrated dropdowns and value maps for selecting Departments, Positions, and Planets.
- **Localization**: Full i18n support for UI labels and error messages.

### 🔒 Security & Authorization
- **Authentication**: Service requires authenticated users (`@requires: 'authenticated-user'`).
- **Row-Level Security**:
  - Access to `SpaceFarer` and `Planet` entities is restricted based on the user's `originPlanet` attribute.
  - Users can only view data related to their own origin planet.

### 👤 Mock Users (for Testing)
To verify the security policies locally, use the following pre-configured mock users:
- **Alice**: 
  - **Attribute**: `originPlanet = 'EARTH'`
  - **Access**: Can only view spacefarers from Earth.
- **Bob**: 
  - **Attribute**: `originPlanet = 'MARS'`
  - **Access**: Can only view spacefarers from Mars.

## Project Structure

- `db/`: Domain models (schema definitions) and mock data (CSV).
- `srv/`
  - `intergalactic-service.cds`: Service definitions.
  - `intergalactic-service-security.cds`: Security policies.
  - `i18n/`: Localization files for UI labels and messages.
- `package.json`: Project configuration and dependencies.

## Key Technologies

- **SAP CAP (Cloud Application Programming Model)**
- **Node.js & TypeScript**
- **Fiori Elements** (UI)

## Getting Started

### Prerequisites
- Node.js
- SAP CDS DK (`npm i -g @sap/cds-dk`)

### Installation

1. Clone the repository.
2. Install dependencies:
   ```bash
   npm install
   ```

3. Initialize the SQLite database:
   ```bash
   cds deploy --to sqlite
   ```

### Running Locally

Start the local development server:

```bash
cds watch
```

- The server will start at `http://localhost:4004`.
- The application uses the local `db.sqlite` database.
- The Fiori Preview is available to test the UI.