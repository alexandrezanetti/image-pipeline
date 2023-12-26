FROM openshift/golang-builder:v1.18.10-202310162029.el8.gacd8ae5 AS builder
ENV __doozer=update BUILD_RELEASE=202311302048.p0.g94eb522.assembly.stream BUILD_VERSION=v4.11.0 OS_GIT_MAJOR=4 OS_GIT_MINOR=11 OS_GIT_PATCH=0 OS_GIT_TREE_STATE=clean OS_GIT_VERSION=4.11.0-202311302048.p0.g94eb522.assembly.stream SOURCE_GIT_TREE_STATE=clean __doozer_group=openshift-4.11 __doozer_key=openshift-enterprise-cli 
ENV __doozer=merge OS_GIT_COMMIT=94eb522 OS_GIT_VERSION=4.11.0-202311302048.p0.g94eb522.assembly.stream-94eb522 SOURCE_DATE_EPOCH=1701374955 SOURCE_GIT_COMMIT=94eb5225445fe2fc861791fa4954b4a7eb25bb08 SOURCE_GIT_TAG=openshift-clients-4.11.0-202208020706-95-g94eb52254 SOURCE_GIT_URL=https://github.com/openshift/oc 
WORKDIR /go/src/github.com/openshift/oc
COPY . .
RUN make build --warn-undefined-variables

FROM openshift/ose-base:v4.11.0-202311301649.p0.gf1330f6.assembly.stream
ENV __doozer=update BUILD_RELEASE=202311302048.p0.g94eb522.assembly.stream BUILD_VERSION=v4.11.0 OS_GIT_MAJOR=4 OS_GIT_MINOR=11 OS_GIT_PATCH=0 OS_GIT_TREE_STATE=clean OS_GIT_VERSION=4.11.0-202311302048.p0.g94eb522.assembly.stream SOURCE_GIT_TREE_STATE=clean __doozer_group=openshift-4.11 __doozer_key=openshift-enterprise-cli 
ENV __doozer=merge OS_GIT_COMMIT=94eb522 OS_GIT_VERSION=4.11.0-202311302048.p0.g94eb522.assembly.stream-94eb522 SOURCE_DATE_EPOCH=1701374955 SOURCE_GIT_COMMIT=94eb5225445fe2fc861791fa4954b4a7eb25bb08 SOURCE_GIT_TAG=openshift-clients-4.11.0-202208020706-95-g94eb52254 SOURCE_GIT_URL=https://github.com/openshift/oc 
COPY --from=builder /go/src/github.com/openshift/oc/oc /usr/bin/
RUN for i in kubectl openshift-deploy openshift-docker-build openshift-sti-build openshift-git-clone openshift-manage-dockerfile openshift-extract-image-content openshift-recycle; do ln -sf /usr/bin/oc /usr/bin/$i; done

LABEL \
        io.k8s.display-name="OpenShift Client" \
        io.k8s.description="OpenShift is a platform for developing, building, and deploying containerized applications." \
        io.openshift.tags="openshift,cli" \
        License="GPLv2+" \
        vendor="Red Hat" \
        name="openshift/ose-cli" \
        com.redhat.component="openshift-enterprise-cli-container" \
        io.openshift.maintainer.project="OCPBUGS" \
        io.openshift.maintainer.component="oc" \
        release="202311302048.p0.g94eb522.assembly.stream" \
        io.openshift.build.commit.id="94eb5225445fe2fc861791fa4954b4a7eb25bb08" \
        io.openshift.build.source-location="https://github.com/openshift/oc" \
        io.openshift.build.commit.url="https://github.com/openshift/oc/commit/94eb5225445fe2fc861791fa4954b4a7eb25bb08" \
        version="v4.11.0"
