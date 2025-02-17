class FollowUpMsg:
    def __init__(self, seq_id: int, pot_ns):
        # header
        self.dst_addr = b'\x01\x80\xc2\x00\x00\x0e'
        self.src_addr = b'\x01\x02\x03\x04\x05\x07'
        self.ether_type = b'\x88\xf7'
        self.major_msgtype = b'\x18'
        self.version = b'\x02'
        self.message_length = b'\x00\x4c'
        self.domain_number = b'\x00'
        self.minor = b'\x00'
        self.flags = b'\x02\x00'
        self.correction_field = int(10).to_bytes(8, 'big')
        self.msg_type_spc = 4 * b'\x00'
        self.clock_identity = 8 * b'\x00'
        self.source_port = b'\x00\x01'
        self.sequence_id = seq_id.to_bytes(2, 'big')
        self.control_field = b'\x02'
        self.log_message_interval = b'\x00'
        # preciseOriginTimestamp
        self.pot_sec_msb = int(0).to_bytes(2, 'big')
        self.pot_sec_lsb = int(pot_ns / 1000000000).to_bytes(4, 'big')
        self.pot_mod_ns = int(pot_ns % 1000000000).to_bytes(4, 'big')
        # followUpInformationTLV
        self.tlvType = int(3).to_bytes(2, 'big')
        self.tlvLength = int(28).to_bytes(2, 'big')
        self.tlvorgid = b'\x00\x80\xc2'
        self.tlvorgsub = b'\x00\x00\x01'
        self.cumulativeScaledRateOffset = int(0).to_bytes(4, 'big')
        self.gmTimeBaseIndicator = int(0).to_bytes(2, 'big')
        self.lastGmPhaseChange = int(0).to_bytes(12, 'big')
        self.scaledLastGmFreqChange = int(0).to_bytes(4, 'big')

        self.seq_id = seq_id
        self.pot_ns = pot_ns
        self.correction = 10
        self.correction_ns = self.correction >> 16

    def from_bytes(self, frame_bytes):
        self.ether_type = frame_bytes[12:14]
        if self.ether_type != b'\x88\xf7':
            return False
        self.major_msgtype = frame_bytes[14]
        if self.major_msgtype & 0xf != 8:
            return False
        self.sequence_id = frame_bytes[44:46]
        self.seq_id = int.from_bytes(self.sequence_id, 'big')
        self.clock_identity = frame_bytes[34:42]
        self.source_port = frame_bytes[42:44]

        self.pot_sec_msb = int(0).to_bytes(2, 'big')
        self.pot_sec_lsb = frame_bytes[48:54]
        self.pot_mod_ns = frame_bytes[54:58]
        self.pot_ns = int.from_bytes(self.pot_sec_lsb, 'big') * 1000000000 + int.from_bytes(self.pot_mod_ns, 'big')

        self.correction_ns = int.from_bytes(frame_bytes[22:28], 'big')

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

        frame_bytes += self.pot_sec_msb
        frame_bytes += self.pot_sec_lsb
        frame_bytes += self.pot_mod_ns

        frame_bytes += self.tlvType
        frame_bytes += self.tlvLength
        frame_bytes += self.tlvorgid
        frame_bytes += self.tlvorgsub
        frame_bytes += self.cumulativeScaledRateOffset
        frame_bytes += self.gmTimeBaseIndicator
        frame_bytes += self.lastGmPhaseChange
        frame_bytes += self.scaledLastGmFreqChange

        return frame_bytes
