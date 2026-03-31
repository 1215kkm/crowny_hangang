const router = require('express').Router();
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const { authMiddleware } = require('../middleware/auth');

// GET /api/users/nearby — 근처 사용자 조회 (폴링)
router.get('/nearby', authMiddleware, async (req, res) => {
  try {
    const { district, lat, lng, radius = 500 } = req.query;
    const me = req.user;

    // 차단 목록 조회
    const blocks = await prisma.block.findMany({
      where: { OR: [{ blockerId: me.id }, { blockedId: me.id }] },
    });
    const blockedIds = blocks.map(b => b.blockerId === me.id ? b.blockedId : b.blockerId);

    const where = {
      id: { not: me.id, notIn: blockedIds },
      isOnline: true,
    };
    if (district) where.district = district;

    const users = await prisma.user.findMany({
      where,
      select: {
        id: true, nickname: true, avatarIcon: true, gradientType: true,
        activity: true, activityLabel: true, statusMessage: true,
        district: true, latitude: true, longitude: true,
        trustLevel: true, hangangTemp: true, languages: true,
        meetupCount: true, isOnline: true,
      },
      take: 50,
    });

    // 거리 계산 (간단한 유클리드 — 실서비스에서는 PostGIS ST_Distance 사용)
    const myLat = parseFloat(lat) || me.latitude || 37.5283;
    const myLng = parseFloat(lng) || me.longitude || 126.9346;
    const withDistance = users.map(u => ({
      ...u,
      distanceMeters: Math.round(
        Math.sqrt(Math.pow((u.latitude - myLat) * 111000, 2) + Math.pow((u.longitude - myLng) * 88000, 2))
      ),
    })).filter(u => u.distanceMeters <= parseInt(radius))
      .sort((a, b) => a.distanceMeters - b.distanceMeters);

    res.json(withDistance);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// PUT /api/users/location — 위치 업데이트
router.put('/location', authMiddleware, async (req, res) => {
  try {
    const { latitude, longitude, district, activity, activityLabel, statusMessage } = req.body;
    const user = await prisma.user.update({
      where: { id: req.user.id },
      data: {
        latitude, longitude, district,
        activity, activityLabel, statusMessage,
        isOnline: true,
        lastSeenAt: new Date(),
      },
    });
    res.json(user);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// GET /api/users/me — 내 프로필
router.get('/me', authMiddleware, async (req, res) => {
  const user = await prisma.user.findUnique({
    where: { id: req.user.id },
    include: {
      mannerTagsReceived: true,
      _count: { select: { boardPosts: true, sentWaves: true } },
    },
  });
  res.json(user);
});

// PUT /api/users/me — 프로필 수정
router.put('/me', authMiddleware, async (req, res) => {
  const { nickname, oneLiner, avatarIcon, gradientType, languages } = req.body;
  const data = {};

  // 별명 변경 (주 1회)
  if (nickname && nickname !== req.user.nickname) {
    const lastChange = req.user.lastNicknameChange;
    if (lastChange) {
      const daysSince = (Date.now() - lastChange.getTime()) / (1000 * 60 * 60 * 24);
      if (daysSince < 7) {
        return res.status(400).json({ error: '별명은 주 1회만 변경할 수 있습니다' });
      }
    }
    data.nickname = nickname;
    data.lastNicknameChange = new Date();
  }

  if (oneLiner !== undefined) data.oneLiner = oneLiner;
  if (avatarIcon) data.avatarIcon = avatarIcon;
  if (gradientType) data.gradientType = gradientType;
  if (languages) data.languages = languages;

  const user = await prisma.user.update({ where: { id: req.user.id }, data });
  res.json(user);
});

// PUT /api/users/offline — 오프라인 전환
router.put('/offline', authMiddleware, async (req, res) => {
  await prisma.user.update({
    where: { id: req.user.id },
    data: { isOnline: false, lastSeenAt: new Date() },
  });
  res.json({ success: true });
});

module.exports = router;
