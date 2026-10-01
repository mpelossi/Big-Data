FROM python:3.11.15-bookworm

# Installing Java
RUN apt update
RUN apt install -y openjdk-17-jre

# Alternative Java
# RUN mkdir -p /etc/apt/keyrings
# RUN wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | tee /etc/apt/keyrings/adoptium.asc
# RUN echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list
# RUN apt-get update 
# RUN apt install -y temurin-17-jdk

RUN python3 -m pip install --upgrade pip
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

# Language server for JSONiq
RUN apt-get update && apt-get install -y npm
RUN npm install n -g && n stable

RUN npm i -g jsoniq-language-server@2.12.0
RUN npm explore jsoniq-language-server -g -- npm run ensure-wrapper

RUN jupyter lab --generate-config
RUN echo "c.IdentityProvider.token = ''" >> $HOME/.jupyter/jupyter_lab_config.py
RUN echo "c.ServerApp.password = u''" >> $HOME/.jupyter/jupyter_lab_config.py
RUN echo "c.ServerApp.allow_origin = '*'" >> $HOME/.jupyter/jupyter_lab_config.py

# Disable XSRF protection to allow connections from VSCode's Jupyter extension
RUN echo "c.ServerApp.disable_check_xsrf = True" >> $HOME/.jupyter/jupyter_lab_config.py

CMD jupyter lab --allow-root --ip 0.0.0.0 --no-browser --port 8888 --browser=False