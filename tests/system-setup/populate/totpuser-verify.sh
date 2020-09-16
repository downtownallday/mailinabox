#!/bin/bash

. "$(dirname "$0")/../setup-defaults.sh" || exit 1
. "$(dirname "$0")/../../lib/all.sh" "$(dirname "$0")/../../lib" || exit 1
. "$(dirname "$0")/totpuser-data.sh" || exit 1

. /etc/mailinabox.conf || exit 1
. "${STORAGE_ROOT}/ldap/miab_ldap.conf" || exit 1


die() {
    echo "$1"
    exit 1
}

. "$MIAB_DIR/setup/functions-ldap.sh" || exit 1


# the user's ldap entry contains the TOTP secret
# 
# other tests verify the functioning of totp - just make sure the totp
# secret was migrated
#
get_attribute "$LDAP_USERS_BASE" "(&(mail=$TEST_USER)(objectClass=totpUser))" "totpSecret"
if [ -z "$ATTR_DN" ]; then
	echo "totpUser objectClass and secret not present"
    exit 1
fi

if [ "$ATTR_VALUE" != "$TEST_USER_TOTP_SECRET" ]; then
    echo "totpSecret mismatch"
    exit 1
fi

echo "OK totpuser-verify passed"
exit 0
