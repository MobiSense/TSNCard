#ifndef BAYES_H_
#define BAYES_H_

#include <vector>
#include "../Utils/utils.hpp"

class BayesProb {
public:
    BayesProb(int N, int M) {
        nodeCnt = N;
        flowCnt = M;
        P.resize(nodeCnt * nodeCnt * flowCnt, 0.0);
        Q.resize(flowCnt * flowCnt * nodeCnt, 0.0);
    }

    ~BayesProb() {
        P.clear();
        Q.clear();
    }

    double get_P(ID y, ID x, int flow_id) const { return P[int(y) * nodeCnt * flowCnt + int(x) * flowCnt + flow_id]; }
    double get_Q(int v, int u, ID s)       const { return Q[v * flowCnt * nodeCnt + u * nodeCnt + int(s)]; }
    void set_P(ID y, ID x, int flow_id, double value) { P[int(y) * nodeCnt * flowCnt + int(x) * flowCnt + flow_id] = value; }
    void set_Q(int v, int u, ID s, double value)       { Q[v * flowCnt * nodeCnt + u * nodeCnt + int(s)] = value; }

// private:
    int nodeCnt, flowCnt;
    std::vector<double> P;
    std::vector<double> Q;
};

#endif