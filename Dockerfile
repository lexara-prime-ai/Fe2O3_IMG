FROM messense/rust-musl-cross:x86_64-musl as builder
ENV SQLX_OFFLINE=true
WORKDIR /rest_api
# Copy source files
COPY . .
# Build the application
RUN cargo build --release --target x86_64-unknown-linux-musl

# Create new stage with minimal image
FROM scratch
COPY --from=builder /rest_api/target/x86_64-unknown-linux-musl/release/rest_api /rest_api
ENTRYPOINT [ "/rest_api" ]
EXPOSE 3000

