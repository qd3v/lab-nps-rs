deps:
	rustup update && \
	rustup target add wasm32-unknown-unknown && \
	cargo install cargo-generate && \
	cargo install wasm-pack && \
	npm install -g wrangler

deploy:
	npx wrangler deploy

dev:
	npx wrangler dev

dev/request:
	curl -X POST -H "Content-Type: application/json" -d "[1,2,3,4]" http://localhost:8787/
