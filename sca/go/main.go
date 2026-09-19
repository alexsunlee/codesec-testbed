package main

import (
	"github.com/gin-gonic/gin"
	"gopkg.in/yaml.v3"
)

// Minimal consumer so `go mod tidy` keeps both vulnerable requires.
func main() {
	r := gin.Default()
	var cfg map[string]any
	_ = yaml.Unmarshal([]byte("k: v"), &cfg)
	_ = r.Run(":8080")
}
