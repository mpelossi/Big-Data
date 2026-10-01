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
RUN pip3 install jupyterlab==4.5.5
RUN pip3 install jupysql==0.11.1
RUN pip3 install psycopg2==2.9.12
# psycopg 3 is SQLAlchemy 2.1's default driver for postgresql:// URLs; psycopg2 is still imported by exercise13
RUN pip3 install "psycopg[binary]==3.3.6"
RUN pip3 install pyspark==4.0.2
RUN pip3 install sparksql-magic==0.0.3
RUN pip3 install findspark==2.0.1
RUN pip3 install pandas==2.3.3
RUN pip3 install jsoniq==2.1.7
RUN pip3 install matplotlib==3.10.9
# pandas, pyarrow, grpcio is needed by jupysql
RUN pip3 install pyarrow==21.0.0
RUN pip3 install grpcio==1.74.0
RUN pip3 install grpcio-status==1.74.0

RUN apt-get update && apt-get install -y npm
RUN npm install n -g && n stable

RUN pip3 install jsoniq-jupyterlab-extension==2.0.0a11
RUN pip3 install jupyterlab-lsp==5.3.0
RUN pip3 install jupyter-lsp==2.3.1

# ponytail: tornado 6.5.9 breaks jupyter_server 2.21 static files (500 on main.js); unpin once jupyter_server fixes it
RUN pip3 install tornado==6.5.8

RUN npm i -g jsoniq-language-server@2.11.0
RUN npm explore jsoniq-language-server -g -- npm run ensure-wrapper

RUN jupyter lab --generate-config
RUN echo "c.IdentityProvider.token = ''" >> $HOME/.jupyter/jupyter_lab_config.py
RUN echo "c.ServerApp.password = u''" >> $HOME/.jupyter/jupyter_lab_config.py
RUN echo "c.ServerApp.allow_origin = '*'" >> $HOME/.jupyter/jupyter_lab_config.py

# Disable XSRF protection to allow connections from VSCode's Jupyter extension
RUN echo "c.ServerApp.disable_check_xsrf = True" >> $HOME/.jupyter/jupyter_lab_config.py

CMD jupyter lab --allow-root --ip 0.0.0.0 --no-browser --port 8888 --browser=False