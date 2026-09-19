// SAST fixture - JavaScript / Express.
// Planted flaws:
//   CWE-79  reflected XSS         GET /greet
//   CWE-94  code injection        GET /calc
//   CWE-22  path traversal        GET /file
const express = require('express');
const fs = require('fs');
const path = require('path');

const app = express();

// CWE-79: request data written into the response as HTML.
app.get('/greet', (req, res) => {
  res.send(`<h1>Hello ${req.query.name}</h1>`);
});

// CWE-94: request data evaluated as code.
app.get('/calc', (req, res) => {
  res.json({ result: eval(req.query.expr) });
});

// CWE-22: request data joined onto a filesystem path with no containment check.
app.get('/file', (req, res) => {
  res.send(fs.readFileSync(path.join('/var/www/uploads', req.query.name), 'utf8'));
});

module.exports = app;
