const router = require('express').Router();
const admin = require('../config/firebase');
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

// POST /api/auth/register — 회원가입 (Firebase 토큰으로)
router.post('/register', async (req, res) => {
  try {
    const token = req.headers.authorization?.replace('Bearer ', '');
    const decoded = await admin.auth().verifyIdToken(token);

    const existing = await prisma.user.findUnique({ where: { firebaseUid: decoded.uid } });
    if (existing) {
      return res.json({ user: existing, isNew: false });
    }

    const { nickname, language } = req.body;
    const user = await prisma.user.create({
      data: {
        firebaseUid: decoded.uid,
        nickname: nickname || `한강러${Math.floor(Math.random() * 9999)}`,
        language: language || 'ko',
      },
    });

    res.status(201).json({ user, isNew: true });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// POST /api/auth/verify — 토큰 검증
router.post('/verify', async (req, res) => {
  try {
    const token = req.headers.authorization?.replace('Bearer ', '');
    const decoded = await admin.auth().verifyIdToken(token);
    const user = await prisma.user.findUnique({ where: { firebaseUid: decoded.uid } });
    res.json({ valid: true, user });
  } catch (error) {
    res.status(401).json({ valid: false });
  }
});

module.exports = router;
