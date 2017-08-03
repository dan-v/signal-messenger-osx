FROM node:8 as builder

ENV	NWJS_VERSION v0.24.0

RUN	apt-get update && \
	  apt-get install -y unzip ruby ruby-dev && \
		gem install sass --no-user-install && \
    wget http://dl.nwjs.io/${NWJS_VERSION}/nwjs-sdk-${NWJS_VERSION}-osx-x64.zip && \
		unzip nwjs-sdk-${NWJS_VERSION}-osx-x64.zip && \
		cp -r nwjs-sdk-${NWJS_VERSION}-osx-x64/nwjs.app SignalPrivateMessenger.app && \
		git clone https://github.com/WhisperSystems/Signal-Desktop.git && \
		cd Signal-Desktop && \
		npm install && \
		sed -i '1i@charset "utf-8";' stylesheets/options.scss && \
		node_modules/grunt-cli/bin/grunt && \
		cp -r dist ../SignalPrivateMessenger.app/Contents/Resources/app.nw

COPY app.icns /SignalPrivateMessenger.app/Contents/Resources/app.icns

FROM alpine:latest
COPY --from=builder /SignalPrivateMessenger.app /SignalPrivateMessenger.app
