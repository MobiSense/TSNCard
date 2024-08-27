class Flow:
    TransT = 1

    def __init__(self, i, k, src, dst, flow_period, MD):
        # The k-th flow if the i-th job of type
        self.i = i  # i is always 0 for pure traffic scheduling
        self.k = k
        self.src = src
        self.dst = dst
        self.period = flow_period
        self.MD = MD
        # TransT shall be 13(120us) under 100Mbps, 1(12us) under 1000Mbps. unit: 2^14ns 
        self.trans_t = Flow.TransT  # The flow only contains one frame. unit: 16.384us
        
    def __str__(self):
        return f"flow_id: {self.k}, src: {self.src}, dst: {self.dst}, period: {self.period}, MD: {self.period}"

    @staticmethod
    def get_n_mtu():
        return Flow.TransT // 13
    
    @staticmethod
    def ring6_flows():
        flows = [Flow(i = 0, k = i, src = i, dst = (i + 2) % 6, flow_period = 12, MD = 6)
                 for i in range(6)]
        return flows
