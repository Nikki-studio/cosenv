// OpenGL + GLFW minimal animation: Wave to C transformation

#include <GLFW/glfw3.h>
#include <cmath>
#include <iostream>

const int WIDTH = 800;
const int HEIGHT = 600;
float timeElapsed = 0.0f;
float deltaTime = 0.0f;
float lastFrame = 0.0f;

void drawWave(float t) {
    glBegin(GL_LINE_STRIP);
    for (float x = -1.0f; x <= 1.0f; x += 0.01f) {
        float y = 0.0f;
        if (t < 1.5f) {
            y = 0.1f * sin(10 * x - t * 4) + 0.1f * cos(10 * x + t * 4);
        } else if (t < 2.0f) {
            y = 0.2f * sin(10 * x);
        } else {
            return; // Wave disappears
        }
        glVertex2f(x, y);
    }
    glEnd();
}

void drawUpsideDownC() {
    glBegin(GL_LINE_STRIP);
    for (float angle = -3.14f / 2; angle <= 3.14f / 2; angle += 0.05f) {
        float x = 0.3f * cos(angle) - 0.3f;
        float y = -0.5f * sin(angle);
        glVertex2f(x, y);
    }
    glEnd();
}

void drawRotatingC(float t) {
    float rotation = (t - 2.2f) * 180.0f;
    glPushMatrix();
    glTranslatef(0.0f, 0.0f, 0.0f);
    glRotatef(rotation, 0.0f, 0.0f, 1.0f);
    drawUpsideDownC();
    glPopMatrix();
}

int main() {
    if (!glfwInit()) return -1;

    GLFWwindow* window = glfwCreateWindow(WIDTH, HEIGHT, "Wave to C", NULL, NULL);
    if (!window) {
        glfwTerminate();
        return -1;
    }

    glfwMakeContextCurrent(window);
    glOrtho(-1.0, 1.0, -1.0, 1.0, -1, 1);

    while (!glfwWindowShouldClose(window)) {
        float currentFrame = glfwGetTime();
        deltaTime = currentFrame - lastFrame;
        lastFrame = currentFrame;
        timeElapsed += deltaTime;

        glClear(GL_COLOR_BUFFER_BIT);

        if (timeElapsed < 2.0f)
            drawWave(timeElapsed);
        else if (timeElapsed < 2.2f)
            drawUpsideDownC();
        else
            drawRotatingC(timeElapsed);

        glfwSwapBuffers(window);
        glfwPollEvents();
    }

    glfwTerminate();
    return 0;
}
