#include "mex.h"
#include <math.h>

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
    double *X, *Y, *cx, *cx_vecsimpl, *sample_Y, *H, *h, *f;
    size_t n, m, sample_Y_cols;

    // 获取输入参数
    X = mxGetPr(prhs[0]);
    Y = mxGetPr(prhs[1]);
    cx = mxGetPr(prhs[2]);
    cx_vecsimpl = mxGetPr(prhs[3]);
    sample_Y = mxGetPr(prhs[4]);
    H = mxGetPr(prhs[5]);
    h = mxGetPr(prhs[6]);

    n = mxGetM(prhs[0]); // 获取X的行数
    m = mxGetN(prhs[0]); // 获取X的列数
    sample_Y_cols = mxGetN(prhs[4]); // 获取sample_Y的列数

    mexPrintf("Values of sample_Y:\n");
    for (size_t idx = 0; idx < 2; idx++) {
        for (size_t k = 0; k < sample_Y_cols; k++) {
            mexPrintf("%f ", sample_Y[idx + k*2]); // 使用线性索引访问元素
        }
        mexPrintf("\n");
    }


    // 为输出参数分配内存
    plhs[0] = mxCreateDoubleMatrix(n, m, mxREAL);
    f = mxGetPr(plhs[0]);

    double prod_H = H[0] * H[1];
    double prod_h = h[0] * h[1];

    for (size_t i = 0; i < n; i++) {
        for (size_t j = 0; j < m; j++) {
            // double y[2];
            // // y[0] = X[i + j*n];
            // // y[1] = Y[i + j*n];
            // y[0] = X[i*n + j];  
            // y[1] = Y[i*n + j];

            double y[2][sample_Y_cols];
            for (size_t k = 0; k<sample_Y_cols; k++){
                y[0][k] = X[i + j*n];
                y[1][k] = Y[i + j*n];
            }
            for (size_t idx = 0; idx < 2; idx++) {
                for (size_t k = 0; k < sample_Y_cols; k++) {
                    mexPrintf("y: %f ", y[idx][k]);
                }
                mexPrintf("\n");
            }


            double cy_vec[2][sample_Y_cols];

            for (size_t k = 0; k < sample_Y_cols; k++) {
                double diff1 = (y[0] - sample_Y[k]) / H[0];
                double diff2 = (y[1] - sample_Y[k + sample_Y_cols]) / H[1];
                cy_vec[0][k] = pow(2 * M_PI, -0.5) * exp(-0.5 * diff1 * diff1);
                cy_vec[1][k] = pow(2 * M_PI, -0.5) * exp(-0.5 * diff2 * diff2);
            }

            mexPrintf("Values of cy_vec:\n");
            for (size_t idx = 0; idx < 2; idx++) {
                for (size_t k = 0; k < sample_Y_cols; k++) {
                    mexPrintf("%f ", cy_vec[idx][k]);
                }
                mexPrintf("\n");
            }


            double cy_vecsimpl[sample_Y_cols];
            for (size_t k = 0; k < sample_Y_cols; k++) {
                cy_vecsimpl[k] = cy_vec[0][k] * cy_vec[1][k];
            }

            double sum_val = 0;
            for (size_t k = 0; k < sample_Y_cols; k++) {
                sum_val += cx_vecsimpl[k] * cy_vecsimpl[k];
            }

            f[i + j*n] = pow(prod_H * prod_h, -1) * sum_val * pow(prod_h * cx[0], -1);
        }
    }
}
