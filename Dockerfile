# 基于官方的PyTorch镜像
# FROM pytorch/pytorch:latest
FROM ghcr.io/ai-dock/jupyter-pytorch:2.2.0-py3.10-cuda-11.8.0-runtime-22.04

# 更新软件包列表并安装依赖
RUN apt-get update && apt-get install -y \
    libglib2.0-0 \
    libgl1-mesa-glx \
    libsm6 libxext6 libxrender-dev wget \
    && rm -rf /var/lib/apt/lists/*
 
# 安装Python依赖
COPY requirements.txt .
RUN conda update conda
#RUN conda init ootd ; conda create -n ootd python==3.10 ; conda activate ootd ; pip install torch==2.0.1 torchvision==0.15.2 torchaudio==2.0.2 ; pip install -r requirements.txt
RUN conda init ootd ; conda create -n ootd python==3.10 ; conda activate ootd ; pip install torch torchvision torchaudio ; pip install -r requirements.txt
#RUN conda info | grep -i "base environment"
#RUN /bin/bash -c "source /opt/conda/etc/profile.d/conda.sh"
 
# 下载模型和其他资源
RUN mkdir /app 
 
# 复制源代码到容器中
COPY . /app
 
# 设置工作目录
WORKDIR /app
 
# 设置环境变量
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
 
# 运行OOTDiffusion模型
# CMD ["python", "/app/run/run_ootd.py"]
CMD ["python", "/app/run/gradio_ootd.py"]
