
run_emacs() {
  if [ "$1" != "" ];
  then
    server_name="${1}"
    args="${@:2}"
  else
    server_name="default"
    args=""
  fi

  if ! emacsclient -s ${server_name} "${@:2}";
  then
    emacs --daemon=${server_name}
    echo ">> Server should have started. Trying to connect..."
    emacsclient -s ${server_name} "${@:2}"
  fi
}

# Open a file to edit using sudo
es() {
    run_emacs default -n -c "/sudo:root@localhost:$@"
}
