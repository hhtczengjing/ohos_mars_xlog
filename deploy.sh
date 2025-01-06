#!/bin/bash

set -e

BASE_DIR=$(cd "$(dirname "$0")"; pwd)
cd $BASE_DIR
PROJECT_PATH=$(git rev-parse --show-toplevel)
cd $PROJECT_PATH
echo "current project path: $PROJECT_PATH"

DEVECO_TOOLS_HOME="/Applications/DevEco-Studio.app/Contents/tools"
DEVECO_OHPM="${DEVECO_TOOLS_HOME}/ohpm/bin"
DEVECO_HVIGOR="${DEVECO_TOOLS_HOME}/hvigor/bin"
DEVECO_NODE="${DEVECO_TOOLS_HOME}/node/bin"
export PATH="${DEVECO_OHPM}:${DEVECO_HVIGOR}:${DEVECO_NODE}:$PATH"

rm -rf $PROJECT_PATH/xlog/.cxx
rm -rf $PROJECT_PATH/xlog/oh_modules
rm -rf $PROJECT_PATH/xlog/build

ohpm config set registry https://ohpm.openharmony.cn/ohpm/
ohpm config set strict_ssl false
ohpm clean
ohpm install --registry https://ohpm.openharmony.cn/ohpm/ --strict_ssl false --all

hvigorw -p product=default clean --no-daemon

hvigorw --mode module \
  -p product=default \
  -p module=xlog@default \
  -p buildMode=release \
  -p debuggable=false \
  assembleHar \
  --no-daemon

har_path="$PROJECT_PATH/xlog/build/default/outputs/default/xlog.har"

ohpm publish $har_path