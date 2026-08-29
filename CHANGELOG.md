# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Firebase integration (Authentication, Firestore, Storage, Cloud Messaging)
- User registration for clients, providers, and admins
- Panic button with GPS and emergency services integration
- Payment system with 20% commission calculation
- Admin dashboard with real-time monitoring
- Provider interface with job management
- Client interface with service categories
- Firebase security rules configuration
- CI/CD pipeline with GitHub Actions

### Changed
- Updated Firebase packages to modern versions (firebase_core ^3.0.0)
- Improved error handling for Firebase initialization
- Added timeout for Firebase Messaging initialization
- Updated connectivity_plus to version 6.0.0

### Fixed
- Firebase web compatibility issues with modern Dart SDK
- Navigation routing for user registration

## [1.0.0] - 2026-08-28

### Added
- Initial project setup with Flutter
- Basic UI components for login and dashboard
- Clean Architecture structure
- Mock payment service
- Panic button UI (without backend integration)
- Admin, client, and provider interfaces
- Material Design 3 theme with pink color scheme

### Infrastructure
- GitHub repository setup
- Basic project structure
- Core routing configuration