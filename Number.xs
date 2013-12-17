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

char* uninum_err_str[256];
uninum_err_str[NS_ERROR_OKAY]                  = "No error";
uninum_err_str[NS_ERROR_BADCHARACTER]          = "String contains illegal character";
uninum_err_str[NS_ERROR_DOESNOTFIT]            = "Value does not fit into binary type";
uninum_err_str[NS_ERROR_NUMBER_SYSTEM_UNKNOWN] = "The number system identifier is unknown";
uninum_err_str[NS_ERROR_BADBASE]               = "The specified base is not acceptable";
uninum_err_str[NS_ERROR_NOTCONSISTENTWITHBASE] = "The string contains a digit too large for the base";
uninum_err_str[NS_ERROR_OUTOFMEMORY]           = "Storage allocation failed";
uninum_err_str[NS_ERROR_RANGE]                 = "Number is larger than is representable in the number system";
uninum_err_str[NS_ERROR_OUTSIDE_BMP]           = "The string contains a character outside the BMP";
uninum_err_str[NS_ERROR_NOZERO]                = "The number system cannot represent zero";
uninum_err_str[NS_ERROR_ILLFORMED]             = "The string is not a valid number in the specified number system for a reason other than one of those specified above, e.g. it lacks a required number marker.";

int uninum_is_ok() {
	return uninum_err == NS_ERROR_OKAY;
}

const char* uninum_error_str() {
	return uninum_err_str[uninum_err];
}


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
		l = (AV *)sv_2mortal((SV *)newAV());
		char* ns_str;
		int ns_num;
	CODE:
		while (ns_str = ListNumberSystems(1,0)) {
			HV * rh;
			rh = (HV *)sv_2mortal((SV *)newHV());
			ns_num = StringToNumberSystem(ns_str);
			hv_stores(rh, "s", newSVpv(ns_str));
			hv_stores(rh, "n", newSViv(ns_num));
			av_push(l, newRV((SV *)rh));
		}
		ListNumberSystems(0,0); /* Reset */
		RETVAL = newRV((SV *)l);
	OUTPUT: RETVAL

MODULE = Unicode::Number::System      PACKAGE = Unicode::Number::System

SV*
new(int ns, char* string)
	CODE:
		HV* hash = newHV(); /* Create a hash */

		/* Create a reference to the hash */
		SV *const self = newRV_noinc( (SV *)hash );

		/* bless into the proper package */
		RETVAL = sv_bless( self, gv_stashpv( class, 0 ) );
	OUTPUT: RETVAL


const char*
name(const char* class)
	CODE:
		RETVAL = "test";
	OUTPUT: RETVAL

