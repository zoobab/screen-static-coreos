FROM voidlinux/voidlinux-musl
MAINTAINER Benjamin Henrion <zoobab@gmail.com>

RUN xbps-install -Sy make gcc libtool autoconf automake pkg-config wget ncurses ncurses-devel sudo

ENV user core

RUN useradd -d /home/$user -m -s /bin/bash $user
RUN echo "$user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$user
RUN chmod 0440 /etc/sudoers.d/$user

USER $user

WORKDIR /home/$user
RUN wget http://ftp.gnu.org/gnu/screen/screen-4.6.2.tar.gz
RUN tar -xvzf screen-4.6.2.tar.gz
WORKDIR /home/$user/screen-4.6.2
RUN ./configure
COPY config.h .
RUN make LDFLAGS="-static"

# ldd returns an exit code of 0 if the binary is dynamic, 1 if it is a static, here the "!" reverts the test to make it successful if it is a static
RUN ! ldd screen
