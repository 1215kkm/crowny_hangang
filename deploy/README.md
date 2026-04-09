# 배포 가이드

## 1. 카페24 VPS 서버 세팅

```bash
# SSH 접속
ssh root@your-server-ip

# Node.js 설치 (v18+)
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt install -y nodejs

# PostgreSQL 설치
apt install -y postgresql postgresql-contrib
sudo -u postgres createdb crowny_hangang

# Redis 설치
apt install -y redis-server
systemctl enable redis-server

# PM2 설치
npm install -g pm2

# SSL 인증서 (Let's Encrypt)
apt install -y certbot
certbot certonly --standalone -d your-domain.com
```

## 2. 서버 배포

```bash
# 코드 클론
git clone https://github.com/1215kkm/crowny_hangang.git
cd crowny_hangang/server

# 의존성 설치
npm install

# 환경변수 설정
cp .env.example .env
# .env 파일에 DB URL, Firebase 키 등 입력

# DB 마이그레이션
npx prisma migrate deploy

# PM2로 실행
pm2 start src/app.js --name crowny-server
pm2 save
pm2 startup
```

## 3. Flutter Web 배포

```bash
# Flutter 빌드
cd flutter
flutter build web

# 빌드 결과물을 서버에 업로드
scp -r build/web/* root@your-server-ip:/var/www/crowny/

# Nginx 설정 (또는 Express에서 정적 파일 서빙)
```

## 4. Flutter 모바일 빌드

```bash
# Android APK
flutter build apk --release

# iOS (Mac 필요)
flutter build ios --release

# 결과물
# build/app/outputs/flutter-apk/app-release.apk
# build/ios/ipa/
```

## 5. 화이트라벨 — 주제 변경 배포

```bash
# 1. 새 주제 설정 파일 작성
cp config/themes/hangang.json config/themes/haeundae.json
# haeundae.json 편집 (앱이름/지역/카테고리 등)

# 2. 지도 SVG + 홈 배경이미지 교체
# config/assets/haeundae/ 폴더에 추가

# 3. main.dart에서 테마 변경
# AppConfig.load(theme: 'haeundae');

# 4. 빌드 + 배포
flutter build web
flutter build apk
```

## 6. 비용 요약

| 항목 | 월 비용 |
|------|---------|
| 카페24 VPS (2코어/4GB) | ₩11,000~22,000 |
| 도메인 (.com) | ₩12,000/년 |
| Firebase Auth + FCM | 무료 |
| 카카오맵 API | 무료 (일 30만건) |
| SSL 인증서 | 무료 (Let's Encrypt) |
| **합계** | **약 ₩15,000~25,000/월** |
