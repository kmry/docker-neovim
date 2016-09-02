help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build: ## Build the image
	clear
	make build-shellcheck
	docker build -t thornycrackers/alpine .

build-shellcheck: ## build the shellcheck binaries
	clear
	docker build -t thornycrackers/shellcheck shellcheck-builder
	docker run --rm -it -v $(CURDIR):/mnt thornycrackers/shellcheck

enter: ## Enter the image
	docker run -i -t thornycrackers/alpine

clearn: ## Remove the shellcheck binaries
	rm -rf package
