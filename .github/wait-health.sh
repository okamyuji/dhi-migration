#!/bin/sh
# Wait up to 60 seconds for the app started in the previous step to answer /health.
for _ in $(seq 60); do
  if curl -fs"http://127.0.0.1:${PORT:-8080}/health"; then
    echo
    exit 0
  fi
  sleep 1
done
echo "no answer from /health" >&2
exit 1
