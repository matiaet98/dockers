#!/bin/bash

add() {
  if [ -z "$5" ] # Que minimamente haya definido hasta el primero fqdn
  then
    usage
    return 0
  fi

  domains=${@:5}
  cookie=$(uuidgen)

  curl --noproxy '*' -c /tmp/${cookie} \
    -X POST https://cloudio.cloudint.afip.gob.ar/auth/signin \
    --data '{"username": "$2", "password": "$3"}'

  for domain in $domains
  do
    curl --noproxy '*' -b /tmp/${cookie} \
      -X GET -G https://cloudio.cloudint.afip.gob.ar/dns/updateHostname \
      --data 'pIPAddress=${4}' \
      --data 'pHostnameNew=$domain'
  done

  rm -fr /tmp/${cookie}
}

delete() {
  echo "delete" 
}

usage() {
  echo "Usage: $0 {add|delete} cloudio_user cloudio_password ip_address name1 name2 ... nameN"
}


case "$1" in
  add)
    add $@
    ;;
  delete)
    delete
    ;;
  *)
    usage
esac