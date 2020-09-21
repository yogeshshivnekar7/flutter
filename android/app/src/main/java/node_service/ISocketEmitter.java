package node_service;

import java.io.Serializable;

public interface ISocketEmitter extends Serializable {
    void onEmit(SocketResponsePojo nodeRequestPojo);

}
