# license/

Fixture for the License capability.

This repository is **Apache-2.0** (see the root `LICENSE`). Everything below is
a licence that an ordinary corporate policy restricts, sitting inside that
permissively licensed project. Each one is reachable by a different route, so a
policy engine that only implements one of them will come up short.

## Vendored libraries - metadata *and* verbatim text

Each directory under `vendor/` declares its licence in `package.json` **and**
carries the canonical SPDX text in `LICENSE`, so the finding is reachable two
independent ways: metadata matching, and text matching.

| Directory | Declared | Why a policy restricts it |
|---|---|---|
| `vendor/libcopyleft/` | `GPL-3.0-only` | Strong copyleft; distributing a linked work obliges you to offer its source |
| `vendor/libnetcopyleft/` | `AGPL-3.0-only` | Network copyleft - section 13 extends the obligation to users served over a network, so an unmodified SaaS deployment triggers it |
| `vendor/libsourceavailable/` | `SSPL-1.0` | Source-available, **not** an OSI-approved open source licence; commonly denied outright because offering the software as a service obliges you to release the whole service stack |

To test text-only matching, delete the `license` field from a vendored
`package.json` and re-scan; the finding should survive on the `LICENSE` text
alone. To test metadata-only matching, delete the `LICENSE` file instead.

## Resolved dependencies - the manifest route

`package.json` and its real `package-lock.json` exercise the path a licence
engine actually takes in production: resolve the dependency tree, read the
declared licence of each resolved package. Nothing here is vendored.

| Package | Declared | What it tests |
|---|---|---|
| `highcharts` | `https://www.highcharts.com/license` | **A commercial licence, and not an SPDX identifier at all - the field is a bare URL.** An engine that only parses SPDX expressions will silently classify this as unknown rather than restricted, which is the failure mode worth catching |
| `jszip` | `(MIT OR GPL-3.0-or-later)` | **Clean control.** A dual licence with `OR` - the permissive branch is available, so flagging this is over-reporting |
| `pako` (transitive) | `(MIT AND Zlib)` | **Clean control.** A compound `AND` expression, both permissive. Reached only through `jszip`, so it also exercises transitive resolution |

The two controls matter as much as the findings: an engine that reports
`jszip` as GPL has picked the wrong branch of an `OR`, and one that chokes on
`pako` cannot parse compound expressions.
