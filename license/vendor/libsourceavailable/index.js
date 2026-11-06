// Vendored source, present so the licence finding has a real body of code
// attached to it rather than a bare metadata file.
module.exports = function chunk(xs, n) {
  const out = [];
  for (let i = 0; i < xs.length; i += n) out.push(xs.slice(i, i + n));
  return out;
};
