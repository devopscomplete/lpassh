# lpassh
LastPass SSH Script

These scripts read a private key from a LastPass Secure Note of type _SSH Key_
 and pass it into ssh.  This allows you to keep PEM files off your machine for
 security reasons.

## Usage
`lpassh <SecureNoteName> <user@host>`

Anything after the _SecureNoteName_ will be passed into _ssh_ as parameters.

## Installation

Copy _lpassh_(_lpassh.fish_ for Fish) into your path and mark as executable `chmod +x lpassh`
