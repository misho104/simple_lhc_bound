.PHONY: all dev clean

DIRS = $(filter %/, $(wildcard */))

# any better way to do this?
all:
	for d in $(DIRS); do make all -C $$d; done
dev:
	for d in $(DIRS); do make dev -C $$d; done
clean:
	for d in $(DIRS); do make clean -C $$d; done

