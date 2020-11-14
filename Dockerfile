FROM frolvlad/alpine-glibc:alpine-3.12

ARG work_dir=/tmp/setup
RUN mkdir ${work_dir} && \
    chmod 777 ${work_dir}

# --- install roswell and some common lisp implementations --- #
RUN apk update && \
    apk add --no-cache git && \
    apk add --no-cache --virtual=for-install automake autoconf make gcc build-base curl curl-dev glib-dev && \
    cd ${work_dir} && \
    git clone --depth=1 -b release https://github.com/roswell/roswell.git && \
    cd roswell && \
    sh bootstrap && \
    ./configure --disable-manual-install && \
    make && \
    make install && \
    cd .. && \
    rm -rf roswell

RUN apk add --no-cache make curl-dev && \
    ros run -q

RUN ln -s ${HOME}/.roswell/local-projects work
ENV PATH /root/.roswell/bin:${PATH}

# --- install neovim and vlime --- #
RUN apk add --no-cache neovim bash && \
    curl https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | sh

ENV PATH /root/.pyenv/bin:${PATH}
ENV PATH $PYENV_ROOT/bin:${PATH}
RUN eval "$(pyenv init -)" && \
    pyenv install 3.7.9 && \
    pyenv global 3.7.9 && \
    pip install --upgrade pip && \
    pip install pynvim

COPY .config /root/.config

RUN curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh && \
    sh ./installer.sh /root/.cache/dein && \
    rm installer.sh  && \
    nvim -e +"call dein#install()" +q && \
    ros --load /root/.cache/dein/repos/github.com/vlime/vlime/lisp/start-vlime.lisp

# --- clean --- #
RUN apk del for-install

# --- zsh --- #
RUN apk add --no-cache zsh
COPY .zshrc /root/.zshrc

ENTRYPOINT ros run -- --load /root/.cache/dein/repos/github.com/vlime/vlime/lisp/start-vlime.lisp
