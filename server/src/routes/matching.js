const router = require('express').Router();
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const { authMiddleware } = require('../middleware/auth');
const { getIO } = require('../socket/handler');

// POST /api/matching/wave — 손 흔들기
router.post('/wave', authMiddleware, async (req, res) => {
  try {
    const { receiverId } = req.body;

    // 중복 체크
    const existing = await prisma.wave.findFirst({
      where: {
        senderId: req.user.id,
        receiverId,
        status: 'pending',
      },
    });
    if (existing) return res.status(400).json({ error: '이미 손을 흔들었습니다' });

    const wave = await prisma.wave.create({
      data: { senderId: req.user.id, receiverId },
      include: { sender: { select: { nickname: true, avatarIcon: true, gradientType: true } } },
    });

    // 실시간 알림 (Socket.io)
    const io = getIO();
    io.to(`user:${receiverId}`).emit('wave:received', {
      waveId: wave.id,
      sender: wave.sender,
    });

    res.status(201).json(wave);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// PUT /api/matching/wave/:id/respond — 손 흔들기 응답
router.put('/wave/:id/respond', authMiddleware, async (req, res) => {
  try {
    const { action } = req.body; // accept, decline

    const wave = await prisma.wave.update({
      where: { id: req.params.id },
      data: {
        status: action === 'accept' ? 'accepted' : 'declined',
        respondedAt: new Date(),
      },
      include: { sender: true, receiver: true },
    });

    if (action === 'accept') {
      // 채팅방 생성
      const ids = [wave.senderId, wave.receiverId].sort();
      await prisma.chatRoom.upsert({
        where: { user1Id_user2Id: { user1Id: ids[0], user2Id: ids[1] } },
        create: { user1Id: ids[0], user2Id: ids[1] },
        update: { isActive: true },
      });

      // 미션 세션 생성
      await prisma.missionSession.create({
        data: { waveId: wave.id },
      });

      // 실시간 알림
      const io = getIO();
      io.to(`user:${wave.senderId}`).emit('wave:accepted', { waveId: wave.id });
    }

    res.json(wave);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// GET /api/matching/waves — 내 손 흔들기 내역
router.get('/waves', authMiddleware, async (req, res) => {
  const waves = await prisma.wave.findMany({
    where: {
      OR: [{ senderId: req.user.id }, { receiverId: req.user.id }],
    },
    include: {
      sender: { select: { id: true, nickname: true, avatarIcon: true, gradientType: true } },
      receiver: { select: { id: true, nickname: true, avatarIcon: true, gradientType: true } },
    },
    orderBy: { createdAt: 'desc' },
    take: 20,
  });
  res.json(waves);
});

module.exports = router;
