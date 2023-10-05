#include "mex.h"
#include <math.h>

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
    double *X, *Y, *cx, *cx_vecsimpl, *sample_Y, *H, *h, *f;
    size_t n, m, i, j, k, sample_Y_cols;
    int length_X = 2, length_Y = 2, length_cx_vecsimpl = 2, length_sample_Y = 2; // 假设长度为2，你应该使用实际的长度


    // 获取输入参数
    X = mxGetPr(prhs[0]);
    
    Y = mxGetPr(prhs[1]);
    cx = mxGetPr(prhs[2]);
    cx_vecsimpl = mxGetPr(prhs[3]);
    sample_Y = mxGetPr(prhs[4]);
    H = mxGetPr(prhs[5]);
    h = mxGetPr(prhs[6]);

    mexPrintf("Values of X: ");
    for(int i = 0; i < length_X; i++) {
        mexPrintf("%f ", X[i]);
    }
    mexPrintf("\n");

    mexPrintf("Values of Y: ");
    for(int i = 0; i < length_Y; i++) {
        mexPrintf("%f ", Y[i]);
    }
    mexPrintf("\n");

    mexPrintf("Value of cx: %f\n", *cx);

    mexPrintf("Values of cx_vecsimpl: ");
    for(int i = 0; i < length_X; i++) {
        mexPrintf("%f ", cx_vecsimpl[i]);
    }
    mexPrintf("\n");

    mexPrintf("Values of sample_Y: ");
    for(int i = 0; i < length_sample_Y; i++) {
        mexPrintf("%f ", sample_Y[i]);
    }
    mexPrintf("\n");

    mexPrintf("Values of H: ");
    for(int i = 0; i < length_Y; i++) {
        mexPrintf("%f ", H[i]);
    }
    mexPrintf("\n");
    
    mexPrintf("Values of h: ");
    for(int i = 0; i < length_Y; i++) {
        mexPrintf("%f ", h[i]);
    }
    mexPrintf("\n");
   

    n = mxGetN(prhs[0]); // 获取X的行数

    mexPrintf("Columns  of n: %zu\n", n);
    
    m = mxGetN(prhs[1]); // 获取X的列数
    mexPrintf("Columns  of m: %zu\n", m);
    
    sample_Y_cols = mxGetM(prhs[4]); // 获取sample_Y的列数
    mexPrintf("Columns  of sample_Y: %zu\n", sample_Y_cols);
    mexPrintf("\n");
    

    // 为输出参数分配内存
    plhs[0] = mxCreateDoubleMatrix(n, m, mxREAL);
    f = mxGetPr(plhs[0]);
    
    for (i = 0; i < n; i++) {
        for (j = 0; j < m; j++) {
            double y[2];
            y[0] = X[i + j*n];
            y[1] = Y[i + j*n];

            double cy_vec[sample_Y_cols];
            for (k = 0; k < sample_Y_cols; k++) {
                double diff1 = (y[0] - sample_Y[k]) / H[0];
                double diff2 = (y[1] - sample_Y[k + sample_Y_cols]) / H[1];
                cy_vec[k] = pow(2*M_PI, -0.5) * exp(-0.5 * (diff1 * diff1 + diff2 * diff2));
            }

            double cy_vecsimpl = 1;
            for (k = 0; k < sample_Y_cols; k++) {
                cy_vecsimpl *= cy_vec[k];
            }

            f[i + j*n] = pow((H[0] * H[1] * h[0] * h[1]), -1) * (cx_vecsimpl[0] * cy_vecsimpl) * pow((h[0] * h[1] * cx[0]), -1);
        }
    }
}
