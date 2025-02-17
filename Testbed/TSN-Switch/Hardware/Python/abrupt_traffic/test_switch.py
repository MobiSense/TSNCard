import time
import socket
import threading
from abrupt_traffic.EthFrame import EthFrame


def recv_pkt(s: socket.socket):
    while True:
        message = s.recv(4096)
        receipt_ts = time.time_ns()
        ethframe = EthFrame()
        if ethframe.from_bytes(message):
            print(receipt_ts, ethframe.frame_description())


def test_switch_1():
    s1 = socket.socket(socket.AF_PACKET, socket.SOCK_RAW)
    s1.bind(('enx000ec674f78b', socket.PACKET_MULTICAST | socket.PACKET_HOST | socket.PACKET_OTHERHOST))

    s2 = socket.socket(socket.AF_PACKET, socket.SOCK_RAW)
    s2.bind(('enx000ec674f70b', socket.PACKET_MULTICAST | socket.PACKET_HOST | socket.PACKET_OTHERHOST))

    t1 = threading.Thread(target=recv_pkt, args=[s2])
    t1.start()
    i = 0
    while True:
        ethframe = EthFrame(1, 3, 0, i)
        s1.send(ethframe.tobytes())
        time.sleep(1)
        i += 1


if __name__ == '__main__':
    test_switch_1()
