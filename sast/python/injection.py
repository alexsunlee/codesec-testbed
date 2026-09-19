"""SAST fixture - Python.

Planted flaws:
  CWE-78   command injection      run_backup
  CWE-502  unsafe deserialisation load_config / load_session
  CWE-94   code injection         evaluate
"""
import os
import pickle
import subprocess

import yaml


def run_backup(target: str) -> None:
    """CWE-78: user-controlled value reaches a shell."""
    os.system(f"tar czf /backup/{target}.tgz /data/{target}")


def run_backup_safely(target: str) -> None:
    """Same job, no shell. A finding here is a false positive."""
    subprocess.run(["tar", "czf", f"/backup/{target}.tgz", f"/data/{target}"], check=True)


def load_config(raw: str) -> dict:
    """CWE-502: yaml.load without a safe loader constructs arbitrary Python objects."""
    return yaml.load(raw)


def load_session(blob: bytes):
    """CWE-502: pickle on untrusted input is remote code execution."""
    return pickle.loads(blob)


def evaluate(expression: str):
    """CWE-94: eval on request data."""
    return eval(expression)
