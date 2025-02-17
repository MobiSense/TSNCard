#include <string.h>
#include <stdio.h>
#include "ptp_types.h"

void ptp_msg_header_template(PTPMsgHeader *head, PTPMsgType msgtype, uint16_t len,
			PortIdentity *portId, uint16_t seqid, int8_t logMessageInterval, int64_t correction)
{
	head->majorSdoId=1; 
	head->messageType=msgtype;
	head->minorVersionPTP=0;
	head->versionPTP=2;
	head->messageLength=len;
	head->domainNumber=0;
	head->minorSdoId=0;
	head->flags[0]=0x2;
	head->flags[1]=0x0;
	head->correctionField=correction;
	memset(head->messageTypeSpecific,0,4);
	memcpy(&head->sourcePortIdentity, portId, sizeof(PortIdentity));
	head->sequenceId=seqid;
	switch(msgtype){
	case SYNC:
		head->controlField=0x0;
		break;
	case FOLLOW_UP:
		head->controlField=0x2;
		break;
	default:
		head->controlField=0x5;
		break;
	}
	head->logMessageInterval=logMessageInterval;
}

UScaledNs uscaledns_subtract(UScaledNs t1, UScaledNs t2) {
	uint8_t borrow;
	UScaledNs r;
	if (t1.subns >= t2.subns) {
		r.subns = t1.subns - t2.subns;
		borrow = 0;
	} else {
		r.subns = t1.subns - t2.subns;
		borrow = 1;
	}
	if (t1.nsec == 0 && borrow == 1) {
		r.nsec = (uint64_t)0xFFFFFFFFFFFFFFFF - t2.nsec;
		borrow = 1;
	} else if (t1.nsec - borrow >= t2.nsec) {
		r.nsec = t1.nsec - borrow - t2.nsec;
		borrow = 0;
	} else {
		r.nsec = t1.nsec - borrow - t2.nsec;
		borrow = 1;
	}
	if (t1.nsec_msb == 0 && borrow == 1) {
		r.nsec_msb = (uint16_t)0xFFFF - t2.nsec_msb;
		borrow = 1;
	} else if (t1.nsec_msb - borrow >= t2.nsec_msb) {
		r.nsec_msb = t1.nsec_msb - borrow - t2.nsec_msb;
		borrow = 0;
	} else {
		r.nsec_msb = t1.nsec_msb - borrow - t2.nsec_msb;
		borrow = 1;
	}
	return r;
}

static int check_overflow(uint64_t a, uint64_t b, uint8_t carry) {
    uint64_t s = a + b + carry;
    if (carry == 0) {
        if (s < a) {
            return 1;
        } else {
            return 0;
        }
    } else {
        if (s > a) {
            return 0;
        } else {
            return 1;
        }
    }
}

UScaledNs uscaledns_add(UScaledNs t1, UScaledNs t2) {
	uint8_t c;
	UScaledNs r;
	uint64_t temp;

	temp = (uint64_t)t1.subns + t2.subns;
	c = (temp >= 0xFFFF) ? 1: 0;
	r.subns = temp & 0xFFFF;
	
	temp = t1.nsec + t2.nsec + c;
	c = check_overflow(t1.nsec, t2.nsec, c);
	r.nsec = temp;

	temp = t1.nsec_msb + t2.nsec_msb + c;
	r.nsec_msb = temp;
	return r;
}

UScaledNs uscaledns_divide_by_2(UScaledNs t) {
	UScaledNs r;
	r.subns = t.subns >> 1;
	if (t.nsec & 0x1) {
		r.subns = r.subns | 0x8000;
	}
	r.nsec = t.nsec >> 1;
	if (t.nsec_msb & 0x1) {
		r.nsec = r.nsec | 0x8000000000000000;
	}
	r.nsec_msb = t.nsec_msb >> 1;
	return r;
}

void print_uscaledns(UScaledNs t) {
	uint64_t *ns_h, *ns_l;
	ns_l = &t.nsec;
	ns_h = ns_l + 1;
	printf("%04X ns_msb ", t.nsec_msb);
	printf("%08X %08X ns ", *ns_h, *ns_l);
	printf("%04X subns\r\n", t.subns);
}


int uscaledns_compare(UScaledNs t1, UScaledNs t2) {
	if(t1.nsec_msb > t2.nsec_msb) {
		return 1;
	} else if (t1.nsec_msb < t2.nsec_msb) {
		return -1;
	} else if (t1.nsec > t2.nsec) {
		return 1;
	} else if (t1.nsec < t2.nsec) {
		return -1;
	} else if (t1.subns > t2.subns) {
		return 1;
	} else if (t1.subns < t2.subns) {
		return -1;
	} else {
		return 0;
	}
}

uint64_t uint64_uscaledns(UScaledNs t) {
	uint64_t r;
	r = t.subns;
	r = r | (t.nsec << 16);
	return r;
}

UScaledNs uscaledns_uint64(uint64_t t) {
	UScaledNs r;
	r.nsec_msb = 0;
	r.subns = t & 0xFFFF;
	r.nsec = t >> 16;
	return r;
}

int portIdentityEqual(PortIdentity pi1, PortIdentity pi2) {
	bool check1 = !memcmp(pi1.clockIdentity, pi2.clockIdentity, 8);
	bool check2 = pi1.portNumber == pi2.portNumber;
	return check1 && check2;
}

UScaledNs uscaledns_ptpmsgtimestamp(PTPMsgTimestamp ptpmsgts) {
	// TODO this is incomplete. But it is enough for tens of years.
	UScaledNs r;
	r.nsec_msb = 0;
	r.nsec = (uint64_t)ptpmsgts.seconds_lsb * 1000000000 + ptpmsgts.nanoseconds;
	r.subns = 0;
	return r;
}

PTPMsgTimestamp ptpmsgtimestamp_uscaledns(UScaledNs usns) {
	PTPMsgTimestamp r;
	r.seconds_msb = 0;
	r.seconds_lsb = usns.nsec / 1000000000;
	r.nanoseconds = usns.nsec % 1000000000;
	return r;
}

void set_default_clock_identity(uint8_t *clock_identity) {
	uint32_t *clock_identity_l, *clock_identity_h;
	clock_identity_l = (uint32_t*) clock_identity;
	clock_identity_h = clock_identity_l + 1;
	*clock_identity_l = DEFAULT_CLOCK_IDENTITY_L;
	*clock_identity_h = DEFAULT_CLOCK_IDENTITY_H;
}

PTPMsgTimestamp ptpmsgtimestamp_extendedtimestamp(ExtendedTimestamp ts) {
	return ptpmsgtimestamp_uscaledns((UScaledNs)ts);
}