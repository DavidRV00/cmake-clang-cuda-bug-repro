#include <stdbool.h>
#include <stddef.h>
#include <stdlib.h>
#include <assert.h>

#include "kernel.h"

long dot_prod(long *vecs, int dim_0, int dim_1) {
    assert(dim_0 == 2 && dim_1 > 0);
    long (*vecs_2d)[dim_1] = (void*)vecs;

    size_t size = dim_1 * sizeof(long);
    long *res = (long*) malloc(size);

    gpu_pairwise_mul(vecs_2d[0], vecs_2d[1], res, dim_1);

    long sum = 0;
    for (int i = 0; i < dim_1; ++i)
        sum += res[i];
    free(res);
    return sum;
}
