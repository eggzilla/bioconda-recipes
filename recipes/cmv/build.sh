#!/bin/bash

if [ `uname` == Darwin ]
then
  export LD_LIBRARY_PATH="${PREFIX}/lib"
  export STACK_ROOT="${SRC_DIR}/s"
  export LDFLAGS="-L${PREFIX}/lib"
  export CPPFLAGS="-I${PREFIX}/include"
  echo ${PREFIX}
  echo ${SRC_DIR}/s
  mkdir ${SRC_DIR}/s
  export LOCALBIN="${SRC_DIR}/s/bin"
  mkdir $LOCALBIN
  export PATH="$LOCALBIN:$PATH"
  stack setup --extra-lib-dirs ${PREFIX}/lib --extra-include-dirs ${PREFIX}/include --local-bin-path $LOCALBIN
  stack path
  stack update
  stack install --extra-lib-dirs ${PREFIX}/lib --extra-include-dirs ${PREFIX}/include --local-bin-path ${PREFIX}/bin
  #cp -p $LOCALBIN/* "${PREFIX}/bin"
  rm -r ${SRC_DIR}/s
else
  export LIBRARY_PATH="${PREFIX}/lib:/usr/lib:/usr/lib64"
  export LD_LIBRARY_PATH="${PREFIX}/lib:/usr/lib:/usr/lib64"
  export LDFLAGS="-L${PREFIX}/lib"
  export CPPFLAGS="-I${PREFIX}/include"
  stack setup --local-bin-path ${PREFIX}/bin
  stack update
  stack install --local-bin-path ${PREFIX}/bin
fi
#cleanup
rm -r .stack-work

