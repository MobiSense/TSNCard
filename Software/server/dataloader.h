#ifndef DATALOADER_H_
#define DATALOADER_H_

#include <map>
#include <vector>
#include <unordered_map>

#include "flow.hpp"
#include "bayes.hpp"

void sort_from_src_to_dst(std::vector<SCHEDULE>&);
void load_latest_log_data(std::unordered_map<int, FLOWLOG>& flow_logs,
                          std::string& latest_log_name);
void read_global_configuration(std::map<int, FLOW>& flows,
                               std::unordered_map<LINK, int>& linkCnt,
                               const std::string& latest_log_name);
void read_ip_configuration(const std::string& filename,
                           std::unordered_map<ID, std::string>& ID2PSIP);
void read_simulation_data(const std::string&,
                          std::vector<ID>&,
                          std::map<int, FLOW>&,
                          std::unordered_map<LINK, int>&,
                          std::unordered_map<int, FLOWLOG>&,
                          std::vector<ID>&, int&, int&);
void read_bayes_result(BayesProb& bayesProb);

#endif