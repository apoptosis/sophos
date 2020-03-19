SETTINGS=settings.env
LOCALSETTINGS=local-settings.env

set -a

. ./settings.env
. ./local-settings.env

set +a

emacs --script ./etc/boot.el
