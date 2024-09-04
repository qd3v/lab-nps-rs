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
