%dw 2.0

//Imports
import * from dw::Crypto
import * from dw::core::Binaries
import * from dw::core::URL

fun base64encodeURL(data) =
 toBase64(data) replace "/" with ("_") replace "+" with ("-") replace "=" with ""
 
fun generateJWT(iss, sub, tokenType, duration) = do {
	var secret = Mule::p("secure::jwt.secret") //256 bit key
	var timestamp = now() as Number
 
	var tokenHeader = {
	 alg: Mule::p("jwt.alg.tokenHeader"),
	 typ: Mule::p("jwt.typ"),
	 kid: Mule::p("jwt.kid")
	}
 
	var tokenPayload = {
	 iss: iss,
	 sub: sub,
	 token_type: tokenType,
	 iat: timestamp,
	 exp: timestamp + duration
	}
	
	var header = base64encodeURL(write(tokenHeader, "application/json"))
	var payload = base64encodeURL(write(tokenPayload, "application/json"))
 	var signature = base64encodeURL(HMACBinary(secret as Binary, (base64encodeURL(header) ++ "." ++ base64encodeURL(payload)) as Binary, Mule::p("jwt.alg.dwlScript")))
	---
	header ++ "." ++ payload ++ "." ++ signature
}

fun decodeJWT(token) = do {
	var payload = (token splitBy ".")[1]
	---
	read(fromBase64(payload),"application/json")
}

 

