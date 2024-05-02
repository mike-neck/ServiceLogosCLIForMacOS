SWIFT_BUILD_DIR := .build
APP_BUILD_DIR := build
ARCH_NAME := $(shell uname -m)
OS_NAME := $(shell uname -s)

SCRIPTS := $(subst scripts/,,$(filter-out %.sh,$(wildcard scripts/*)))
SWIFT_TASKS := $(shell TERM=xterm-mono swift help | grep '^  swift' | tr -s ' ' | cut -d' ' -f3)
CONFIGURATIONS := debug release
EXCLUDE_COMBINATION := test-release

TEST_OUTPUT := $(APP_BUILD_DIR)/test-execution.log

.PHONY: help
help:
	@echo "MAKE targets ======"
	@echo ""
	@echo "- script tasks"
	@$(foreach task,$(SCRIPTS), echo "  - $(task)";)
	@echo ""
	@echo "- swift tasks"
	@$(foreach task,$(SWIFT_TASKS), echo "  - $(task)"; )

.PHONY: $(SCRIPTS)
$(SCRIPTS):
	@echo $(@)
	@$(PWD)/scripts/$(@)

define SwiftSubTask

    ifneq ($(1)-$(2),$(EXCLUDE_COMBINATION))

.PHONY: $(1)-$(2)-main
$(1)-$(2)-main:
	@echo $(1)-$(2)
        ifeq ($(1),test)
	@swift $(1) --configuration $(2) --enable-code-coverage | tee $(TEST_OUTPUT)
        else
	@swift $(1) --configuration $(2)
        endif

.PHONY: before-$(1)-$(2)
.PHONY: after-$(1)-$(2)

.PHONY: $(1)-$(2)
$(1)-$(2): before-$(1)-$(2) $(1)-$(2)-main after-$(1)-$(2)

    endif

endef
$(foreach task,$(SWIFT_TASKS),$(foreach config,$(CONFIGURATIONS),$(eval $(call SwiftSubTask,$(task),$(config)))))

define SwiftTask

    ifneq ($(1)-$(2),$(EXCLUDE_COMBINATION))

.PHONY: $(1)-main
$(1)-main: $(1)-$(2)

    endif

    ifneq ($(2),debug)

.PHONY: before-$(1)
.PHONY: after-$(1)

.PHONY: $(1)
$(1): before-$(1) $(1)-main after-$(1)

    endif

endef

$(foreach task,$(SWIFT_TASKS),$(foreach config,$(CONFIGURATIONS),$(eval $(call SwiftTask,$(task),$(config)))))

print-%:
	@echo $(*) = $($(*))
