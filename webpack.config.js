const path = require('path');

module.exports = {
  entry: './src/db/dbFacade.js',
  output: {
    filename: 'db.js',
    path: path.resolve(__dirname)
  }
};