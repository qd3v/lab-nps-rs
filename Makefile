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

#
# REQUESTS
#

DEV_URL = http://localhost:8787/
PROD_URL = https://nps-rs.kulagin.dev

do_request = curl -X POST -H "Content-Type: application/json" -d "[1,2,3,4]" $(1)

dev/request:
	$(call do_request,$(DEV_URL))

prod/request:
	$(call do_request,$(PROD_URL))
