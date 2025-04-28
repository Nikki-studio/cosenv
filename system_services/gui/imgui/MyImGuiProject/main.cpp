#include <glad/glad.h>
#include <iostream>
#include <SDL.h>

// 6 is returned when error
// 0 is returned when is successful
//

int main() {
	if (SDL_Init(SDL_INIT_VIDEO)<0) {
		std::cout<<"Unsuccessfull";
		return 6;
	}
	std::cout<<"Successful";
return 0;
}
