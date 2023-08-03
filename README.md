# Nvidia-Tools
A comprehensive set of tools designed for effortlessly installing Nvidia packages

* Install DeepStream - To install `DeepStream 6.2` on `Ubuntu 20.04` `x86_64`  
    These packages will be installed.
    * `NVIDIA driver 525.85.12`
    * `CUDA 11.8`
    * `CUDNN 8.7.0`
    * `TensorRT 8.5.2`

    #### Usage

    1. At first, you have to `disable` `nouveau` and reboot your system.
        ```bash
        bash disable_nouveau.sh
        ```

    2. Install the `DeepStream 6.2`  
        The `--out-dir` parameter is required.
        ```bash
        bash install_deepstream.sh --out-dir <out-dir-name>
        ```
    
    #### Removal

    * Remove `DeepStream 6.2` entirely.
        ```bash
        bash remove_deepstream.sh
        ```
    
    * Remove `DeepStream 6.2` and `TensorRT 8.5.2` entirely.
        ```bash
        bash remove_deepstream.sh --tensorrt
        ```

* Install DeepStream Python - To install `Python` version of `DeepStream 6.2` on `Ubuntu 20.04` `x86_64`  
    This package will be installed.
    * `Python` version of `DeepStream 6.2`

    Prerequisite:
    * `DeepStream 6.2`

    #### Usage

    * Install `DeepStream Python`.
        ```bash
        bash install_deepstream_python.sh
        ```
    #### Removal

    * Remove `DeepStream Python` entirely.
        ```bash
        bash remove_deepstream_python.sh
        ```

* Install CUDA - To install `CUDA` on `Ubuntu 22.04`, `Ubuntu 20.04`, and `Ubuntu 18.04`, only `x86_64` architecture is supported.  
    These packages will be installed.
    * `Cuda`
    * `Cudnn`

    <details>
        <summary>See more info</summary>

    Last updated: 2023/07/26

    ## Support Version

    ### CUDA
    | CUDA VERSION | Ubuntu 2204 | Ubuntu 2004 | Ubuntu 1804 |   DRIVER VERSION   |
    | :----------: | :---------: | :---------: | :---------: | :----------------: |
    |    11.8.0    |      O      |      O      |      O      |      520.61.05     |
    |    11.7.1    |      O      |      O      |      O      |      515.65.01     |
    |    11.7.0    |      O      |      O      |      O      |      515.43.04     |
    |    11.6.2    |      X      |      O      |      O      |      510.47.03     |
    |    11.6.1    |      X      |      O      |      O      |      510.47.03     |
    |    11.6.0    |      X      |      O      |      O      |      510.39.01     |
    |    11.5.2    |      X      |      O      |      O      |      495.29.05     |
    |    11.5.1    |      X      |      O      |      O      |      495.29.05     |
    |    11.5.0    |      X      |      O      |      O      |      495.29.05     |
    |    11.4.4    |      X      |      O      |      O      |      470.82.01     |
    |    11.4.3    |      X      |      O      |      O      |      470.82.01     |
    |    11.4.2    |      X      |      O      |      O      |      470.57.02     |
    |    11.4.1    |      X      |      O      |      O      |      470.57.02     |
    |    11.4.0    |      X      |      O      |      O      |      470.42.01     |
    |    11.3.1    |      X      |      O      |      O      |      465.19.01     |
    |    11.3.0    |      X      |      O      |      O      |      465.19.01     |
    |    11.2.2    |      X      |      O      |      O      |      460.32.03     |
    |    11.2.1    |      X      |      O      |      O      |      460.32.03     |
    |    11.2.0    |      X      |      O      |      O      |      460.27.04     |
    |    11.1.1    |      X      |      O      |      O      |      455.32.00     |
    |    11.1.0    |      X      |      O      |      O      |      455.23.05     |
    |    11.0.3    |      X      |      O      |      O      |      450.51.06     |
    |    11.0.2    |      X      |      O      |      O      |      450.51.05     |
    |    11.0.1    |      X      |      X      |      O      |      450.36.06     |

    ### CUDNN
    | CUDNN VERSION | CUDA VERSION | Ubuntu 2204 | Ubuntu 2004 | Ubuntu 1804 | VERSION LEVEL |
    | :-----------: | :----------: | :---------: | :---------: | :---------: | :-----------: |
    |     8.6.0     |     11.8     |      O      |      O      |      O      |      163      |
    |     8.5.0     |     11.7     |      O      |      O      |      O      |       96      |
    |     8.4.1     |     11.6     |      X      |      O      |      O      |       50      |
    |     8.4.0     |     11.6     |      X      |      O      |      O      |       27      |
    |     8.3.3     |     11.5     |      X      |      O      |      O      |       40      |
    |     8.3.2     |     11.5     |      X      |      O      |      O      |       44      |
    |     8.3.1     |     11.5     |      X      |      O      |      O      |       22      |

    ## Usage

    ```bash
    bash install_cuda.sh
    ```

    ## Remove Only
    Can remove `Nvidia-driver`, `CUDA`, `CUDNN`
    ```bash
    bash install_cuda.sh --remove
    ```
    </details>