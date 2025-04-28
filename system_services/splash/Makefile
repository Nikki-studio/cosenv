#g++ main.cpp -lGL -lglfw -ldl -o cos_anim_splash
compiler = g++
source   = src/main.cpp
ldflags  = -lGL -lglfw -ldl
target   = build/cos_anim_splash

all: $(target)
$(target): $(source)
	$(compiler) $^ $(ldflags) -o $@


clean:
	rm -f $(target)


.PHONY: all clean
