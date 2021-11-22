#!/bin/sh
#
# Cloud Hook: Reinstall GovCore
#
# Run `drush site-install govcore` in the target environment.

which drush
drush --version

site="$1"
target_env="$2"

# Fresh install of GovCore.
/usr/local/bin/drush9 @$site.$target_env site-install govcore --account-pass=admin --yes
