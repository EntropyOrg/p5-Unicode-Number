
MODULE = Unicode::Number::System      PACKAGE = Unicode::Number::System

SV*
_new(const char* class, int ns, char* string)
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

