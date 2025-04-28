compiler      = g++
sources       = main.cpp ./glad/src/glad.c imgui/imgui.cpp imgui/imgui_demo.cpp imgui/imgui_draw.cpp imgui/imgui_tables.cpp imgui/imgui_widgets.cpp imgui/backends/imgui_impl_opengl2.cpp imgui/backends/imgui_impl_sdl2.cpp
target        = SDL_tutorial
linkflags     = -lSDL2 -lSDL2_mixer -lSDL2_image -lGL -ldlfw -ldl -lpthread
compilerflags = -std=c++17 -I./glad/include -Iimgui -Iimgui/backends -I/usr/include/SDL2 -I/usr/include/GLAD #-std=c++17 tells computer to use c++ 17

all: $(target)

$(target): $(sources)
	$(compiler) $(compilerflags) $^ $(linkflags) -o $@

clean:
	rm -f $(target)

.PHONY: all clean

