![](assets/banner.png)


Note: Flutter project is in active development as part of internship at Student Labs & Effective.

A working platform in the form of a mobile application for the Omsk Actor's House. The application will implement the ability to listen to the performance in Omsk in open space, as well as outside it.



## Getting Started
Clone the repo and follow these steps to setup the project.

### Environment
Dart 2.19.2 or greater, but lesser 3.0.0 and Flutter 3 or greater is required.

[Follow this guide to setup your flutter environment](https://docs.flutter.dev/get-started/install) based on your platform.

### Flutter
First and foremost make sure you have Flutter 3 setup on your system. 
You can check the version by running
```bash
flutter --version
```
You should see output similar to this. Check if the version is `3.x.x`.
```bash
Flutter 3.7.5 • channel stable • https://github.com/flutter/flutter.git
Framework • revision c07f788888 (6 months ago) • 2023-02-22 17:52:33 -0600
Engine • revision 0f359063c4
Tools • Dart 2.19.2 • DevTools 2.20.1
```
Run this command to update flutter to the latest version
```bash
flutter upgrade
```
## Build 

### iOS

Run this command to build ipa
```bash
flutter build ipa --no-tree-shake-icons
```

### Android

Run this command to build apk
```bash
flutter build apk --no-tree-shake-icons
```


## Major Dependencies

* Network - [Dio](https://pub.dev/packages/dio)
* Maps - [Yandex MapKit](https://pub.dev/packages/yandex_mapkit)
* State Management - [Flutter Bloc](https://pub.dev/packages/flutter_bloc) 
* Playback Audio - [Just Audio](https://pub.dev/packages/just_audio)
* Custom Bottom Sheet [Sliding Up Panel](https://pub.dev/documentation/sliding_up_panel/latest/)
* Detecting geolocation - [Geolocator](https://pub.dev/packages/geolocator)
* Stream extensions - [RxDart](https://pub.dev/packages/rxdart)


## Features 

- Onboarding
- Phone Number Authentification with [Firebase](https://firebase.flutter.dev/docs/overview/)
- Maps on main screen with control points of each performance.
- Listening performances in genre promenade with user geolocation update.
- Listening performances at home.



## Features Demo 

### Onboarding screens

Info about this application.

<img src="https://github.com/Student-Labs-2023/Immersive-Theater/assets/108602792/ed6468dc-b5e0-42ba-823b-a4a58a45de49" height="400"> 

### Login and verification screens

Phone number authentification with test data.

<img src="https://github.com/Student-Labs-2023/Immersive-Theater/assets/108602792/426bb6d4-5044-4b84-aee9-05a8e7e23d8f" height="400"> 


### Main Screen

The screen contains two parts: list of all performances and list of bought tickets. Placemarks on the map contain info about control points of performances route.

<img src="https://github.com/Student-Labs-2023/Immersive-Theater/assets/108602792/0eb6b560-9b54-4f18-b443-57746be77899" height="400"> 

### Detailed Performance Screen

Detailed information contains description, duration, location of 1st chapter, images, chapters and route of performance.

<img src="https://github.com/Student-Labs-2023/Immersive-Theater/assets/108602792/f079dc9c-c260-42b7-b8c3-fdb79ffc9e5a" height="400"> 


### Introduction To Performance Mode

Information about right way of listening performance.

<img src="https://github.com/Student-Labs-2023/Immersive-Theater/assets/108602792/dffbcd00-bcc5-4889-8190-3c431686ffdd" height="400"> 

### Performance Mode At Home

Auto playback when chapter ended.

<img src="https://github.com/Student-Labs-2023/Immersive-Theater/assets/108602792/b21be364-ab4e-4fa9-b9d3-7b7fe0bd4f28" height="400"> 


### Performance Mode Along The Route

New chapter starts when user on the place and current chapter ended.

<img src="https://github.com/Student-Labs-2023/Immersive-Theater/assets/108602792/88a91c45-3f53-4ffa-ac8d-9ea30d191478" height="400"> 

## Project Demo



[![Video](https://img.youtube.com/vi/70d7AhSQMmY/maxresdefault.jpg)](https://www.youtube.com/watch?v=70d7AhSQMmY)



