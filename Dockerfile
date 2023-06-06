FROM nvidia/cuda:11.8.0-devel-ubuntu18.04



RUN apt-get update && \
    apt-get install -y wget && \
    apt-get clean

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh

ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"
RUN

RUN conda install python=3.8.5 && conda clean -a -y
RUN conda install pytorch==1.11.0 torchvision==0.12.0 cudatoolkit=11.8 -c pytorch && conda clean -a -y

COPY . .

RUN ./gpu_installer_cuda.sh

CMD [ "sleep", "infinity" ]
