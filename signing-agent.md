# Digital Signature via Browser

This piece of writing aims to discuss the challenges in implementing a browser based digital signature interface, recommend ways in which it can be tackled, using existing standards and technologies as is and deriving in certain other cases.

It focuses primarily on the process of signing. Verification of the signature will be covered in another piece.

---

### Automated Loan Fund Diagram:
![alt tag](https://cdn.rawgit.com/akshithg/AutomatedLoanFund/master/alfa-1.png)

In the above diagram, every step which involves signing requires the party to interact with a browser/app to be able to digitally sign as a way to attest/prove ones identity.

### Digital Signature
![alt tag](https://cdn.rawgit.com/akshithg/AutomatedLoanFund/doc/browser_digital_sign/Digital_Signature_diagram.svg)

As shown in the diagram this involves the singing party's private key. Private keys should **never** be shared. Thus we should never load it into the web browser's environment for signing. The way we can approach this is, let the browser share the data that is to be signed to an agent on the user's device. This agent has the following functions:

1. Receive the data to be digitally signed.
2. Sign the data
3. Return the signature.

Refer:

- [The FIDO (Fast IDentity Online) Alliance](https://fidoalliance.org/specifications/overview/)
- [The FIDO standalone Server](https://developers.yubico.com/U2F/Standalone_servers/)

---

### Receiving the data.
The main challenge here is to standardize how a web page can signify/indicate to the browser that one or more elements need to be digitally signed.

A very basic way would be to use a tag to specify this:
```
<sign href="/path/of/the/file/to/be/signed.pdf"> Please sign this document </sign>
```
The extension/plugin in the browser will be able to pick these elements and pass it on to the signing agent on the user's device via an rpc interface.

We can derive a lot from [Metamask](https://metamask.io/) to achieve this.
Metamask is a browser plugin that acts a bridge between the browser and the Ethereum node. It lets to send ether via the browser besides many other features.

Now the agent will be able load the file from the url specified in the payload that was received from the browser.

> Cases of the file being malicious, and how do we handle such security issues is out of scope. Will be looked into separately.

### Signing the data
The challenge in this step is how do we handle key storage.
Storing the key file as any other regular file is very insecure and highly not recommend. It can be compromised easily.

The two popular standards are:
[Hardware security module](https://en.wikipedia.org/wiki/Hardware_security_module)
[Trusted Platform Module](https://en.wikipedia.org/wiki/Trusted_Platform_Module)

But these are hardly ubiquitous and very rare among normal users.

An alternative solution is to look into:
- [Bitcoin Hardware wallets](https://en.bitcoin.it/wiki/Hardware_wallet)
- [U2F devices](https://www.yubico.com/about/background/fido/)

This provides us with a certain level of security to safeguard the private keys we use and for computing the signature in provable secure environment.

### Returning the signature
We make use of the same request client, Metamask like plugin to return the signature that was computed.
