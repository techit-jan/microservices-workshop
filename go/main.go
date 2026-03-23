package main

import (
	"encoding/json"
	"net/http"
	"os"
	"time"
)

type ApiResponse struct {
	Code    string `json:"code"`
	Message string `json:"message"`
}

// 🔥 log helper
func logJSON(level string, fields map[string]string) {
	logData := map[string]any{
		"timestamp": time.Now().UTC().Format(time.RFC3339Nano),
		"level":     level,
		"fields":    fields,
	}

	_ = json.NewEncoder(os.Stdout).Encode(logData)
}

func writeJSON(w http.ResponseWriter, status int, payload any) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(status)

	if err := json.NewEncoder(w).Encode(payload); err != nil {
		http.Error(w, `{"code":"500","message":"encode response failed"}`, http.StatusInternalServerError)
	}
}

func helloHandler(w http.ResponseWriter, r *http.Request) {

	// ✅ ใช้แบบนี้แทน log.Printf
	logJSON("INFO", map[string]string{
		"code":        "200",
		"service":     "hello-world",
		"employee_id": "1111",
		"message":     "Hello World",
	})

	writeJSON(w, http.StatusOK, ApiResponse{
		Code:    "200",
		Message: "Hello World",
	})
}

func main() {
	http.HandleFunc("/hello-world", helloHandler)

	http.ListenAndServe(":8080", nil)
}
