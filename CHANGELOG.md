# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Custom theme with brand colors (pink background, black/white accents)
- BrandingLogo widget with silhouettes of women workers
- App name: "Maria Vai Com As Outras"
- Subtitle: "Reformas para Mulheres"
- Slogan: "Não vá sozinha, vá com as outras!"
- AppTheme class with centralized color scheme
- Dark theme support
- Material Design 3 components with custom styling

### Changed
- Updated app description in pubspec.yaml
- Applied brand colors to login page
- Replaced generic icon with custom branding logo
- Enhanced button and input field styling
- Improved typography with Google Fonts (Poppins)

### Design System
- Primary Pink: #FADADD (background)
- Primary Black: #000000 (banner/accent)
- Primary White: #FFFFFF (text)
- Secondary Pink: #E8A0B8 (actions)
- Accent Pink: #FF69B4 (highlights)

## [1.2.0] - 2026-08-28

### Changed
- **BREAKING**: Moved to Cloud Functions with bcrypt for authentication
- **BREAKING**: Now uses non-default Firestore database (mariavaidb)
- **BREAKING**: Removed Firebase Authentication Email/Password provider
- Passwords are now hashed with bcrypt on server-side
- Admin access code is now validated via Cloud Functions
- Removed gender field from User entity
- Removed custom auth service files (replaced with Cloud Functions)
- Updated FIREBASE_SETUP.md with new authentication flow
- Updated README.md to reflect new architecture

### Security Improvements
- Server-side password hashing with bcrypt (cost 12)
- Separate users_private collection for sensitive data
- Rate limiting on login attempts (5 attempts = 15 min lockout)
- Admin access code stored as Firebase Function secret
- No password storage in client-readable collections

### Technical Changes
- Added cloud_functions dependency
- Removed bcrypt from client (moved to server)
- Updated auth_service.dart to use Custom Tokens
- Updated firestore_service.dart for non-default database
- Simplified User entity (removed gender field)
- Updated registration flow (admin code validated server-side)

## [1.1.0] - 2026-08-28

### Added
- Quotation request page for clients
- Quotations page for providers (available/accepted tabs)
- Gender field in User entity for female professional filter
- ServiceStatus.quotation for quotation phase
- Gender selection in provider registration
- CI/CD pipeline with GitHub Actions
- Semantic versioning scripts (release.sh, release.ps1)
- Firebase Console setup documentation
- Test user creation scripts (Python and Dart)

### Changed
- Updated Firebase packages to modern versions
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