const { Server } = require('socket.io');

let io;

function initSocket(server) {
  io = new Server(server, {
    cors: { origin: '*' },
  });

  io.on('connection', (socket) => {
    console.log(`🔌 소켓 연결: ${socket.id}`);

    // 사용자 룸 등록
    socket.on('user:join', (userId) => {
      socket.join(`user:${userId}`);
      console.log(`👤 ${userId} 접속`);
    });

    // 채팅방 참여
    socket.on('chat:join', (roomId) => {
      socket.join(`chat:${roomId}`);
    });

    // 채팅 메시지 전송
    socket.on('chat:message', (data) => {
      const { roomId, senderId, content, type = 'text' } = data;
      // DB 저장은 REST API에서 처리, 여기서는 실시간 브로드캐스트만
      io.to(`chat:${roomId}`).emit('chat:message', {
        roomId, senderId, content, type,
        createdAt: new Date().toISOString(),
      });
    });

    // 미션 타이머 동기화
    socket.on('mission:join', (sessionId) => {
      socket.join(`mission:${sessionId}`);
    });

    socket.on('mission:progress', (data) => {
      io.to(`mission:${data.sessionId}`).emit('mission:progress', data);
    });

    socket.on('mission:complete', (data) => {
      io.to(`mission:${data.sessionId}`).emit('mission:complete', data);
    });

    // 위치 업데이트 (같은 지구 사용자에게 브로드캐스트)
    socket.on('location:update', (data) => {
      socket.to(`district:${data.district}`).emit('location:update', {
        userId: data.userId,
        latitude: data.latitude,
        longitude: data.longitude,
        activity: data.activity,
      });
    });

    // 지구 참여
    socket.on('district:join', (district) => {
      socket.join(`district:${district}`);
    });

    socket.on('disconnect', () => {
      console.log(`🔌 소켓 해제: ${socket.id}`);
    });
  });

  return io;
}

function getIO() {
  if (!io) throw new Error('Socket.io가 초기화되지 않았습니다');
  return io;
}

module.exports = { initSocket, getIO };
