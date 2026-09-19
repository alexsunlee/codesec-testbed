// Vendored source, present so the licence finding has a real body of code
// attached to it rather than a bare metadata file.
module.exports = function slugify(s) {
  return String(s).toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '');
};
