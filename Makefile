help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


build-python: ## Build the neovim python image, this is the base image
	docker build -f Dockerfile.python -t thornycrackers/neovim:python .

build-php: ## Build the neovim php image, depends on python tag
	docker build -f Dockerfile.php -t thornycrackers/neovim:php .

build-javascript: ## Build the neovim javascript image, depends on php tag
	docker build -f Dockerfile.javascript -t thornycrackers/neovim:javascript .

build-shell: ## Build the neovim shell image, depends on javascript tag
	docker build -f Dockerfile.shell -t thornycrackers/neovim .
