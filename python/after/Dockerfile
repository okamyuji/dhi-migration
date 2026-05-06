# DHI 移行後 (Python 3.11)
# syntax=docker/dockerfile:1
FROM dhi.io/python:3.11-debian12-dev AS builder
WORKDIR /app
COPY requirements.txt .
RUN python -m venv /venv \
    && /venv/bin/pip install --no-cache-dir -r requirements.txt
COPY . .

FROM dhi.io/python:3.11-debian12
WORKDIR /app
COPY --from=builder /venv /venv
COPY --from=builder --chown=nonroot:nonroot /app /app
ENV PATH="/venv/bin:$PATH"
USER nonroot
EXPOSE 8080
CMD ["python", "main.py"]
