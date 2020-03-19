SETTINGS=settings.env
LOCALSETTINGS=local-settings.env

set -a

. ./settings.env
. ./local-settings.env

set +a

emacs -l ./etc/boot.el
