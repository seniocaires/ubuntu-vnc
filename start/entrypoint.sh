#!/bin/bash
set -e

source $HOME/.bashrc

cleanup () {
    kill -s SIGTERM $!
    exit 0
}
trap cleanup SIGINT SIGTERM

IP_HOST=$(hostname -i)

echo "Definindo a senha do servidor VNC ..."
mkdir -p "$HOME/.vnc"
PATH_SENHA="$HOME/.vnc/passwd"
if [[ $VIEW_ONLY == "true" ]]; then
    echo "Iniciando Servidor VNC no modo VIEW ONLY ..."
    echo $(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 20) | vncpasswd -f > $PATH_SENHA
fi
echo "$SENHA" | vncpasswd -f >> $PATH_SENHA
chmod 600 $PATH_SENHA

echo -e "Iniciando servidor VNC ..."
echo "Removendo vnc locks ..."
vncserver -kill $DISPLAY &> $PATH_ENTRYPOINT/entrypoint.log \
    || rm -rfv /tmp/.X*-lock /tmp/.X11-unix &> $PATH_ENTRYPOINT/entrypoint.log \
    || echo "Nao havia locks."

vncserver $DISPLAY -depth $COL_DEPTH -geometry $RESOLUCAO &> $PATH_ENTRYPOINT/entrypoint.log

echo ":::::::::::::: VNC iniciado :::::::::::::::"
echo "COL_DEPTH=$COL_DEPTH, RESOLUCAO=$RESOLUCAO"
echo " "
echo " "
echo "Acesse com VNC Viewer em $IP_HOST:$PORTA"

tail -f /dev/null

