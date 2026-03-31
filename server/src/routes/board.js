const router = require('express').Router();
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const { authMiddleware } = require('../middleware/auth');

// GET /api/board — 게시글 목록
router.get('/', async (req, res) => {
  const { district, category, cursor, limit = 20 } = req.query;
  const where = {};
  if (district && district !== 'all') where.district = district;
  if (category) where.category = category;
  if (cursor) where.createdAt = { lt: new Date(cursor) };

  const posts = await prisma.boardPost.findMany({
    where,
    include: {
      author: { select: { id: true, nickname: true, avatarIcon: true, gradientType: true } },
      _count: { select: { comments: true, likes: true } },
    },
    orderBy: { createdAt: 'desc' },
    take: parseInt(limit),
  });

  res.json(posts.map(p => ({
    ...p,
    commentCount: p._count.comments,
    likeCount: p._count.likes,
  })));
});

// GET /api/board/:id — 게시글 상세
router.get('/:id', async (req, res) => {
  // 조회수 증가
  const post = await prisma.boardPost.update({
    where: { id: req.params.id },
    data: { viewCount: { increment: 1 } },
    include: {
      author: { select: { id: true, nickname: true, avatarIcon: true, gradientType: true } },
      comments: {
        include: {
          author: { select: { id: true, nickname: true, avatarIcon: true, gradientType: true } },
        },
        orderBy: { createdAt: 'asc' },
      },
      _count: { select: { likes: true } },
    },
  });
  res.json({ ...post, likeCount: post._count.likes });
});

// POST /api/board — 게시글 작성
router.post('/', authMiddleware, async (req, res) => {
  const { district, category, title, content, imageUrls = [] } = req.body;
  const post = await prisma.boardPost.create({
    data: { authorId: req.user.id, district, category, title, content, imageUrls },
    include: { author: { select: { id: true, nickname: true, avatarIcon: true, gradientType: true } } },
  });
  res.status(201).json(post);
});

// POST /api/board/:id/comments — 댓글 작성
router.post('/:id/comments', authMiddleware, async (req, res) => {
  const { content, parentId } = req.body;
  const comment = await prisma.boardComment.create({
    data: { postId: req.params.id, authorId: req.user.id, content, parentId },
    include: { author: { select: { id: true, nickname: true, avatarIcon: true, gradientType: true } } },
  });
  res.status(201).json(comment);
});

// POST /api/board/:id/like — 좋아요 토글
router.post('/:id/like', authMiddleware, async (req, res) => {
  const existing = await prisma.boardLike.findUnique({
    where: { postId_userId: { postId: req.params.id, userId: req.user.id } },
  });
  if (existing) {
    await prisma.boardLike.delete({ where: { id: existing.id } });
    res.json({ liked: false });
  } else {
    await prisma.boardLike.create({ data: { postId: req.params.id, userId: req.user.id } });
    res.json({ liked: true });
  }
});

// DELETE /api/board/:id — 게시글 삭제
router.delete('/:id', authMiddleware, async (req, res) => {
  const post = await prisma.boardPost.findUnique({ where: { id: req.params.id } });
  if (post.authorId !== req.user.id) return res.status(403).json({ error: '권한이 없습니다' });
  await prisma.boardPost.delete({ where: { id: req.params.id } });
  res.json({ success: true });
});

module.exports = router;
