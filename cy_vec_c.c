#include "mex.h"
#include <math.h>

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
    double *y, *sample_Y, *H, *cy_vec;
    size_t n, i;
    
    // 获取输入参数
    y = mxGetPr(prhs[0]);
    sample_Y = mxGetPr(prhs[1]);
    H = mxGetPr(prhs[2]);
    n = mxGetN(prhs[1]);
    
    // 为输出参数分配内存
    plhs[0] = mxCreateDoubleMatrix(1, n, mxREAL);
    cy_vec = mxGetPr(plhs[0]);
    
    // 计算cy_vec
    for (i = 0; i < n; i++) {
        double diff1 = (y[0] - sample_Y[i]) / H[0];
        double diff2 = (y[1] - sample_Y[n + i]) / H[1];
        cy_vec[i] = pow(2*M_PI, -0.5) * exp(-0.5 * (diff1 * diff1 + diff2 * diff2));
    }
}
