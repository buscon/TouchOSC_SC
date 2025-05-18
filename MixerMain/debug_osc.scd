OSCdef(\test, {|msg, time, addr, recvPort| msg.postln; time.postln;}, '/ping', nil, 5000);

n = NetAddr("127.0.0.1", 5000);
n.sendMsg("/ping", 1);
