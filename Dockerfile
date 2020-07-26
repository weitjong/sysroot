#
# Copyright (c) 2020 Yao Wei Tjong. All rights reserved.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#

FROM ubuntu:latest

LABEL maintainer="Yao Wei Tjong <weitjong@gmail.com>" \
      description="Generic sysroot extractor for cross-compiling" \
      source-repo=https://github.com/weitjong/sysroots \
      binary-repo=https://hub.docker.com/u/weitjong

COPY sysroot/ /sysroot/

RUN apt-get update && apt-get install -y --no-install-recommends qemu-user-static \
    && cp $(which qemu-aarch64-static) /sysroot/$(which qemu-aarch64-static) \
    && for l in $(find /sysroot/usr/lib/aarch64-linux-gnu -xtype l); do ln -sf ../../..$(readlink $l) $l; done