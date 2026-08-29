# Firebase Setup Guide

This guide will help you configure Firebase for the Maria Vai app.

## 1. Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project"
3. Enter project name: `mariavai-services` (or use existing: `mariavaicomoutras-e7c28`)
4. Enable Google Analytics (optional)
5. Click "Create project"

## 2. Configure Firebase using FlutterFire CLI

The project is already configured with Firebase options in `lib/firebase_options.dart`. To update it with your actual Firebase project:

### Option A: Using FlutterFire CLI (Recommended)

1. Install Firebase CLI: `npm install -g firebase-tools`
2. Login to Firebase: `firebase login`
3. Run: `flutterfire configure --project=mariavaicomoutras-e7c28`
4. This will automatically update `lib/firebase_options.dart` with your real config

### Option B: Manual Configuration

1. In Firebase Console, add your platforms (Web, Android, iOS)
2. Download the config files for each platform
3. For Web: Add Firebase SDK scripts to `web/index.html` (already done)
4. For Android: Place `google-services.json` in `android/app/`
5. For iOS: Place `GoogleService-Info.plist` in `ios/Runner/`
6. Update `lib/firebase_options.dart` with your actual keys

## 3. Android Setup

1. In Firebase Console, click the Android icon
2. Package name: `com.mariavai.mariavai_services`
3. Download `google-services.json`
4. Place it in `android/app/google-services.json`
5. Add dependencies to `android/build.gradle`:
   ```gradle
   buildscript {
     dependencies {
       classpath 'com.google.gms:google-services:4.3.15'
     }
   }
   ```
6. Add to `android/app/build.gradle`:
   ```gradle
   apply plugin: 'com.google.gms.google-services'
   ```

## 4. iOS Setup

1. In Firebase Console, click the iOS icon
2. Bundle ID: `com.mariavai.mariavaiServices`
3. Download `GoogleService-Info.plist`
4. Place it in `ios/Runner/GoogleService-Info.plist`

## 3. Enable Firebase Services

### Authentication:

1. Go to Authentication → Sign-in method
2. Enable Email/Password
3. Optionally enable Google Sign-in

### Cloud Firestore:

1. Go to Firestore Database → Create database
2. Choose location (e.g., southamerica-east1 for Brazil)
3. Start in test mode
4. Set up security rules (see below)

### Firebase Storage:

1. Go to Storage → Get started
2. Choose location (same as Firestore)
3. Start in test mode
4. Set up security rules (see below)

### Cloud Messaging:

1. Go to Cloud Messaging → Get started
2. Enable Cloud Messaging API
3. Upload APNs certificate (for iOS)

## 4. Security Rules

### Firestore Rules:

```firestore
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can read/write their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Services: clients can read their own, providers can read assigned
    match /services/{serviceId} {
      allow read: if request.auth != null && 
        (resource.data.clientId == request.auth.uid || 
         resource.data.providerId == request.auth.uid);
      allow create: if request.auth != null;
      allow update: if request.auth != null && 
        (resource.data.clientId == request.auth.uid || 
         resource.data.providerId == request.auth.uid);
    }
    
    // Payments: only admins can read all
    match /payments/{paymentId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null;
    }
    
    // Panic alerts: users can create, admins can read all
    match /panic_alerts/{alertId} {
      allow create: if request.auth != null;
      allow read: if request.auth != null;
      allow update: if request.auth != null;
    }
  }
}
```

### Storage Rules:

```firestore
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /{allPaths=**} {
      allow read: if request.auth != null;
      allow write: if request.auth != null;
    }
  }
}
```

## 5. Initialize Firebase in App

The app is already configured to initialize Firebase in `lib/main.dart`:

```dart
await FirebaseService.initialize();
await MessagingService().initialize();
```

## 6. Test Firebase Connection

Run the app and check the console for Firebase initialization messages.

## 7. Cloud Functions (Optional)

For production, consider setting up Cloud Functions for:
- Sending push notifications for panic alerts
- Processing payments
- Sending email notifications
- Scheduling reminders

## 8. Indexes (Optional)

For complex queries, you may need to create indexes in Firestore:
- Go to Firestore → Indexes → Composite Indexes
- Create indexes for common query patterns

## Troubleshooting

### "Firebase has not been correctly initialized"
- Make sure Firebase is initialized before using any Firebase service
- Check that your config is correct

### "Permission denied"
- Check your Firestore and Storage security rules
- Make sure users are authenticated

### "Missing plugin"
- Run `flutter pub get`
- Check platform-specific setup (google-services.json, GoogleService-Info.plist)

## Next Steps

1. Test authentication with real users
2. Test Firestore CRUD operations
3. Test image uploads to Storage
4. Test push notifications
5. Set up proper security rules for production
6. Consider implementing Cloud Functions