import { createServer } from 'vite';
import { setupHMR } from './hmr';
import { setupMiddleware } from './middleware';

export class DevServer {
  private config: any;

  constructor(config: any) {
    this.config = config;
  }

  async start() {
    const server = await createServer({
      // Server configuration
      plugins: [
        // Development plugins
      ],
      server: {
        port: 3000,
        hmr: true,
      },
    });

    await server.listen();
    console.log('Development server started on port 3000');
  }
}