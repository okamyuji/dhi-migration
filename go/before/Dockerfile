# 従来の Dockerfile (Go 1.25)
FROM golang:1.25
WORKDIR /app
COPY go.mod ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o /app/server ./cmd/server
EXPOSE 8080
CMD ["/app/server"]
