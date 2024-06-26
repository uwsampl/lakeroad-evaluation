FROM ubuntu:22.04
ARG MAKE_JOBS=2
SHELL ["/bin/bash", "-c"] 

# Install apt dependencies. DEBIAN_FRONTEND is necessary for making sure tzdata
# setup runs non-interactively.
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
  && apt-get install -y \
  autoconf \
  bison \
  build-essential \
  ccache \
  clang \
  cloc \
  cmake \
  curl \
  dvipng \
  flex \
  g++ \
  gawk \
  gcc \
  git \
  graphviz \
  help2man \
  jq \
  libboost-all-dev \
  libedit-dev \
  libffi-dev \
  libfl-dev \
  libfl2 \
  libgmp-dev \
  libgoogle-perftools-dev \
  libreadline-dev \
  libreadline8 \
  libssl-dev \
  libtcl8.6 \
  libtinfo-dev \
  libtinfo5 \
  libx11-6 \
  libxml2-dev \
  llvm-14 \
  locales \
  make \
  ninja-build \
  numactl \
  ocl-icd-opencl-dev \
  opencl-headers \
  openjdk-11-jre \
  parallel \
  perl \
  perl-doc \
  pkg-config \
  python3 \
  python3-dev \
  python3-pip \
  python3-setuptools \
  python3-venv \
  software-properties-common \
  tcl-dev \
  tcl8.6-dev \
  texlive \
  texlive-latex-extra \
  wget \
  zlib1g \
  zlib1g-dev


# Set the locale. Necessary for Vivado.
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
  locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8     

# Point to llvm-config binary. Alternatively, make sure you have a binary called
# `llvm-config` on your PATH.
ENV LLVM_CONFIG=llvm-config-14

# Make a binary for `lit`. If you're on Mac, you can install lit via Brew.
# Ubuntu doesn't have a binary for it, but it is available on pip and is
# installed later in this Dockerfile.
WORKDIR /root
RUN mkdir -p /root/.local/bin \
  && echo "#!/usr/bin/env python3" >> /root/.local/bin/lit \
  && echo "from lit.main import main" >> /root/.local/bin/lit \
  && echo "if __name__ == '__main__': main()" >> /root/.local/bin/lit \
  && chmod +x /root/.local/bin/lit
ENV PATH="/root/.local/bin:${PATH}"

# Set up Python.
WORKDIR /root
ADD requirements.txt requirements.txt
RUN pip3 install --requirement requirements.txt 

# Make Python utilities visible.
# Also make sure we can import simulate_with_verilator.py from Lakeroad's bin/ dir.
# TODO(@gussmith23): This is a hack. I still don't understand Python imports.
ADD python/ /root/python/
ENV PYTHONPATH="/root/python/:/root/lakeroad/bin:${PYTHONPATH}"

ADD lakeroad/dependencies.sh /root/dependencies.sh

# Build Bitwuzla.
WORKDIR /root
RUN source /root/dependencies.sh \
  && mkdir bitwuzla \
  && wget -qO- https://github.com/bitwuzla/bitwuzla/archive/$BITWUZLA_COMMIT_HASH.tar.gz | tar xz -C bitwuzla --strip-components=1 \
  && cd bitwuzla \
  && ./configure.py --prefix=/root/.local \
  && cd build \
  && ninja -j${MAKE_JOBS} \
  && ninja install \
  && rm -rf /root/bitwuzla

# Build STP.
WORKDIR /root
# TODO(@gussmith23): We shouldn't need this once https://github.com/stp/stp/issues/485 is fixed.
# Have to set this before we build STP, as STP runs itself (by way of help2man) during its build process.
ENV LD_LIBRARY_PATH="/root/stp/deps/cadical/build:/root/stp/deps/cadiback/:$LD_LIBRARY_PATH"
RUN apt-get install -y git cmake bison flex libboost-all-dev python2 perl && \
  source /root/dependencies.sh && \
  mkdir stp && cd stp && \
  wget -qO- https://github.com/$STP_USER_AND_REPO/archive/$STP_COMMIT_HASH.tar.gz | tar xz --strip-components=1 && \
  ./scripts/deps/setup-gtest.sh && \
  ./scripts/deps/setup-outputcheck.sh && \
  ./scripts/deps/setup-cms.sh && \
  ./scripts/deps/setup-minisat.sh && \
  mkdir build && \
  cd build && \
  cmake .. -DCMAKE_INSTALL_PREFIX=/root/.local && \
  make -j ${MAKE_JOBS}
# TODO(@gussmith23): Install and delete folder once
# https://github.com/stp/stp/issues/479 is fixed.
# make install && \
# rm -rf /root/stp
# And after that we also don't need to add STP to the path.
ENV PATH="/root/stp/build:${PATH}"

# Build Yosys.
WORKDIR /root
RUN source /root/dependencies.sh \
  && mkdir yosys && cd yosys \
  && wget -qO- https://github.com/YosysHQ/yosys/archive/$YOSYS_COMMIT_HASH.tar.gz | tar xz --strip-components=1 \
  && PREFIX="/root/.local" CPLUS_INCLUDE_PATH="/usr/include/tcl8.6/:$CPLUS_INCLUDE_PATH" make config-gcc \
  && PREFIX="/root/.local" CPLUS_INCLUDE_PATH="/usr/include/tcl8.6/:$CPLUS_INCLUDE_PATH" make -j ${MAKE_JOBS} install \
  && rm -rf /root/yosys

# Build CVC5.
RUN source /root/dependencies.sh \
  && mkdir cvc5 && cd cvc5 \
  && wget -qO- https://github.com/cvc5/cvc5/archive/$CVC5_COMMIT_HASH.tar.gz  | tar xz --strip-components=1 \
  && ./configure.sh --prefix="/root/.local"  --auto-download \
  && cd ./build \
  && make -j ${MAKE_JOBS} \
  && make -j ${MAKE_JOBS} install \
  && rm -rf /root/cvc5

# Build Yices2.
RUN source /root/dependencies.sh \
  && apt-get install -y gperf \
  && mkdir yices2 && cd yices2 \
  && wget -qO- https://github.com/SRI-CSL/yices2/archive/$YICES2_COMMIT_HASH.tar.gz | tar xz --strip-components=1 \
  && autoconf \
  && ./configure --prefix="/root/.local" \
  && make -j ${MAKE_JOBS} \
  && make -j ${MAKE_JOBS} install \
  && rm -rf /root/yices2

# Build Verilator.
RUN source /root/dependencies.sh \
  && apt-get install -y git help2man perl python3 make autoconf g++ flex bison ccache \
  && apt-get install -y libgoogle-perftools-dev numactl perl-doc \
  && apt-get install -y libfl2  \
  && apt-get install -y libfl-dev  \
  && mkdir verilator && cd verilator \
  && wget -qO- https://github.com/verilator/verilator/archive/$VERILATOR_COMMIT_HASH.tar.gz | tar xz --strip-components=1 \
  && autoconf \
  && ./configure --prefix="/root/.local" \
  && make -j ${MAKE_JOBS} \
  && make -j ${MAKE_JOBS} install

# Install Racket, install raco (Racket) dependencies. First, fix
# https://github.com/racket/racket/issues/2691 by building the docs. We error if
# we're not on x86; the Racket install script will not work for other
# architectures. We will need to build from source for other architectures.
WORKDIR /root
RUN [ "$(uname -m)" == "x86_64" ] \
  && wget -q https://download.racket-lang.org/installers/8.9/racket-8.9-x86_64-linux-cs.sh \
  && chmod +x racket-8.9-x86_64-linux-cs.sh \
  && ./racket-8.9-x86_64-linux-cs.sh --unix-style --dest /usr/ \
  && rm racket-8.9-x86_64-linux-cs.sh \
  && raco setup --doc-index --force-user-docs \
  && raco pkg install --deps search-auto --batch \
  rosette \
  yaml

# Add Lakeroad.
ADD lakeroad /root/lakeroad
ENV LAKEROAD_DIR=/root/lakeroad

# Build Racket bytecode; makes Lakeroad WAY faster.
RUN raco make /root/lakeroad/bin/main.rkt

# Set up Lattice Diamond. 
#
# The following can be ignored if you're not using Diamond.
#
# Path to Diamond bin dir, when mounted in the container. E.g. if we mount
# Diamond to /usr/local/diamond in the container, then
# DIAMOND_BINDIR=/usr/local/diamond/3.12/bin/lin64.
#
# Note: due to how Lattice scripts are written, DIAMOND_BINDIR must NOT end in a
# slash.
ARG DIAMOND_BINDIR
ENV DIAMOND_BINDIR=${DIAMOND_BINDIR}

WORKDIR /root
# Add the rest of the stuff. This might be a bad idea, I'm still not sure on
# Docker best practices.
ADD . .

# Set up external tools. These tools should be mounted into the container at
# runtime with e.g.:
# `-v /tools/intelFPGA_lite/22.1std:/tools/intelFPGA_lite/22.1std`
ARG VIVADO_BIN_DIR
ENV PATH="${VIVADO_BIN_DIR}:${PATH}"
ARG QUARTUS_BIN_DIR
ENV PATH="${QUARTUS_BIN_DIR}:${PATH}"

# Build sv2v, a SystemVerilog to Verilog compiler.
# Install Haskell Stack and build
WORKDIR /root
RUN wget -qO- https://get.haskellstack.org/ | sh \
  && git clone https://github.com/zachjs/sv2v.git \
  && cd sv2v \
  && git checkout v0.0.10 \
  && make
ENV PATH=/root/sv2v/bin:${PATH}

WORKDIR /root
ADD verilog/ verilog/
ADD run-evaluation.sh run-evaluation.sh

WORKDIR /root
