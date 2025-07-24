# parent image
# make this an Anaconda image to enable the server to build an RDKit environment
FROM continuumio/anaconda3

# set working dir in the container
WORKDIR /app

# I don't think I can perform the RDKit install from the requirements.txt
# create virtual env for RDKit
#  If this fails, I move on to an environment.yml
#  But I'd rather follow my exact local setup procedure
RUN conda create -n my-rdkit-env

# activate the environment and make sure subsequent commands are run within it
SHELL ["conda", "run", "-n", "my-rdkit-env", "/bin/bash", "-c"]

# the above shell command should activate environment and make sure all commands run within it
#  but it didn't work on first pass, so I am manually activating
RUN conda activate my-rdkit-env
RUN conda install conda-forge::rdkit

# copying everything, even though I think I should only need to ./src directory
COPY . .

# specify the port this app's server-side code listens on
EXPOSE 8080

# define a command to run the application
# when the "application" is run, that's just equivalent to spinning up a server within our container to host the RDKit fn
CMD ["python", "src/serv_rdk.py"]