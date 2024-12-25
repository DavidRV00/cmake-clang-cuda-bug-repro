#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>

#include "kernel.h"

__global__ void _gpu_pairwise_mul(long *a, long *b, long *res) {
    int i = threadIdx.x;
    res[i] = a[i] * b[i];
}

extern "C" void gpu_pairwise_mul(long *a, long *b, long *res, int n_elems) {
    size_t size = n_elems * sizeof(long);

    long *cuda_a = 0;
    long *cuda_b = 0;
    long *cuda_res = 0;

    cudaMalloc(&cuda_a, size);
    cudaMalloc(&cuda_b, size);
    cudaMalloc(&cuda_res, size);

    cudaMemcpy(cuda_a, a, size, cudaMemcpyHostToDevice);
    cudaMemcpy(cuda_b, b, size, cudaMemcpyHostToDevice);

    _gpu_pairwise_mul<<<1, n_elems>>>(cuda_a, cuda_b, cuda_res);
    cudaMemcpy(res, cuda_res, size, cudaMemcpyDeviceToHost);

    cudaFree(cuda_a);
    cudaFree(cuda_b);
    cudaFree(cuda_res);
}
