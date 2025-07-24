# parent image
# make this an Anaconda image to enable the server to build an RDKit environment
FROM continuumio/anaconda3

# set working dir in the container
WORKDIR /app

# create virtual env for RDKit
RUN conda create -n my-rdkit-env
# activate environment and make sure all commands run within it
RUN echo "source activate my-rdkit-env" > ~/.bashrc
ENV PATH /opt/conda/envs/my-rdkit-env/bin:$PATH

# perform the conda-forge recommended rdkit install
RUN conda install conda-forge::rdkit

# copying everything, even though I think I should only need to ./src directory
COPY . .

# specify the port this app's server-side code listens on
EXPOSE 8080

# define a command to run the application
# when the "application" is run, that's just equivalent to spinning up a server within our container to host the RDKit fn
CMD ["conda", "run", "-n", "my-rdkit-env", "python", "src/serv_rdk.py"]