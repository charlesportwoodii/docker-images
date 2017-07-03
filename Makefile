SHELL := /bin/bash

OS?=xenial centos7 rhel7 trusty
PACKAGE?=nginx apache2 php70 php71 disque

all: build packages push

package:
	for i in $(OS); do \
		for j in $(PACKAGE); do \
			if [ -d ./$$i/$$j ]; then \
				docker build -f $$i/$$j/Dockerfile -t charlesportwoodii/$$i:$$j --compress .; \
			fi \
		done \
	done

push:
	for i in $(OS); do \
		for j in $(PACKAGE); do \
			if [ -d ./$$i/$$j ]; then \
				docker push charlesportwoodii/$$i:$$j; \
			fi \
		done \
	done