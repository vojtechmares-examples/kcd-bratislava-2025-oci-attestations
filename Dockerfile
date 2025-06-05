FROM golang:1.24-bookworm AS build

WORKDIR /build

COPY go.mod go.sum ./

RUN go mod download

COPY . .

ARG TARGETOS
ARG TARGETARCH

RUN CGO_ENABLED=0 GOOS=$TARGETOS GOARCH=$TARGETARCH go build -o /build/demo ./cmd/main.go

FROM gcr.io/distroless/static-debian12:nonroot AS runtime

EXPOSE 8080

COPY --from=build /build/demo /srv/demo

CMD ["/srv/demo"]
