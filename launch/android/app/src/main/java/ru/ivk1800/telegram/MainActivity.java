package ru.ivk1800.telegram;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

    //返回手机桌面事件
    static final String eventBackDesktop = "backDesktop";

    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        //通讯名称，回到手机桌面
        String CHANNEL = "android/back/desktop";
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals(eventBackDesktop)) {
                                moveTaskToBack(false);
                                result.success(true);
                            }
                        }
                );
    }

}
