wget https://download.open-mpi.org/release/open-mpi/v4.0/openmpi-4.0.2.tar.gz
gunzip -c openmpi-4.0.2.tar.gz | tar xf -
cd openmpi-4.0.2
./configure --prefix=/usr/local
sudo make all install
#HOROVOD_WITH_MPI=1 HOROVOD_CUDA_INCLUDE=/usr/local/cuda-9.0/targets/x86_64-linux/include/ HOROVOD_CUDA_LIB=/usr/local/cuda-9.0/targets/x86_64-linux/lib/ HOROVOD_CUDA_HOME=/usr/local/cuda-9.0/bin/ HOROVOD_GPU_ALLREDUCE=NCCL HOROVOD_WITH_TENSORFLOW=1 pip install --no-cache-dir horovod
