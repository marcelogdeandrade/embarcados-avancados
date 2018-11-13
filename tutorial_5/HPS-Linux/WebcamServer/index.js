const LiveCam = require('livecam');

const webcam_server = new LiveCam({
    'ui_addr' : '192.168.0.121',
    'ui_port' : 11000,
    'broadcast_addr' : '192.168.0.121',
    'broadcast_port' : 12000,
    'gst_tcp_addr' : '192.168.0.121',
    'gst_tcp_port' : 10000,
    'start' : function() {
        console.log('WebCam server started!');
    }
});

webcam_server.broadcast();
