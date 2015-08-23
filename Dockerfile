FROM  debian 
RUN echo "deb http://files.freeswitch.org/repo/deb/debian/ jessie main" > /etc/apt/sources.list.d/99FreeSWITCH.test.list
RUN apt-get update
RUN apt-get install -y --no-install-recommends build-essential autoconf automake libtool zlib1g-dev libjpeg-dev libncurses-dev libssl-dev libcurl4-openssl-dev python-dev libexpat-dev libtiff-dev libx11-dev wget git
RUN wget -O - http://files.freeswitch.org/repo/deb/debian/key.gpg |apt-key add -
RUN apt-get update
RUN DEBIAN_FRONTEND=none APT_LISTCHANGES_FRONTEND=none apt-get install -y --force-yes freeswitch-video-deps-most
RUN git config --global pull.rebase true
RUN git clone https://freeswitch.org/stash/scm/fs/freeswitch.git freeswitch.git
RUN cd freeswitch.git; ./bootstrap.sh -j; perl  -i -pe 's/#applications\/mod_av/applications\/mod_av/g' modules.conf
RUN  cd freeswitch.git; ./configure --prefix=/opt/freeswitch ; make; make install cd-sounds-install cd-moh-install samples; 


