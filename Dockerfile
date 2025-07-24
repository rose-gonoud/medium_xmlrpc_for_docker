# parent image
FROM python:3.9-slim-buster

# set working dir in the container
WORKDIR /app

# copying requirements.txt into the container at /app
COPY requirements.txt .

# install those specified packages
RUN pip install --no-cache-dir -r requirements.txt

# copy everything else into the container at /app
COPY . .

# specify the port this app's server-side code listens on
EXPOSE 8080

# define a command to run the application
# when the "application" is run, that's just equivalent to spinning up a server within our container to host the RDKit fn
CMD ["python", "src/serv_rdk.py"]