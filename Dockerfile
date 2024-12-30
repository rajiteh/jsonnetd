# Build Stage
ARG GO_VERSION=1.23
FROM golang:${GO_VERSION} AS build

WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -tags netgo -ldflags "-w -extldflags '-static'" -o /jsonnetd .

# Final Stage
FROM scratch
COPY --from=build /jsonnetd /jsonnetd

ENTRYPOINT ["/jsonnetd"]
EXPOSE 8080
