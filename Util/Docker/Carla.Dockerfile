FROM carla-prerequisites:latest

ARG GIT_BRANCH

USER carla
WORKDIR /home/carla

COPY 20210730_564bcdc.tar.gz /home/carla

RUN cd /home/carla/ && \
  if [ -z ${GIT_BRANCH+x} ]; then git clone --depth 1 https://github.com.cnpmjs.org/by1e11/carla.git; \
  else git clone --depth 1 --branch $GIT_BRANCH https://github.com.cnpmjs.org/by1e11/carla.git; fi && \
  cd /home/carla/carla && \
  ./Update.sh -s && \
  mkdir -p ./Unreal/CarlaUE4/Content/Carla && \
  tar -xvzf ../20210730_564bcdc.tar.gz -C ./Unreal/CarlaUE4/Content/Carla && \
  make CarlaUE4Editor && \
  make PythonAPI && \
  make build.utils && \
  make package && \
  rm -r /home/carla/carla/Dist

WORKDIR /home/carla/carla
