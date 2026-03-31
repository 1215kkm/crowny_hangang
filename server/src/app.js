require('dotenv').config();
const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');
const http = require('http');
const { initSocket } = require('./socket/handler');

const app = express();
const server = http.createServer(app);

// 미들웨어
app.use(helmet());
app.use(cors());
app.use(morgan('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Socket.io 초기화
initSocket(server);

// 라우트
app.use('/api/auth', require('./routes/auth'));
app.use('/api/users', require('./routes/users'));
app.use('/api/matching', require('./routes/matching'));
app.use('/api/missions', require('./routes/missions'));
app.use('/api/chat', require('./routes/chat'));
app.use('/api/events', require('./routes/events'));
app.use('/api/board', require('./routes/board'));
app.use('/api/commerce', require('./routes/commerce'));

// 헬스 체크
app.get('/api/health', (req, res) => {
  res.json({ status: 'ok', timestamp: new Date().toISOString() });
});

// 에러 핸들링
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: '서버 오류가 발생했습니다' });
});

const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
  console.log(`🌊 Crowny 한강 서버 실행 중: http://localhost:${PORT}`);
});
