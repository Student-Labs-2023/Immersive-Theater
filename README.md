# Immersive Theater

Note: Project is in active development as part of internship at Student Labs & Effective.

A working platform in the form of a mobile application for the Omsk Actor's House. The application will implement the ability to listen to the performance in Omsk in open space, as well as outside it.

### How to test
### Android
1. Install apk from here: https://disk.yandex.com/d/93UoPtqpL1GQQw
2. Insert test phone number and code (duplicated in disk's readme) if your personal number doesn't work:
    n: +7 985 865-56-56
    code: 000000
### iOS
1. Ask https://t.me/maxbushuev for testflight permission
2. Insert test phone number and code (duplicated in disk's readme) if your personal number doesn't work:
    n: +7 985 865-56-56
    code: 000000
### Libraries & Tools Used

* [Dio](https://pub.dev/packages/dio)
* [Yandex MapKit](https://pub.dev/packages/yandex_mapkit)
* [Flutter Bloc](https://pub.dev/packages/flutter_bloc) 
* [Just Audio](https://pub.dev/packages/just_audio)
* [Sliding Up Panel](https://pub.dev/documentation/sliding_up_panel/latest/)
* [Json Serialization](https://pub.dev/packages/json_serializable)



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

