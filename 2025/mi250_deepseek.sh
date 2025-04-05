# SGLANG
# https://docs.sglang.ai/start/install.html                                                                                                         
                                                                                                                                                            
git clone -b v0.4.4.post3 https://github.com/sgl-project/sglang.git                                                                                         
cd sglang/docker                                                                                                                                            
                                                                                                                                                            
docker build --build-arg SGL_BRANCH=v0.4.4.post3 -t v0.4.4.post3-rocm630 -f Dockerfile.rocm .                                                               
mkdir dockerx                                                                                                                                               
                                                                                                                                                            
alias drun='docker run -it --network=host --device=/dev/kfd --device=/dev/dri --ipc=host \                                                                  
    --shm-size 16G --group-add video --cap-add=SYS_PTRACE --security-opt seccomp=unconfined \                                                               
    -v /data/zining/dockerx:/dockerx -v /data:/data'                                                                                                        
                                                                                                                                                            
drun -p 30000:30000 -v /data/zining/.cache/huggingface:/root/.cache/huggingface --env "HF_TOKEN=..." v0.4.4.post3-rocm630 
bash                                                                                                                                                        
                                                                                                                                                            
#drun -p 30000:30000 \                                                                                                                                      
#    -v ~/.cache/huggingface:/root/.cache/huggingface \                                                                                                     
#    --env "HF_TOKEN=<secret>" \                                                                                                                            
#    v0.4.4.post3-rocm630 \                                                                                                                                 
#    python3 -m sglang.launch_server --model-path meta-llama/Llama-3.1-8B-Instruct --host 0.0.0.0 --port 30000                                              
#                                                                                                                                                           
## Till flashinfer backend available, --attention-backend triton --sampling-backend pytorch are set by default
#drun v0.4.4.post3-rocm630 python3 -m sglang.bench_one_batch --batch-size 32 --input 1024 --output 128 --model amd/Meta-Llama-3.1-8B-Instruct-FP8-KV --tp 8 --quantization fp8

TORCH_BLAS_PREFER_HIPBLASLT=0 python3 -m sglang.bench_one_batch --batch-size 32 --input 1024 --output 128 --model meta-llama/Llama-3.1-8B-Instruct --tp 8

#lmsysorg/sglang:v0.4.3.post4-rocm630
#Also you can find the latest official docker images at https://hub.docker.com/r/lmsysorg/sglang/tags

#server
export DEBUG_HIP_BLOCK_SYNC=1024
export GPU_FORCE_BLIT_COPY_SIZE=64
export SGLANG_ROCM_FUSED_DECODE_MLA=1
export RCCL_MSCCL_ENABLE=0
export CK_MOE=1
export hf_model=deepseek-ai/DeepSeek-V3

python3 -m sglang.launch_server
--model $hf_model
--trust-remote-code
--tp 8
--mem-fraction-static 0.95
--disable-radix-cache

#client
isl=3200
osl=800
con=160
prompts=500

python3 -m sglang.bench_serving
--backend sglang
--dataset-name random
--cpu-offload-gb 50
--random-range-ratio 1
--num-prompt $prompts
--random-input $isl
--random-output $osl
--max-concurrency $con

python3 -m sglang.launch_server \
    --model $hf_model \
    --cpu-offload-gb 50 \
    --trust-remote-code \
    --tp $TP_NUM \
    --mem-fraction-static 0.95 \
    --disable-radix-cache
    
# VLLM
export hf_model=deepseek-ai/DeepSeek-V3
#export hf_model=meta-llama/Llama-3.1-8B-Instruct
export TP_NUM=8

vllm serve \
    $hf_model \
    --cpu-offload-gb 50 \
    --trust-remote-code \
    -tp $TP_NUM \
    --gpu-memory-utilization 0.95


import os
from vllm import LLM, SamplingParams

if __name__ == '__main__':
    model_path = "deepseek-ai/DeepSeek-V3"
    model = LLM(
        model=model_path,
        tensor_parallel_size=8,
        gpu_memory_utilization=0.90,
        cpu_offload_gb=50,
        trust_remote_code=True,
        enforce_eager=True,
        max_seq_len_to_capture=4096 # I'm testing with a low sequence to increase it latter
        # ,tie_weights=False # <-- this configuration doesn't exist
    )

    sampling_params = SamplingParams(
        temperature=0.7,
        top_p=0.9,
        max_tokens=200
    )

    prompt = 'Sum up the movie "Forrest Gump"'
    outputs = model.generate([prompt], sampling_params)

    for output in outputs:
        print(output)
