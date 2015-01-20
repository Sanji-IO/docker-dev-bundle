all: clean start

start:
	@echo "Start initializing..."
	@./start.sh

console:
	@echo "Start [Sanji Bundle Development Stack] console..."
	@./start.sh console

clean:
	@echo "Cleaning up Docker containers and tmp directories..."
	@rm -rf /tmp/bundledev.* > /dev/null
	@docker rm -fv $(shell docker ps -aq) 2> /dev/null || true

deepclean: clean
	-@docker rmi bundledev_bundle
