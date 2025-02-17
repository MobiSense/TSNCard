class PdelayRespMsg:
    def __init__(self, sequence_id_bytes, req_rec_ts, req_clock_identity, req_port_bytes):
        self.dst_addr = b'\x01\x80\xc2\x00\x00\x0e'
        self.src_addr = b'\x01\x02\x03\x04\x05\x07'
        self.ether_type = b'\x88\xf7'
        self.major_msgtype = b'\x13'
        self.version = b'\x02'
        self.message_length = b'\x00\x36'
        self.domain_number = b'\x00'
        self.minor = b'\x00'
        self.flags = b'\x02\x00'
        self.correction_field = 8 * b'\x00'
        self.msg_type_spc = 4 * b'\x00'
        self.clock_identity = 8 * b'\x00'
        self.source_port = b'\x00\x01'
        self.sequence_id = sequence_id_bytes
        self.control_field = b'\x05'
        self.log_message_interval = b'\x00'
        self.req_rec_ts_sec_msb = b'\x00\x00'
        ts_sec = req_rec_ts // 1000000000
        ts_ns = req_rec_ts % 1000000000
        self.req_rec_ts_sec_lsb = ts_sec.to_bytes(4, "big")
        self.req_rec_ts_ns = ts_ns.to_bytes(4, "big")
        self.req_clock_identity = req_clock_identity
        self.req_port = req_port_bytes
        self.t2 = 0
        self.seq_id = int.from_bytes(sequence_id_bytes, 'big')

    def from_bytes(self, frame_bytes):
        self.ether_type = frame_bytes[12:14]
        if self.ether_type != b'\x88\xf7':
            return False
        self.major_msgtype = frame_bytes[14]
        if self.major_msgtype & 0xf != 3:
            return False
        self.sequence_id = frame_bytes[44:46]
        self.seq_id = int.from_bytes(self.sequence_id, 'big')
        self.req_rec_ts_sec_lsb = frame_bytes[50:54]
        ts_sec = int.from_bytes(self.req_rec_ts_sec_lsb, 'big')
        self.req_rec_ts_ns = frame_bytes[54:58]
        ts_ns = int.from_bytes(self.req_rec_ts_ns, 'big')
        self.t2 = ts_sec * 1000000000 + ts_ns
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
        frame_bytes += self.req_rec_ts_sec_msb
        frame_bytes += self.req_rec_ts_sec_lsb
        frame_bytes += self.req_rec_ts_ns
        frame_bytes += self.req_clock_identity
        frame_bytes += self.req_port
        return frame_bytes
