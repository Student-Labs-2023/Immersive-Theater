# Immersive Theater

Note: Project is in active development as part of internship at Student Labs & Effective.

A working platform in the form of a mobile application for the Omsk Actor's House. The application will implement the ability to listen to the performance in Omsk in open space, as well as outside it.

### How to Use

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/effectivemade/labs-shebalin-flutter-app.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies: 

```
flutter pub get 
```
**Step 3:**

Add api key for yandex_mapkit and base url to .env: 

```
BASE_URL=PASTE_BASE_URL
API_KEY=PASTE_API_KEY
```


### Libraries & Tools Used

* [Dio](https://pub.dev/packages/dio)
* [Yandex MapKit](https://pub.dev/packages/yandex_mapkit)
* [Flutter Bloc](https://pub.dev/packages/flutter_bloc) 
* [Just Audio](https://pub.dev/packages/just_audio)
* [Sliding Up Panel](https://pub.dev/documentation/sliding_up_panel/latest/)
* [Json Serialization](https://pub.dev/packages/json_serializable)
* [Provider](https://pub.dev/packages/provider)
* [Cloud firestore](https://pub.dev/packages/cloud_firestore)
* [Flutter BLoC](https://pub.dev/packages/flutter_bloc)
* [Carousel Slider](https://pub.dev/packages/carousel_slider)
* [Geolocator](https://pub.dev/packages/geolocator)
* [RxDart](https://pub.dev/packages/rxdart)
* [Cached Network Image](https://pub.dev/packages/cached_network_image)
# Features 

### Main Screen

The screen contains two parts: list of performances and list tickets.

<img src="/assets/main_screen.png" height="400"> 

### Performance Description

Screeen shows everything about performance.

<img src="/assets/info_performance.png" height="400"> 

### Location Description

Bottomsheet shows info of choosen location.

<img src="/assets/info_location.png" height="400"> 

### Performance Mode

|                         Audio In Progress             |                    Audio of location finished                   |
|:----------------------------------------------------------:|:------------------------------------------------------------:|
| <img src="/assets/mode_performance.png" height="400">  | <img src="/assets/audio_finish.png" height="400"> |

