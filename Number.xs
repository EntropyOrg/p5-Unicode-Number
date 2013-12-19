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

typedef HV* Unicode__Number;
typedef HV* Unicode__Number__System;

const char* uninum_error_str() {
	switch(uninum_err) {
		case NS_ERROR_OKAY:                  return "No error";
		case NS_ERROR_BADCHARACTER:          return "String contains illegal character";
		case NS_ERROR_DOESNOTFIT:            return "Value does not fit into binary type";
		case NS_ERROR_NUMBER_SYSTEM_UNKNOWN: return "The number system identifier is unknown";
		case NS_ERROR_BADBASE:               return "The specified base is not acceptable";
		case NS_ERROR_NOTCONSISTENTWITHBASE: return "The string contains a digit too large for the base";
		case NS_ERROR_OUTOFMEMORY:           return "Storage allocation failed";
		case NS_ERROR_RANGE:                 return "Number is larger than is representable in the number system";
		case NS_ERROR_OUTSIDE_BMP:           return "The string contains a character outside the BMP";
		case NS_ERROR_NOZERO:                return "The number system cannot represent zero";
		case NS_ERROR_ILLFORMED:             return "The string is not a valid number in the specified number system for a reason other than one of those specified above, e.g. it lacks a required number marker.";
	}
	return "Invalid error";
}


int uninum_is_ok() {
	return uninum_err == NS_ERROR_OKAY;
}

MODULE = Unicode::Number      PACKAGE = Unicode::Number

const char*
version(Unicode::Number self)
	CODE:
		RETVAL = uninum_version();
	OUTPUT: RETVAL

# retrieves number systems as an array
# and caches the result
AV*
list_number_systems(Unicode::Number self)
	INIT:
		AV* l;
		char* ns_str;
		int ns_num;
		size_t len;
		AV** ref;
		int which;
		int count;
	CODE:
		if( NULL == (ref = (AV**)hv_fetchs(self, "_list_ns_cache", 0)) ) {
			/* not cached yet */
			l = (AV *)sv_2mortal((SV *)newAV());
			/* which = 1 : get all number systems that can be used in both
			 *             directions
			 * which = 0 : get number systems that can only be used from string
			 *             to numbers
			 */
			for(which = 0; which <= 1; which++ ) {
				while (ns_str = ListNumberSystems(1,which)) {
					HV * rh;
					rh = (HV *)sv_2mortal((SV *)newHV());

					/* get the ID for the number system */
					ns_num = StringToNumberSystem(ns_str);

					dSP;
					ENTER;
					SAVETMPS;
					PUSHMARK(SP);
					XPUSHs(sv_2mortal(newSVpv(ns_str, len)));
					XPUSHs(sv_2mortal(newSViv(ns_num)));
					XPUSHs(sv_2mortal(newSViv( !which )));
					PUTBACK;
					count = call_pv("Unicode::Number::System::_new", G_SCALAR);
					SPAGAIN;
					if (count != 1)
						croak("Big trouble\n");
					rh = SvREFCNT_inc(POPs);
					PUTBACK;
					FREETMPS;
					LEAVE;


					av_push(l, newRV((SV *)rh)); /* and add to list */
				}
				ListNumberSystems(0,0); /* Reset */
			}
			SV* l_ref = newRV((SV *)l);
			SvREFCNT_inc((SV*) l);
			hv_stores(self, "_list_ns_cache", (SV*)l);
			ref = &l;
		}
		RETVAL = (AV*)SvREFCNT_inc(*ref);
	OUTPUT: RETVAL

MODULE = Unicode::Number      PACKAGE = Unicode::Number::System

Unicode::Number::System
_new(const char* class, char* ns_str, int ns_num, int both_dir)
	INIT:
		Unicode__Number__System hash;
	CODE:
		hash = newHV(); /* Create a hash */

		/* Create a reference to the hash */
		SV *const self = newRV_noinc( (SV *)hash );
		/* store in hash { s => $str, n => $id } */
		len = strlen(ns_str);
		hv_stores(hash, "s", newSVpv(ns_str, len));
		hv_stores(hash, "n", newSViv(ns_num));
		hv_stores(hash, "both_dir", newSViv( both_dir ));

		/* bless into the proper package */
		RETVAL = sv_bless( self, gv_stashpv( class, 0 ) );
	OUTPUT: RETVAL


const char*
name(const char* class)
	CODE:
		RETVAL = "test";
	OUTPUT: RETVAL

