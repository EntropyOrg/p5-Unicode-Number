/* vim: ts=4 sw=4
 */
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

SV*
list_number_systems(SV* self)
	INIT:
		AV* l;
		char* ns_str;
		int ns_num;
		size_t len;
	CODE:
		l = (AV *)sv_2mortal((SV *)newAV());
		while (ns_str = ListNumberSystems(1,0)) {
			HV * rh;
			rh = (HV *)sv_2mortal((SV *)newHV());
			ns_num = StringToNumberSystem(ns_str);
			len = strlen(ns_str);
			hv_stores(rh, "s", newSVpv(ns_str, len));
			hv_stores(rh, "n", newSViv(ns_num));
			av_push(l, newRV((SV *)rh));
		}
		ListNumberSystems(0,0); /* Reset */
		RETVAL = newRV((SV *)l);
	OUTPUT: RETVAL
