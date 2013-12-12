#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "ppport.h"


#include <stdlib.h>
#include <stdio.h>
#include <wchar.h>
#include <gmp.h>

#include <uninum/unicode.h>
#include <uninum/nsdefs.h>
#include <uninum/uninum.h>

MODULE = Unicode::Number      PACKAGE = Unicode::Number

const char*
version()
    CODE:
        RETVAL = uninum_version();
    OUTPUT: RETVAL
