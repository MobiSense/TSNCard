import socket
import time
import threading
from CriticalMsg import CriticalMsg


SEC_NS = 1000000000


s = socket.socket(socket.AF_PACKET, socket.SOCK_RAW)
s.bind(('enx000ec674f78b', socket.PACKET_MULTICAST | socket.PACKET_HOST | socket.PACKET_OTHERHOST))


if __name__ == '__main__':
    seq_id = 1
    pkt_id = 1
    start_ns = time.time_ns()
    while True:
        msg = CriticalMsg(tx_ts=time.time_ns()-start_ns, seq_id=seq_id, pkt_id=pkt_id)
        pkt_id += 1
        try:
            s.send(msg.to_bytes())
            print (msg.to_bytes())
        except Exception as e:
            print (e)
        time.sleep(1)
