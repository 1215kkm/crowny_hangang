# Crowny 한강 - 프로젝트 설정 가이드

## 1. Flutter 프로젝트 생성

이 프로젝트는 `lib/` 코드만 포함되어 있습니다.
Flutter 프로젝트를 생성한 후 `lib/` 폴더를 교체하세요.

```bash
# Flutter 프로젝트 생성
flutter create crowny_hangang_app
cd crowny_hangang_app

# 기존 lib/ 삭제 후 교체
rm -rf lib/
cp -r ../crowny_hangang/flutter/lib/ lib/
cp ../crowny_hangang/flutter/pubspec.yaml pubspec.yaml
cp -r ../crowny_hangang/flutter/assets/ assets/

# 의존성 설치
flutter pub get
```

## 2. 카카오맵 설정

### 카카오 개발자 등록
1. https://developers.kakao.com/ 접속
2. 애플리케이션 추가
3. JavaScript 키 복사

### 키 설정
`lib/services/map_service.dart` 에서:
```dart
static const String kakaoMapKey = 'YOUR_KAKAO_MAP_JAVASCRIPT_KEY';
```
를 발급받은 키로 교체

### Android 설정
`android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>

<application>
  <meta-data
    android:name="com.kakao.sdk.AppKey"
    android:value="YOUR_KAKAO_NATIVE_APP_KEY"/>
</application>
```

### iOS 설정
`ios/Runner/Info.plist`:
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>한강에서 근처 사용자를 찾기 위해 위치 정보가 필요합니다</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>한강에서 근처 사용자를 찾기 위해 위치 정보가 필요합니다</string>
```

## 3. Firebase Auth 설정 (나중에)

1. Firebase 프로젝트 생성
2. 카카오/구글/Apple 로그인 설정
3. `google-services.json` (Android) / `GoogleService-Info.plist` (iOS) 추가

## 4. 실행

```bash
flutter run
```

## 5. 커머스 숨기기 (나중에)

커머스 기능을 숨기려면:
1. `lib/main.dart`에서 `/commerce` 라우트 주석 처리
2. `lib/screens/home/home_screen.dart`에서 "한강 주문" 배너 주석 처리
