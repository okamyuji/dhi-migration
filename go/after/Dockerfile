# DHI 移行後 (Go 1.25)
# syntax=docker/dockerfile:1
FROM dhi.io/golang:1.25-alpine3.21-dev AS builder
WORKDIR /app
COPY go.mod ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o /app/server ./cmd/server

FROM dhi.io/static:latest
WORKDIR /app
COPY --from=builder /app/server /app/server
USER nonroot
EXPOSE 8080
ENTRYPOINT ["/app/server"]
