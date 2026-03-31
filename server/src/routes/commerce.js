const router = require('express').Router();
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const { authMiddleware } = require('../middleware/auth');

// POST /api/commerce/orders — 주문 생성
router.post('/orders', authMiddleware, async (req, res) => {
  const { items, totalPrice, deliveryFee = 0, district, deliveryAddress, isGift, recipientId } = req.body;
  const order = await prisma.order.create({
    data: {
      userId: req.user.id,
      items,
      totalPrice,
      deliveryFee,
      district,
      deliveryAddress,
      isGift: isGift || false,
      recipientId,
    },
  });
  res.status(201).json(order);
});

// GET /api/commerce/orders — 내 주문 내역
router.get('/orders', authMiddleware, async (req, res) => {
  const orders = await prisma.order.findMany({
    where: { userId: req.user.id },
    orderBy: { createdAt: 'desc' },
    take: 20,
  });
  res.json(orders);
});

// GET /api/commerce/orders/:id — 주문 상세
router.get('/orders/:id', authMiddleware, async (req, res) => {
  const order = await prisma.order.findUnique({ where: { id: req.params.id } });
  if (order.userId !== req.user.id) return res.status(403).json({ error: '권한이 없습니다' });
  res.json(order);
});

module.exports = router;
