package handlers

import (
	"net/http"
	"os"
	"os/exec"
	"path/filepath"
)

// CWE-22: the query parameter is joined onto a base path without containment,
// so ../../etc/passwd escapes uploadDir.
func Download(w http.ResponseWriter, r *http.Request) {
	const uploadDir = "/var/www/uploads"
	body, err := os.ReadFile(filepath.Join(uploadDir, r.URL.Query().Get("name")))
	if err != nil {
		http.Error(w, "not found", http.StatusNotFound)
		return
	}
	_, _ = w.Write(body)
}

// CWE-78: the query parameter reaches a shell.
func Convert(w http.ResponseWriter, r *http.Request) {
	out, _ := exec.Command("sh", "-c", "convert "+r.URL.Query().Get("src")+" out.png").Output()
	_, _ = w.Write(out)
}
