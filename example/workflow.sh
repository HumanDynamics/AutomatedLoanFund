#!/bin/sh

# Lender: Create loanTerm
# Lender: Sign loan
gpg -u dev@alfa.media.mit.edu --sign -a lender-alfa/jwalsh-offer-20161128.json

# Application: Synchronize data store
ln -s ../lender-alfa/jwalsh-offer-20161128.json.asc .

# Borrower: Verify loan
gpg --verify borrower-jwalsh/jwalsh-offer-20161128.json.asc

# Application: Proxy multiple signatures and overwrite
gpg -u j@wal.sh -u dev@alfa.media.mit.edu --sign -a jwalsh-offer-20161128.json

# Creditor: verify loan agreement
