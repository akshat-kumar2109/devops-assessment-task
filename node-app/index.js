const express = require('express');
const app = express();
const PORT = 3000;

app.get('/', (req, res) => {
  logger.info('Handling request to root endpoint');
  res.send('Hello, Paper.Social');
});

app.listen(PORT, () => {
  logger.info(`Server is running on port ${PORT}`);
});
