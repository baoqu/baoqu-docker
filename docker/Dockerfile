FROM java:openjdk-8
MAINTAINER Miguel de la Cruz <mgdelacroix@gmail.com>

# Locale setup
RUN apt-get update && \
    apt-get install -yq locales ca-certificates wget sudo && \
    rm -rf /var/lib/apt/lists/* && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Add dev user
RUN useradd user -d /home/user -s /bin/bash && cp -r /etc/skel /home/user && chown user.user -R /home/user

# Dependencies
RUN apt-get update && apt-get install -yq \
                                      tmux \
                                      vim \
                                      xz-utils \
                                      curl \
                                      rlwrap

# Install lein
ENV LEIN_ROOT 1
RUN curl https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -o /usr/local/bin/lein && chmod +x /usr/local/bin/lein && lein upgrade

# Install nvm
RUN mkdir -p /opt/nodejs && \
          curl https://nodejs.org/dist/v5.5.0/node-v5.5.0-linux-x64.tar.xz | tar Jx -C /opt/nodejs --strip-components=1 && \
          ln -s /opt/nodejs/bin/node /usr/local/bin/node && ln -s /opt/nodejs/bin/npm /usr/local/bin/npm && \
          /opt/nodejs/bin/npm install -g gulp

# Change user
USER user
WORKDIR /home/user
RUN echo "export PATH=/opt/nodejs/bin:$PATH" >> ~/.bashrc
COPY dev-entrypoint.sh .

# PORTS
EXPOSE 3449
EXPOSE 8080

CMD ./dev-entrypoint.sh
