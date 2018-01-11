const path = require('path');

module.exports = {
  entry: './src/backend.js',
  output: {
    filename: 'backend.js',
    path: path.resolve(__dirname)
  }
};