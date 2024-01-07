%dw 2.0

// Imports
import * from dw::Crypto
import * from dw::core::Binaries

fun hashPassword(password) = do {
	var secret = Mule::p("secure::password.secret")
	var hashedPassword = HMACBinary(secret as Binary, password as Binary, Mule::p("password.alg.dwlScript"))
	---
	toBase64(hashedPassword)
}

fun comparePasswords(savedPassword, enteredPassword) = do {
	var hashedPassword = hashPassword(enteredPassword)
	---
	savedPassword == hashedPassword
}