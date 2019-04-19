# Install OpenCV into a Python Virtual Environment

For those who want to automate the OpenCV compilation process **and** install it into an isolated Python virtual environment.


## Disclaimer

As I am primarily an Ubuntu user, I created this project with Ubuntu strongly in mind (version 17.10 at time of writing). Your mileage may vary depending on your target architecture, OpenCV version, and Python version. Please feel free to create a branch and/ or pull request for other environments.

The script in this repo is a derivation of the installation scripts found at [LearnOpenCV](https://github.com/spmallick/learnopencv).


## How to Use

Assumption: You already have a Python virtual environment configured somewhere on your local machine.

Clone the project:

    git clone https://rtaylor@bitbucket.org/rtaylor/opencv_venv.git
    cd opencv_venv

Checkout the branch you want and update the OpenCV submodules:

    git checkout ubuntu17.10-py3-cv3.4
    git submodule update --init --recursive

(Optional) If you want to custom pick your OpenCV version, you can go to the submodules and manually checkout the corresponding branches or tags:

    cd opencv
    git checkout 4.0.1
    cd ../opencv_contrib
    git checkout 4.0.1
    cd ..

(Optional) Create your own branch to make tweaks specific to your target architecture/ Python/ OpenCV versions:

    checkout -b ubuntu19.04-py3-cv4.0.1

Run the `configure.sh` script, supplying it with the path to your Python virtual environment:

    ./configure.sh ~/path/to/venv/

The script will give you some options, then start to configure your OpenCV build. Upon completion, you should see output similar to:

    -- General configuration for OpenCV 3.4.6-dev =====================================
    --   Version control:               3.4.6-45-g4f764b812
    --
    --   Extra modules:
    --     Location (extra):            /home/rtaylor/Workspace/opencv_venv/opencv_contrib/modules
    --     Version control (extra):     3.4.6-7-g7bba4cf0
    --

    ...

    --
    --   Python 3:
    --     Interpreter:                 /home/rtaylor/Workspace/opencv_venv/test_venv/bin/python3 (ver 3.6.3)
    --     Libraries:                   /usr/lib/x86_64-linux-gnu/libpython3.6m.so (ver 3.6.3)
    --     numpy:                       /home/rtaylor/Workspace/opencv_venv/test_venv/lib/python3.6/site-packages/numpy/core/include (ver 1.16.2)
    --     install path:                /home/rtaylor/Workspace/opencv_venv/test_venv/lib/python3.6/site-packages/cv2/python-3.6
    --

    ...

    --
    --   Install to:                    /home/rtaylor/Workspace/opencv_venv/test_venv/local
    -- -----------------------------------------------------------------
    --
    -- Configuring done
    -- Generating done
    -- Build files have been written to: /home/rtaylor/Workspace/opencv_venv/build

Check the options and paths to ensure everything is configured as expected. If everything looks good, then you can build and install OpenCV:

    cd build
    make -j4
    make install

To verify, enable your virtual environment, import OpenCV, and check versions and file paths:

    $ source ~/path/to/venv/bin/activate
    (venv) $ python -V
    Python 3.6.3
    (venv) $ python
    >>> import cv2
    >>> cv2.__version__
    '3.4.6-dev'
    >>> cv2.__file__
    '~/path/to/venv/lib/python3.6/site-packages/cv2/python-3.6/cv2.cpython-36m-x86_64-linux-gnu.so'


## Author & License

This project is maintained by [Robert Taylor](mailto:rtaylor@pyrunner.com) and made available under the MIT license.
