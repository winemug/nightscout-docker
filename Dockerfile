FROM node
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y python g++ make git node-gyp software-properties-common
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN cd && cp -R .bashrc .profile /home/node

RUN npm install n -g
RUN n stable

USER node
ENV HOME /home/node
WORKDIR /home/node/app

RUN git clone https://github.com/nightscout/cgm-remote-monitor.git /home/node/app
RUN git checkout dev
RUN chown -R node:node /home/node
RUN npm install

CMD ["node", "server.js"]
