#!/bin/bash
# this script is SOURCED!!!!

set -e # exit on error

# "DEPENDECIES ========================================================================"
export INSTALL_PREFIX="${APPROXMVBB_CACHE_DIR}"
export PATH="${INSTALL_PREFIX}/bin:/usr/local/bin:${PATH}"

cd ${ROOT_PATH}

if [ -n "${USE_GCC}" ]; then 
    # https://stackoverflow.com/questions/37603238/fsanitize-not-using-gold-linker-in-gcc-6-1
    export CPPFLAGS="-fuse-ld=gold"
    export CXXFLAGS="${CPPFLAGS}"
    
    if [ -n "${GCC_VERSION}" ]; then
        export CXX="g++-${GCC_VERSION}" CC="gcc-${GCC_VERSION}"; 
    else
        export CXX="g++" CC="gcc"; 
    fi
fi
if [ -n "${USE_CLANG}" ]; then 
    if [ -n "${CLANG_VERSION}" ]; then
        export CXX="clang++-${CLANG_VERSION}" CC="clang-${CLANG_VERSION}"; 
    else
        export CXX="clang++" CC="clang"; 
    fi
fi

echo "Path set to ${PATH}"
echo "CXX set to ${CXX}"
echo "CC set to ${CC}"

${CXX} --version
cmake --version
echo "cmake at $(which cmake)"


chmod +x ${CHECKOUT_PATH}/travis/install_dep.sh
# run the command in this process -> env varibales!
. ${CHECKOUT_PATH}/travis/install_dep.sh
# "DEPENDECIES COMPLETE ================================================================="

set +e # exit on errors off