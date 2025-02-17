PAYLOAD_SIZE = 1450


device_mac = {
    1: b'\x00\x00\x00\x00\x00\x01',
    2: b'\x00\x00\x00\x00\x00\x02',
    3: b'\x00\x00\x00\x00\x00\x03',
    4: b'\x00\x00\x00\x00\x00\x04',
}

priority_priority_bytes = {
    0: b'\x00\x01',
    1: b'\x20\x01',
    2: b'\x40\x01',
    3: b'\x60\x01',
    4: b'\x80\x01',
    5: b'\xa0\x01',
    6: b'\xc0\x01',
    7: b'\xe0\x01'
}

mac_device = {v: k for k, v in device_mac.items()}

priority_bytes_priority = {v: k for k, v in priority_priority_bytes.items()}


class EthFrame:
    def __init__(self, src_device=None, dst_device=None, priority=None, seq_id=None):
        self.src_device = src_device
        self.dst_device = dst_device
        self.priority = priority
        self.seq_id: int = seq_id

    def tobytes(self):
        frame_bytes = b''
        dst_addr = device_mac[self.dst_device]
        frame_bytes += dst_addr
        src_addr = device_mac[self.src_device]
        frame_bytes += src_addr
        ether_type = b'\x81\x00'
        frame_bytes += ether_type

        priority_bytes = priority_priority_bytes[self.priority]
        frame_bytes += priority_bytes

        second_ether_type = b'\x88\xb5'
        frame_bytes += second_ether_type

        # The VLAN header will be stripped when received.
        # So we repeat priority bytes here
        frame_bytes += priority_bytes

        seq_id_bytes = self.seq_id.to_bytes(4, 'big')
        frame_bytes += seq_id_bytes

        for i in range(PAYLOAD_SIZE):
            frame_bytes += b'\xf0'

        return frame_bytes

    def from_bytes(self, frame_bytes):
        dst_addr = frame_bytes[0:6]
        if dst_addr not in mac_device:
            return False
        self.dst_device = mac_device[dst_addr]

        src_addr = frame_bytes[6:12]
        if src_addr not in mac_device:
            return False
        self.src_device = mac_device[src_addr]

        ether_type = frame_bytes[12:14]
        priority_bytes = frame_bytes[14:16]
        self.priority = priority_bytes_priority[priority_bytes]

        seq_id_bytes = frame_bytes[16:20]
        self.seq_id = int.from_bytes(seq_id_bytes, 'big')
        return True

    def frame_description(self):
        return "Frame {}->{}: {}, Priority: {}.".format(self.src_device, self.dst_device, self.seq_id, self.priority)


