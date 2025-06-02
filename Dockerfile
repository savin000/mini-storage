FROM golang:1.24 AS builder

ARG CGO_ENABLED=0
WORKDIR /app

COPY go.mod ./
RUN go mod download
COPY . .

RUN go build -o mini-storage ./cmd/main.go

FROM scratch
COPY --from=builder /app/mini-storage /mini-storage
ENTRYPOINT ["/mini-storage"]