#g++ main.cpp \
#imgui/*.cpp \
#imgui/backends/imgui_impl_sdl2.cpp \
#imgui/backends/imgui_impl_opengl3.cpp \
#-Iimgui -Iimgui/backends -I/usr/include/SDL2 \
#-lSDL2 -lGL -ldl -lpthread -o mygui
./SDL_tutorial
