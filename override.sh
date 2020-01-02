#!/bin/bash

files=$(ls /run/secrets/)
vars=$(set)
for file in $files; do 
    secret=$(tail /run/secrets/$file);
    export ${file}=${secret}
    for var in $vars; do
      IFS='=' read -ra var_dico <<< "$var"
      if [ "${var_dico[1]}" = "__${file}__" ]; then
        echo "Replacing ${var_dico[0]} by secret ${file}"
        export ${var_dico[0]}=${secret}
      fi
    done
done
