#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "ppport.h"


#include <stdlib.h>
#include <stdio.h>
#include <wchar.h>
#include <gmp.h>

#include <unicode.h>
#include <nsdefs.h>
#include <uninum.h>

MODULE = Unicode::Number      PACKAGE = Unicode::Number

const char*
version(SV *self)
    CODE:
        RETVAL = uninum_version();
    OUTPUT: RETVAL
