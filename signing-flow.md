From https://hackmd.io/IwNgZgnArCDGBGBaAzGYAGRAWGATR8u8yi6ApgIYTKpawBM6yQA=?both# as of Dec 28, 2016

# MIT Prototype - User/System Overview

The goal of this project is to enable the asynchronous signing of documents, by multiple parties, using decentralized identifiers. There are three primary app/service components required to develop the prototype deliverable:

- **Document Generator App** - Valcu
- **Attestation Service** - Microsoft
- **Identity Signing App** - MIT

## Use Case: Signing a Loan Document

The following are the roles and step-wise sequence that describe the user and system flows involved in accomplishing a loan document signing based on decentralized identifiers and their corresponding keys.

### Roles

- **Loan Facilitator**: party using the Document Generator App to create a loan document, and initiate signing among the required parties.
- **Signer**: The primary party responsible for the loan
- **Co-Signer**: The co-signing party accepting responsibility for the loan

### User Flow

1. The Signer and Co-Signer are each using an Identity Signing App.
2. The Identity Signing App requires a user to provide their decentralized identifier and private key in a initial setup flow, wherein it auto-generates a URL the user can circulate to receive signing requests.
3. The Signer and Co-Signer both make their identifier and signing request URL known to the Loan Facilitator.
5. The Loan Facilitator generating the loan document uses the Document Generator App to create a loan.
6. Within the loan creation flow of the Document Generator App, the Loan Facilitator is able to specify the decentralized identifiers of the Signer and Co-Signer, as well as their signing request URLs.
7. The Loan Facilitator interacts with a UI that signals they have completed document creation and are ready to send it out for signing.
8. The Document Generator App sends a loan document signing request to the Attestation Service, which specifies a callback URL the Attestation Service will use to message the Document Generator App when the process is complete.
9. The Attestation Service creates a new entry for the loan and a unique callback URL for each signer to send back their signed payload.
10. The Attestation Service sends out a request for signing to each of the identifier/URL pairs it received.
11. Identity Signing App backend receives the Attestation Service's requests at the signing request URL of each signer, which each signers instance of the Identity Signing App frontend picks up on its next polling request.
12. The Signer and Co-Signer notice a new piece of UI in their Identity Signing App that requests their signature on the loan document.
13. Their Identity Signing App displays a signing prompt UI - both the Signer and Co-Signer elect to sign
14. The signed loan data is sent back to the callback URL that was issued in the request from the Attestation Service.
15. Once the Attestation Service has received the Signer and Co-Signer's signed payloads, it verifies the signatures (by validating against the identifier public keys)
16. When all conditions are satisfied, the Attestation Service sends the signed payloads back to the callback endpoint the Document Generator App provided to it in the initial API request.
17. The Document Generator App receives the completed signing payload from the Attestation Service and uses it to finalize its processing of the loan document.

## Notes & Resources:

Once you create an identifier using Blockstack, the command `blockstack wallet` should output the private key you will need to use when signing data within the Identity Signing App.

Client-side data signing lib (provided by Blockstack): https://github.com/blockstack/jsontokens-js
