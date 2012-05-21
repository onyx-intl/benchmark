include $(CLEAR_VARS)

LOCAL_CFLAGS:= -DTIME -pedantic -O2

# unixbench can't be built without optimizations, so we enforce -O2 if no
# other optimization flag is set - but we don't override what the global
# flags are saying if something else is given (-Os or -O3 are useful)
ifeq ($(findstring -O, $(TARGET_GLOBAL_CFLAGS)),)
LOCAL_CFLAGS += -O2
endif
ifneq ($(findstring -O0, $(TARGET_GLOBAL_CFLAGS)),)
LOCAL_CFLAGS += -O2
endif

LOCAL_CFLAGS += -fomit-frame-pointer -fforce-addr -ffast-math

ifdef EXTRA_FLAGS
LOCAL_CFLAGS:= $(LOCAL_CFLAGS) $(EXTRA_FLAGS)
endif

ifndef LOCAL_SRC_FILES
LOCAL_SRC_FILES:= src/$(TARGET_MODULE).c 
endif

LOCAL_MODULE:= bench_ubench_$(TARGET_MODULE)
LOCAL_MODULE_TAGS := optional

include $(BUILD_EXECUTABLE)

