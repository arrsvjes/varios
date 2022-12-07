#!/bin/bash
RNULL=/dev/null
TECHDOCS=/home/techdocs

RES1=$(test -d $TECHDOCS && echo 1 || echo 0)
if [[ $RES1 -eq 1 ]]; then
  echo -e "\e[32mDirectorio techdocs correctamente configurado\e[0m"
else
  echo -e "\e[31mDirectorio techdocs no existe\e[0m"
fi
