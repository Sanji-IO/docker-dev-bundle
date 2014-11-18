all: clean start

start:
	@echo "Start initializing..."
	./start.sh

clean:
	@echo "Cleaning up Docker containers and tmp directories..."
	@rm -rf /tmp/bundletest.* > /dev/null
	@docker rm -fv $(shell docker ps -aq) 2> /dev/null || true

deepclean: clean
	-@docker rmi bundledev_bundle
