#ifndef CONFIG_H
#define CONFIG_H

#include <vector>

extern int INPUT_STREAM_NUM;
extern std::vector<uint32_t> input_seq_ids;
extern int OUTPUT_STREAM_NUM;
extern std::vector<uint32_t> output_seq_ids;
extern std::vector<char*> output_dst_addresses;
extern char* output_src_address;
extern uint32_t CYCLE_TIME;
extern uint32_t COMPUTE_OFFSET;
extern uint32_t COMPUTE_TIME;
void init_configure();
#endif
