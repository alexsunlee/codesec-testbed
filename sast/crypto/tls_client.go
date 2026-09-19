package client

import (
	"crypto/tls"
	"crypto/x509"
	"net/http"
)

// CWE-295: certificate verification switched off, so every TLS connection this
// client makes is trivially interceptable. This is the single most common
// crypto finding in real repositories.
func InsecureClient() *http.Client {
	return &http.Client{
		Transport: &http.Transport{
			TLSClientConfig: &tls.Config{InsecureSkipVerify: true},
		},
	}
}

// CWE-326: pinned to TLS 1.0 with an export-grade cipher suite.
func LegacyClient() *http.Client {
	return &http.Client{
		Transport: &http.Transport{
			TLSClientConfig: &tls.Config{
				MinVersion:   tls.VersionTLS10,
				CipherSuites: []uint16{tls.TLS_RSA_WITH_RC4_128_SHA},
			},
		},
	}
}

// The correct version, for false-positive checking.
func SecureClient(pool *x509.CertPool) *http.Client {
	return &http.Client{
		Transport: &http.Transport{
			TLSClientConfig: &tls.Config{MinVersion: tls.VersionTLS12, RootCAs: pool},
		},
	}
}
