# Copyright 2016 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

TAG?=v0.0.1
REPO?=itkh/hostpath-provisioner
IMAGE=$(REPO):$(TAG)
LATEST=$(REPO):latest

all: dep hostpath-provisioner image push

dep:
	go mod tidy

hostpath-provisioner:
	CGO_ENABLED=0 go build -a -ldflags '-extldflags "-static"' -o hostpath-provisioner .

image: hostpath-provisioner
	docker build -t $(IMAGE) -f Dockerfile.scratch .
	docker tag $(IMAGE) $(LATEST)

push: image
	docker push $(IMAGE)
	docker push $(LATEST)

clean:
	rm -rf hostpath-provisioner
