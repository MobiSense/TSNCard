import socket
import time
import threading
from PdelayRespMsg import PdelayRespMsg
from PdelayReqMsg import PdelayReqMsg
from PdelayRespFollowupMsg import PdelayRespFollowupMsg
from SyncMsg import SyncMsg
from FollowUpMsg import FollowUpMsg


SEC_NS = 1000000000


s = socket.socket(socket.AF_PACKET, socket.SOCK_RAW)
s.bind(('enx000ec674f78b', socket.PACKET_MULTICAST | socket.PACKET_HOST | socket.PACKET_OTHERHOST))
send_lock = threading.Lock()
ts_dict = {'prop': 0}
ts_lock = threading.Lock()
sync_dict = {}
sync_lock = threading.Lock()


def PdelayResp():
    while True:
        message = s.recv(4096)
        receipt_ts = time.time_ns()
        # print(message)
        # print(message.decode('hex'))
        # import pdb; pdb.set_trace()
        pdelayreqmsg = PdelayReqMsg(0)
        rc_pdelayresp = PdelayRespMsg(b'\x00\x00', 0, 8 * b'\x00', int(1).to_bytes(2, 'big'))
        rc_pdelayrespfu = PdelayRespFollowupMsg(b'\x00\x00', 0, 8 * b'\x00', int(1).to_bytes(2, 'big'))
        rc_sync = SyncMsg(0)
        rc_followup = FollowUpMsg(0, 0)
        if pdelayreqmsg.from_bytes(message):
            # print(pdelayreqmsg.ether_type)
            # print(receipt_ts)
            print("Pdelay Req.")
            pdelayrespmsg = PdelayRespMsg(
                sequence_id_bytes=pdelayreqmsg.sequence_id,
                req_rec_ts=receipt_ts,
                req_clock_identity=pdelayreqmsg.clock_identity,
                req_port_bytes=pdelayreqmsg.source_port
            )
            send_lock.acquire()
            try:
                s.send(pdelayrespmsg.to_bytes())
            finally:
                send_lock.release()
            resp_origin_ts = time.time_ns()
            pdelayrespfupmsg = PdelayRespFollowupMsg(
                sequence_id_bytes=pdelayreqmsg.sequence_id,
                resp_origin_ts=resp_origin_ts,
                req_clock_identity=pdelayreqmsg.clock_identity,
                req_port_bytes=pdelayreqmsg.source_port
            )
            send_lock.acquire()
            try:
                s.send(pdelayrespfupmsg.to_bytes())
            finally:
                send_lock.release()
        elif rc_pdelayresp.from_bytes(message):
            print("PdelayResp")
            ts_lock.acquire()
            ts_dict[rc_pdelayresp.seq_id]['t4'] = receipt_ts
            ts_dict[rc_pdelayresp.seq_id]['t2'] = rc_pdelayresp.t2
            ts_lock.release()
        elif rc_pdelayrespfu.from_bytes(message):
            print("PdelayRespFollowup")
            ts_lock.acquire()
            ts_dict[rc_pdelayrespfu.seq_id]['t3'] = rc_pdelayrespfu.t3
            seq_id = rc_pdelayrespfu.seq_id
            # FIXME: key error when access t1. may be bug from hardware side.
            try:
                prop_time = ((ts_dict[seq_id]['t4'] - ts_dict[seq_id]['t1']) - (ts_dict[seq_id]['t3'] - ts_dict[seq_id]['t2'])) / 2
            except Exception:
                print ("seq_id = {}".format(seq_id))
                import pdb; pdb.set_trace()
            ts_dict['prop'] = prop_time
            print("Prop time: ", hex(int(prop_time)))
            ts_lock.release()
        elif rc_sync.from_bytes(message):
            print("Sync")
            sync_lock.acquire()
            sync_dict[rc_sync.seq_id] = {}
            sync_dict[rc_sync.seq_id]['sync_receipt_ts'] = receipt_ts
            sync_lock.release()
        elif rc_followup.from_bytes(message):
            print("Followup")
            sync_lock.acquire()
            sync_dict[rc_followup.seq_id]['sync_origin_ts'] = rc_followup.pot_ns
            sync_dict[rc_followup.seq_id]['correction_ns'] = rc_followup.correction_ns
            sync_receipt_sync_time = rc_followup.pot_ns + rc_followup.correction_ns + ts_dict['prop']
            sync_receipt_local_time = sync_dict[rc_followup.seq_id]['sync_receipt_ts']
            offset = sync_receipt_sync_time - sync_receipt_local_time
            current_sync_ts = time.time_ns() + offset
            print(sync_dict)
            print("Current sync time: ", current_sync_ts // 1000000000, "sec, ", current_sync_ts % 1000000000, "ns.")
            print("Sync time: 0x{0:0x}".format(int(current_sync_ts)))
            sync_lock.release()


def PdelayReq():
    seq_id = 33
    while True:
        print ("Sending req at seq_id {}".format(seq_id))
        pdelayreqmsg = PdelayReqMsg(seq_id)
        ts_lock.acquire()
        ts_dict[seq_id] = {}
        ts_lock.release()
        send_lock.acquire()
        try:
            s.send(pdelayreqmsg.to_bytes())
            ts_lock.acquire()
            ts_dict[seq_id]['t1'] = time.time_ns()
            ts_lock.release()
        finally:
            send_lock.release()
        seq_id += 1
        time.sleep(1)


def SyncSend():
    sync_id = 333
    start_ns = time.time_ns() - 900 * SEC_NS
    while True:
        sync_msg = SyncMsg(sync_id)
        s.send(sync_msg.to_bytes())
        sync_origin = time.time_ns() - start_ns
        print ("current local time in {}".format(hex(sync_origin)))
        fup_msg = FollowUpMsg(sync_id, sync_origin)
        s.send(fup_msg.to_bytes())
        sync_id += 1
        time.sleep(1)


if __name__ == '__main__':
    t1 = threading.Thread(target=PdelayResp)
    t1.start()
    t2 = threading.Thread(target=PdelayReq)
    t2.start()
    t3 = threading.Thread(target=SyncSend)
    t3.start()
    t1.join()
    t2.join()
    t3.join()

