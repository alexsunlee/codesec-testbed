// Vendored source, present so the licence finding has a real body of code
// attached to it rather than a bare metadata file.
module.exports = function truncate(s, n) {
  s = String(s);
  return s.length <= n ? s : s.slice(0, Math.max(0, n - 1)) + '…';
};
