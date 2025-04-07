const express = require('express');
const logger = require('./logger');
const app = express();
const PORT = 3000;

// Request logging middleware
app.use((req, res, next) => {
  const start = Date.now();
  res.on('finish', () => {
    const duration = Date.now() - start;
    logger.info({
      method: req.method,
      url: req.url,
      status: res.statusCode,
      duration: `${duration}ms`
    });
  });
  next();
});

// Error handling middleware
app.use((err, req, res, next) => {
  logger.error({
    error: err.message,
    stack: err.stack,
    method: req.method,
    url: req.url
  });
  res.status(500).send('Something broke!');
});

app.get('/', (req, res) => {
  logger.info('Handling request to root endpoint');
  res.send('Hello, Paper.Social');
});

app.get('/health', (req, res) => {
  logger.info('Health check request received');
  res.status(200).json({ status: 'healthy' });
});

// Test endpoint that generates an error
app.get('/error', (req, res, next) => {
  logger.info('Generating test error');
  next(new Error('Test error'));
});

app.listen(PORT, () => {
  logger.info(`Server is running on port ${PORT}`);
});
