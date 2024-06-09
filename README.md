# Online Tasks

Online Tasks is a Flutter application that allows users to create tasks and save them both locally on the device and remotely in Firestore. The app integrates with Firebase and supports account creation using Gmail or traditional email and password.

## Features

- **Account Creation**: Users can create an account using their Gmail account or by providing an email and password.
- **Task Creation**: Users can create tasks which are saved in the device's local storage and in Firestore.
- **Offline Support**: When the device is offline, new tasks and changes are saved in local storage. Once the device is back online, these tasks are synced to Firestore.

## Getting Started

To get started with this project, clone the repository and install the necessary dependencies.

```bash
git clone https://github.com/yourusername/online-tasks.git
cd online-tasks
flutter pub get

## Running the App

```bash
flutter run
