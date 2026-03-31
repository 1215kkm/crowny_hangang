const router = require('express').Router();
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const { authMiddleware } = require('../middleware/auth');

// GET /api/chat/rooms — 내 채팅방 목록
router.get('/rooms', authMiddleware, async (req, res) => {
  const rooms = await prisma.chatRoom.findMany({
    where: {
      OR: [{ user1Id: req.user.id }, { user2Id: req.user.id }],
      isActive: true,
    },
    include: {
      user1: { select: { id: true, nickname: true, avatarIcon: true, gradientType: true } },
      user2: { select: { id: true, nickname: true, avatarIcon: true, gradientType: true } },
      messages: { orderBy: { createdAt: 'desc' }, take: 1 },
    },
    orderBy: { createdAt: 'desc' },
  });

  const result = rooms.map(r => {
    const partner = r.user1Id === req.user.id ? r.user2 : r.user1;
    return {
      id: r.id,
      partner,
      lastMessage: r.messages[0] || null,
      isActive: r.isActive,
    };
  });

  res.json(result);
});

// GET /api/chat/rooms/:id/messages — 채팅 메시지 조회
router.get('/rooms/:id/messages', authMiddleware, async (req, res) => {
  const { cursor, limit = 50 } = req.query;
  const where = { roomId: req.params.id };
  if (cursor) where.createdAt = { lt: new Date(cursor) };

  const messages = await prisma.chatMessage.findMany({
    where,
    include: { sender: { select: { id: true, nickname: true, avatarIcon: true } } },
    orderBy: { createdAt: 'desc' },
    take: parseInt(limit),
  });

  res.json(messages.reverse());
});

// POST /api/chat/rooms/:id/messages — 메시지 전송 (REST 폴백, 주로 Socket.io 사용)
router.post('/rooms/:id/messages', authMiddleware, async (req, res) => {
  const { content, type = 'text' } = req.body;
  const message = await prisma.chatMessage.create({
    data: {
      roomId: req.params.id,
      senderId: req.user.id,
      content,
      type,
    },
    include: { sender: { select: { id: true, nickname: true, avatarIcon: true } } },
  });
  res.status(201).json(message);
});

module.exports = router;
