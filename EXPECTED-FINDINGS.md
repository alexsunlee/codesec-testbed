# Expected findings

Ground truth for `codesec-testbed`. Advisory data is from the GitHub Advisory
Database (reviewed advisories only) as of 2026-09-19. Use this to diff a scan
result against what was actually planted - both for missed findings and for
findings on the clean controls.

## SCA - 9 ecosystems, 18 planted vulnerable packages

| Ecosystem | File | Package | Pinned | GHSA | CVE | Severity | Fixed in |
|---|---|---|---|---|---|---|---|
| npm | `sca/npm/package.json` | lodash | 4.17.20 | GHSA-35jh-r3h4-6jhm | CVE-2021-23337 | High | 4.17.21 |
| npm | `sca/npm/package.json` | minimist | 1.2.5 | GHSA-xvch-5gv4-984h | CVE-2021-44906 | Critical | 1.2.6 |
| PyPI | `sca/pypi/requirements.txt` | PyYAML | 5.3.1 | GHSA-8q59-q68h-6hv4 | CVE-2020-14343 | Critical | 5.4 |
| PyPI | `sca/pypi/requirements.txt` | Django | 4.2.14 | GHSA-pv4p-cwwg-4rph | CVE-2024-42005 | Critical | 4.2.15 |
| PyPI | `sca/pypi/requirements.txt` | Jinja2 | 2.10.0 | GHSA-462w-v97r-4m45 | CVE-2019-10906 | High | 2.10.1 |
| PyPI | `sca/pypi/requirements.txt` | urllib3 | 1.26.17 | GHSA-34jh-p97f-mpxf | CVE-2024-37891 | Medium | 1.26.19 |
| PyPI | `sca/pypi/pyproject.toml` | PyYAML, Jinja2 | same | as above | | | second manifest format |
| Maven | `sca/maven/pom.xml` | org.apache.logging.log4j:log4j-core | 2.14.1 | GHSA-jfh8-c2jp-5v3q | CVE-2021-44228 | Critical | 2.15.0 (clean: 2.17.1) |
| Maven | `sca/maven/pom.xml` | log4j:log4j | 1.2.17 | GHSA-2qrg-x229-3v8q | CVE-2019-17571 | Critical | none (1.x is EOL) |
| Maven | `sca/maven/pom.xml` | com.fasterxml.jackson.core:jackson-databind | 2.13.0 | GHSA-rmj7-2vxq-3g9f | CVE-2026-54513 | High | 2.18.8 |
| Maven | `sca/maven/pom.xml` | org.springframework:spring-beans | 5.3.17 | GHSA-36p3-wjmg-h94x | CVE-2022-22965 | Critical | 5.3.18 |
| Gradle | `sca/gradle/build.gradle` | log4j-core + jackson-databind | same | as above | | | second manifest format |
| Go | `sca/go/go.mod` | github.com/gin-gonic/gin | v1.7.6 | GHSA-h395-qcrw-5vmq | CVE-2020-28483 | High | v1.7.7 |
| Go | `sca/go/go.mod` | gopkg.in/yaml.v3 | v3.0.0-2021... | GHSA-hp87-p4gw-j4gq | CVE-2022-28948 | High | v3.0.1 |
| RubyGems | `sca/rubygems/Gemfile` | rack | 2.2.22 | GHSA-8vqr-qjwx-82mw | CVE-2026-34829 | High | 2.2.23 |
| RubyGems | `sca/rubygems/Gemfile` | nokogiri | 1.19.2 | GHSA-c4rq-3m3g-8wgx | CVE-2026-79770 | High | 1.19.3 |
| Composer | `sca/composer/composer.json` | guzzlehttp/guzzle | 7.15.1 | GHSA-v5mv-p594-2x33 | CVE-2026-69246 | High | 7.15.2 |
| NuGet | `sca/nuget/App.csproj` | Newtonsoft.Json | 12.0.3 | GHSA-5crp-9r3c-p9vr | CVE-2024-21907 | High | 13.0.1 |
| Cargo | `sca/cargo/Cargo.toml` | time | 0.2.22 | GHSA-wcg3-cvx6-7396 | CVE-2020-26235 | Medium | 0.2.23 |
| Cargo | `sca/cargo/Cargo.toml` | smallvec | 0.6.12 | GHSA-55m5-whcv-c49c | CVE-2018-25023 | High | 0.6.13 |

**Transitive findings are expected on top of this table.** `sca/npm/package-lock.json`
resolves 71 packages and `sca/go/go.sum` pulls a 2020 build of `golang.org/x/crypto`;
both carry their own advisories. A scanner reporting *only* the 16 direct pins has
not resolved the tree.

**Clean control:** `requests==2.31.0` and `express@4.18.2` are pinned clean at the
top level.

## SAST - 11 planted flaws

| File | Function | CWE | Class |
|---|---|---|---|
| `sast/java/SqlInjection.java` | `findUser` | CWE-89 | SQL injection |
| `sast/java/SqlInjection.java` | `exportReport` | CWE-78 | OS command injection |
| `sast/python/injection.py` | `run_backup` | CWE-78 | OS command injection |
| `sast/python/injection.py` | `load_config` | CWE-502 | Unsafe YAML deserialisation |
| `sast/python/injection.py` | `load_session` | CWE-502 | Pickle on untrusted input |
| `sast/python/injection.py` | `evaluate` | CWE-94 | Code injection |
| `sast/javascript/xss.js` | `GET /greet` | CWE-79 | Reflected XSS |
| `sast/javascript/xss.js` | `GET /calc` | CWE-94 | Code injection |
| `sast/javascript/xss.js` | `GET /file` | CWE-22 | Path traversal |
| `sast/go/path_traversal.go` | `Download` | CWE-22 | Path traversal |
| `sast/go/path_traversal.go` | `Convert` | CWE-78 | OS command injection |

**Clean controls:** `findUserSafely`, `run_backup_safely`.

## Crypto misuse - 6 planted flaws

| File | Symbol | CWE | Class |
|---|---|---|---|
| `sast/crypto/weak_crypto.py` | `hash_password` | CWE-327 | MD5 used as a password hash |
| `sast/crypto/weak_crypto.py` | `encrypt_legacy` | CWE-327 | DES |
| `sast/crypto/weak_crypto.py` | `STATIC_IV` | CWE-329 | Hard-coded, reused IV |
| `sast/crypto/weak_crypto.py` | `new_token` | CWE-330 | Non-cryptographic RNG for a token |
| `sast/crypto/tls_client.go` | `InsecureClient` | CWE-295 | Certificate verification disabled |
| `sast/crypto/tls_client.go` | `LegacyClient` | CWE-326 | TLS 1.0 with RC4 |

**Clean controls:** `hash_password_correctly`, `SecureClient`.

## Secrets - 9 planted, 1 of them history-only

| File | Kind |
|---|---|
| `secrets/deploy.sh` | AWS access key ID + secret access key |
| `secrets/config.yaml` | GitHub personal access token (`ghp_`) |
| `secrets/config.yaml` | Slack bot token + incoming webhook URL |
| `secrets/config.yaml` | Stripe live secret key (`sk_live_`) |
| `secrets/config.yaml` | Postgres URL with an embedded password |
| `secrets/config.yaml` | JWT signing secret |
| `secrets/id_rsa_testbed` | RSA private key, PEM block |
| `iac/terraform/rds.tf` | Database password in infrastructure code |
| `iac/docker/Dockerfile` | Token baked into an image layer (`ENV API_TOKEN`) |
| **git history only** | A staging token added and then removed - see `git log -p -- secrets/` |

Every value is fabricated and contains the marker `CODESECTESTBED`. The history
entry is the interesting one: a scanner that only reads the working tree will
report 9 and miss the tenth.

## IaC - 22 planted misconfigurations

| File | Planted |
|---|---|
| `iac/terraform/s3.tf` | public-read ACL, wildcard bucket policy, no SSE, no versioning, no logging, no public-access block |
| `iac/terraform/network.tf` | SSH 22 open to 0.0.0.0/0, RDP 3389 open to 0.0.0.0/0, unrestricted egress |
| `iac/terraform/rds.tf` | publicly accessible, storage unencrypted, no backups, no deletion protection, hard-coded password |
| `iac/kubernetes/deployment.yaml` | privileged, runAsUser 0, allowPrivilegeEscalation, hostNetwork, hostPID, docker socket hostPath, `:latest` tag, no resource limits, no probes, secret in a plain env var |
| `iac/docker/Dockerfile` | `:latest` base, runs as root, `curl \| bash`, `ADD` from a URL, token in `ENV`, no HEALTHCHECK |
| `iac/cloudformation/template.yaml` | public-read bucket, 22 and 5432 open to the world, IAM role with `Action: "*"` on `Resource: "*"` |

**Clean controls:** `aws_s3_bucket.compliant` with its encryption and
public-access-block resources, and `codesec-testbed-api-hardened`.

## License - 1 planted conflict

| File | Planted |
|---|---|
| `license/vendor/libcopyleft/` | GPL-3.0-only library vendored into an Apache-2.0 project, declared in metadata and present as verbatim licence text |

## CI/CD posture - 5 planted (no engine today)

| File | Planted |
|---|---|
| `.github/workflows/insecure-pipeline.yml` | `pull_request_target` + checkout of the PR head, actions on mutable refs (`@master`, `@v1`), `permissions: write-all`, untrusted PR title interpolated into `run`, long-lived cloud credentials instead of OIDC |

FortiCNAPP has no CI/CD posture engine today, so a clean scan here is the
*expected* result. The fixture exists so that the day one ships, there is
something to point it at.
