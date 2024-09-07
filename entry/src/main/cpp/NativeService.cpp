#include <jni.h>
#include <iostream>

extern "C" JNIEXPORT void JNICALL
Java_com_cts_craftingLauncher_NativeService_launchMinecraft(JNIEnv *env, jobject obj) {
    std::cout << "Launching Minecraft through JNI!" << std::endl;
    // 这里是启动 Minecraft 的逻辑
}
