/* https://swig.org/tutorial.html */

;%module myclib
%{
#define SWIG_FILE_WITH_INIT
/* Put header files here or function declarations like below */
#include "myclib/include/myclib.h"

%}

%include "numpy.i"

%init %{
import_array();
%}

%apply (long* IN_ARRAY2, int DIM1, int DIM2) {(long *vecs, int dim_0, int dim_1)}
%include "myclib/include/myclib.h"

