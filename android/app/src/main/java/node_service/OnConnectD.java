package node_service;

import android.util.Log;

import com.google.gson.Gson;

import io.socket.emitter.Emitter;

class OnConnectD implements Emitter.Listener {
    private String eventConnect;

    public OnConnectD(String eventConnect) {

        this.eventConnect = eventConnect;
    }

    @Override
    public void call(Object... args) {
        Log.e("Connection log", new Gson().toJson(args));
        Log.e("Connection log", new Gson().toJson(eventConnect));
    }
}
