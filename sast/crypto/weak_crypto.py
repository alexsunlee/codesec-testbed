"""Crypto-misuse fixture. Same engine as SAST, separate rule pack.

Planted flaws:
  CWE-327  broken hash for passwords      hash_password
  CWE-327  broken cipher (DES/ECB)        encrypt_legacy
  CWE-330  predictable randomness         new_token
  CWE-329  hard-coded IV                  encrypt_legacy
"""
import hashlib
import random

from Crypto.Cipher import DES  # pycryptodome


def hash_password(password: str) -> str:
    """CWE-327: MD5 is not a password hash."""
    return hashlib.md5(password.encode()).hexdigest()


def hash_password_correctly(password: str, salt: bytes) -> bytes:
    """What it should be. A finding here is a false positive."""
    return hashlib.pbkdf2_hmac("sha256", password.encode(), salt, 600_000)


# CWE-329: a hard-coded, reused IV.
STATIC_IV = b"12345678"


def encrypt_legacy(data: bytes, key: bytes) -> bytes:
    """CWE-327: DES in CBC with a fixed IV."""
    return DES.new(key, DES.MODE_CBC, STATIC_IV).encrypt(data)


def new_token() -> str:
    """CWE-330: random is not cryptographically secure."""
    return "".join(random.choice("0123456789abcdef") for _ in range(32))
