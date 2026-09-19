# secrets/

Fixtures for the Secrets capability.

Every credential in this directory is **fabricated**. Each one carries the
literal marker `CODESECTESTBED`, and none of them authenticates to anything.
What is real is the **format** - detectors match on shape, so a fixture with the
wrong shape tests nothing.

`id_rsa_testbed` is a genuine 2048-bit RSA private key generated when this
repository was created. It has never been installed on a host, in a CI system,
or in any `authorized_keys` file, and it exists only so that PEM-block
detection has something real to match.

One secret also lives in **git history only**: see the commit titled
`chore: remove leaked staging token`. `git log -p -- secrets/` will show it.
A scanner that only reads the working tree will miss it - that is the point.
