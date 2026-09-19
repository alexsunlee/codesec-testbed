# license/

Fixture for the License capability.

This repository is **Apache-2.0** (see the root `LICENSE`). Vendored under
`vendor/libcopyleft/` is a library that declares **GPL-3.0-only**, with the real
GPL-3.0 text alongside it.

That combination is the finding: a strong copyleft dependency inside a
permissively licensed project. A licence engine has two independent ways to
reach it and should find it with either -

1. **metadata** - `vendor/libcopyleft/package.json` declares `GPL-3.0-only`
2. **text matching** - `vendor/libcopyleft/LICENSE` is the verbatim GPL-3.0

An engine that only does metadata matching will also find it here, because the
metadata is present. To test text-only matching, delete the `license` field from
the vendored `package.json` and re-scan; the finding should survive.
