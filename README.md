
![banner](https://github.com/Student-Labs-2023/Immersive-Theater/assets/108602792/f2f18e8b-42ec-4aed-beda-ea3f4cbecc4e)


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
- Listening performances in genre promenade with user geolocation update.
- Listening performances at home.
- Maps on main screen with control points of each performance.


## Screenshots 

### Main Screen

The screen contains two parts: list of all performances and list of bought tickets.

<img src="https://github.com/Student-Labs-2023/Immersive-Theater/assets/79749070/b5793a1f-e808-402d-a631-13165d2ddc17" height="400"> 

### Performance Description

Screeen shows various information about performance: text description, duration, location of 1st chapter, images, chapters and map overview

<img src="https://github.com/Student-Labs-2023/Immersive-Theater/assets/79749070/97de31fc-6c2f-4c32-b4db-72b9af185f5e" height="400"> 

### Location Description

This bottomsheet shows information about choosen location.

<img src="https://github.com/Student-Labs-2023/Immersive-Theater/assets/79749070/4c03785d-21f7-4b58-96e0-1d284a19f1ed" height="400"> 


### Performance Mode

|                         Chapter overview            |                    Chapter switch example                   |
|:----------------------------------------------------------:|:------------------------------------------------------------:|
| <img src="https://github.com/Student-Labs-2023/Immersive-Theater/assets/79749070/5a3625b2-dd03-485c-acee-e802cdfebc87" height="400">  | <img src="https://github.com/Student-Labs-2023/Immersive-Theater/assets/79749070/12b4fb62-e94c-4e25-a2be-dd0e2481dd27" height="400"> |

### First-run Ondoarding 
<img src="https://github.com/Student-Labs-2023/Immersive-Theater/assets/79749070/28cb64d4-57cb-481e-8962-7c121c7d566f" height="400"> 
<img src="https://github.com/Student-Labs-2023/Immersive-Theater/assets/79749070/7b282137-7178-46b1-a378-eb89a4d7b41d" height="400">
<img src="https://github.com/Student-Labs-2023/Immersive-Theater/assets/79749070/0685243e-ebc8-4e0a-90a5-bf645ee9a3e6" height=400>



### Onboarding before performance and route planning

|                         Onboarding -> performance mode            |                    Route planning                   |
|:----------------------------------------------------------:|:------------------------------------------------------------:|
| <img src="https://github.com/Student-Labs-2023/Immersive-Theater/assets/79749070/832b8707-f6df-4713-ac4d-aba564a7e281" height="400">  | <img src="https://github.com/Student-Labs-2023/Immersive-Theater/assets/79749070/02c15477-c825-4db6-9d3e-be13344f5828" height="400"> |

