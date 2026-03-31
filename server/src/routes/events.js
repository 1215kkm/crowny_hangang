const router = require('express').Router();
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const { authMiddleware } = require('../middleware/auth');

// GET /api/events — 이벤트 목록
router.get('/', async (req, res) => {
  const { district, type } = req.query;
  const where = { status: { in: ['open', 'full'] } };
  if (district) where.district = district;
  if (type) where.type = type;

  const events = await prisma.event.findMany({
    where,
    include: {
      _count: { select: { participants: true } },
      participants: { take: 5, include: { user: { select: { avatarIcon: true, gradientType: true } } } },
    },
    orderBy: { startTime: 'asc' },
  });

  res.json(events.map(e => ({
    ...e,
    currentPeople: e._count.participants,
    participantAvatars: e.participants.map(p => p.user.gradientType),
  })));
});

// POST /api/events — 이벤트 생성
router.post('/', authMiddleware, async (req, res) => {
  const { title, description, icon, gradientType, type, district, location, latitude, longitude, startTime, maxPeople } = req.body;
  const event = await prisma.event.create({
    data: {
      creatorId: req.user.id, title, description, icon, gradientType, type,
      district, location, latitude, longitude,
      startTime: new Date(startTime), maxPeople,
    },
  });
  // 자동 참여
  await prisma.eventParticipant.create({ data: { eventId: event.id, userId: req.user.id } });
  res.status(201).json(event);
});

// POST /api/events/:id/join — 이벤트 참여
router.post('/:id/join', authMiddleware, async (req, res) => {
  const { rsvp = 'confirmed' } = req.body;
  const participant = await prisma.eventParticipant.create({
    data: { eventId: req.params.id, userId: req.user.id, rsvp },
  });
  res.json(participant);
});

// DELETE /api/events/:id/leave — 이벤트 나가기
router.delete('/:id/leave', authMiddleware, async (req, res) => {
  await prisma.eventParticipant.deleteMany({
    where: { eventId: req.params.id, userId: req.user.id },
  });
  res.json({ success: true });
});

module.exports = router;
