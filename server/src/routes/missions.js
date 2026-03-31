const router = require('express').Router();
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const { authMiddleware } = require('../middleware/auth');
const fs = require('fs');
const path = require('path');

// GET /api/missions/phases — 미션 데이터 (JSON 드리븐)
router.get('/phases', (req, res) => {
  try {
    const missionsPath = path.join(__dirname, '../../data/missions.json');
    if (fs.existsSync(missionsPath)) {
      const data = JSON.parse(fs.readFileSync(missionsPath, 'utf8'));
      return res.json(data);
    }
    // 폴백: Flutter 앱의 missions.json 사용
    res.json({ phases: [] });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// GET /api/missions/session/:waveId — 미션 세션 조회
router.get('/session/:waveId', authMiddleware, async (req, res) => {
  const session = await prisma.missionSession.findUnique({
    where: { waveId: req.params.waveId },
    include: { completedMissions: true },
  });
  res.json(session);
});

// PUT /api/missions/session/:id/progress — 미션 진행 업데이트
router.put('/session/:id/progress', authMiddleware, async (req, res) => {
  const { currentPhase, currentMission } = req.body;
  const session = await prisma.missionSession.update({
    where: { id: req.params.id },
    data: { currentPhase, currentMission },
  });
  res.json(session);
});

// POST /api/missions/session/:id/complete — 미션 완료
router.post('/session/:id/complete', authMiddleware, async (req, res) => {
  const { missionId, skipped = false } = req.body;
  const completion = await prisma.missionCompletion.create({
    data: {
      sessionId: req.params.id,
      missionId,
      completed: !skipped,
      skipped,
    },
  });
  res.json(completion);
});

// PUT /api/missions/session/:id/end — 미션 세션 종료
router.put('/session/:id/end', authMiddleware, async (req, res) => {
  const session = await prisma.missionSession.update({
    where: { id: req.params.id },
    data: { status: 'completed', endedAt: new Date() },
  });
  res.json(session);
});

// ── 관리자용: 미션 CRUD ──

// PUT /api/missions/admin/update — 미션 JSON 업데이트
router.put('/admin/update', authMiddleware, async (req, res) => {
  // TODO: 관리자 권한 체크
  try {
    const dataDir = path.join(__dirname, '../../data');
    if (!fs.existsSync(dataDir)) fs.mkdirSync(dataDir, { recursive: true });
    fs.writeFileSync(path.join(dataDir, 'missions.json'), JSON.stringify(req.body, null, 2));
    res.json({ success: true });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
