'''
    Critical Message are used for tsn device to generate & receive packets.
'''

class CriticalMsg:
    def __init__(self, tx_ts=0, rx_ts=0, seq_id=1, pkt_id=2):
        # header
        self.dst_addr = b'\xff\xff\xff\xff\xff\xff'
        self.src_addr = b'\x01\x04\x09\x25\x36\x49'
        self.TPID = b'\x81\x00'
        self.vlan_header = b'\x40\x02'
        self.ether_length = b'\x66\xab'
        self.unused = b'\x00\x00'
        # packet information
        self.rx_timestamp = int(tx_ts).to_bytes(8, 'big')
        self.tx_timestamp = int(rx_ts).to_bytes(8, 'big')
        self.seq_id = int(seq_id).to_bytes(2, 'big')
        self.pkt_id = int(pkt_id).to_bytes(4, 'big')
        # tailer
        self.tailer = b''
        value = 18 
        while value > 0:
            self.tailer += int(value).to_bytes(1, 'big')
            value -= 1

    def from_bytes(self, frame_bytes):
        return True

    def to_bytes(self):
        frame_bytes = b''
        frame_bytes += self.dst_addr        
        frame_bytes += self.src_addr        
        frame_bytes += self.TPID            
        frame_bytes += self.vlan_header     
        frame_bytes += self.ether_length    
        frame_bytes += self.unused          
        frame_bytes += self.rx_timestamp 
        frame_bytes += self.tx_timestamp 
        frame_bytes += self.seq_id
        frame_bytes += self.pkt_id
        frame_bytes += self.tailer
        
        return frame_bytes
