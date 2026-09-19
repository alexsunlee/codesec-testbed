# IaC fixture - Dockerfile. Planted misconfigurations:
#   mutable base tag, runs as root, curl | bash from the network,
#   ADD from a remote URL, secret baked into a layer, no HEALTHCHECK.
FROM ubuntu:latest

# Secret in a build arg lands in the image history.
ENV API_TOKEN="ghp_CODESECTESTBED0000000000000000000000"

RUN apt-get update && apt-get install -y curl

# Remote code fetched and executed unverified at build time.
RUN curl -sSL https://example.internal/install.sh | bash

# ADD with a URL silently unpacks and does not verify.
ADD https://example.internal/payload.tar.gz /opt/payload.tar.gz

COPY . /app
WORKDIR /app

# No USER directive, so the container runs as root.
CMD ["./entrypoint.sh"]
