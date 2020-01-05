#!/bin/bash

files=$(ls /run/secrets/)
vars=$(set)
for file in $files; do
    secret=$(tail /run/secrets/$file);
    echo "echo \"Add ${file} variable\""
    echo "export ${file}=${secret}"
    for var in $vars; do
      IFS='=' read -ra var_dico <<< "$var"
      if [ "${var_dico[1]}" = "__${file}__" ]; then
        echo "echo \"Replacing ${var_dico[0]} by secret ${file}\""
        echo "export ${var_dico[0]}=${secret}"
      fi
    done
done
