# How to run
Make sure Docker is installed and working on your system
Clone the repository: git clone git@github.com:rap4all/housing.git
Switch to the docker branch: git checkout docker
Build the Docker image using docker build -t housing_image .
Run the Docker container (and mount a volume) using docker run --rm --name housing_container -v /path/to/shared_folder:/home/housing/shared_folder:rw housing_image
Check the contents of shared_folder for the output.
