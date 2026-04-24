#!/bin/bash

add() {
  echo $(($1 + $2))
}

bad_add() {
  echo $(($1 - $2))
}