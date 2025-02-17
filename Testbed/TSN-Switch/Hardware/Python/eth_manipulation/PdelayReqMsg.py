class PdelayReqMsg:
    def __init__(self, seq_id: int):
        self.dst_addr = b'\x01\x80\xc2\x00\x00\x0e'
        self.src_addr = b'\x01\x02\x03\x04\x05\x07'
        self.ether_type = b'\x88\xf7'
        self.major_msgtype = b'\x12'
        self.version = b'\x02'
        self.message_length = b'\x00\x36'
        self.domain_number = b'\x00'
        self.minor = b'\x00'
        self.flags = b'\x02\x00'
        self.correction_field = 8 * b'\x00'
        self.msg_type_spc = 4 * b'\x00'
        self.clock_identity = 8 * b'\x00'
        self.source_port = b'\x00\x01'
        self.sequence_id = seq_id.to_bytes(2, 'big')
        self.control_field = b'\x05'
        self.log_message_interval = b'\x00'
        self.res0 = 10 * b'\x00'
        self.res1 = 10 * b'\x00'

    def from_bytes(self, frame_bytes):
        self.ether_type = frame_bytes[12:14]
        # print('ether type', self.ether_type)
        if self.ether_type != b'\x88\xf7':
            return False
        self.major_msgtype = frame_bytes[14]
        # print('major type', self.major_msgtype)
        if self.major_msgtype & 0xf != 2:
            return False
        self.sequence_id = frame_bytes[44:46]
        self.clock_identity = frame_bytes[34:42]
        self.source_port = frame_bytes[42:44]
        return True

    def to_bytes(self):
        frame_bytes = b''
        frame_bytes += self.dst_addr
        frame_bytes += self.src_addr
        frame_bytes += self.ether_type
        frame_bytes += self.major_msgtype
        frame_bytes += self.version
        frame_bytes += self.message_length
        frame_bytes += self.domain_number
        frame_bytes += self.minor
        frame_bytes += self.flags
        frame_bytes += self.correction_field
        frame_bytes += self.msg_type_spc
        frame_bytes += self.clock_identity
        frame_bytes += self.source_port
        frame_bytes += self.sequence_id
        frame_bytes += self.control_field
        frame_bytes += self.log_message_interval
        frame_bytes += self.res0
        frame_bytes += self.res1
        return frame_bytes
