import { createServer } from 'node:http';

const port = Number(process.env.PORT ?? 8080);
const server = createServer((_req, res) => {
  res.setHeader('content-type', 'application/json');
  res.end(JSON.stringify({ runtime: 'node', version: process.version, ok: true }));
});

server.listen(port, () => {
  console.log(`listening on ${port}`);
});
