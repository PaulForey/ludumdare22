OUTPUT := ../bin/ludumdare22.swf

ifdef DEBUG
DEBUG_FLAG := true
else
DEBUG_FLAG := false
endif

all:
	fcsh-wrap -optimize=true -output $(OUTPUT) -static-link-runtime-shared-libraries=true \
		-compatibility-version=3.0.0 --target-player=10.2.0 -compiler.debug=$(DEBUG_FLAG) Main.as

win:
	mxmlc -optimize=true -output $(OUTPUT) -static-link-runtime-shared-libraries=true \
		-compatibility-version=3.0.0 --target-player=10.2.0 -compiler.debug=$(DEBUG_FLAG) Main.as

clean:
	rm -f *~ $(OUTPUT) .FW.*

.PHONY: all clean

