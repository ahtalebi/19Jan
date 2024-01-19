FROM rocker/r-ver:4.1.2

RUN apt-get update && apt-get install -y \
    libglpk-dev \
    libxml2-dev \
    libcairo2-dev \
    libgit2-dev \
    default-libmysqlclient-dev \
    libpq-dev \
    libsasl2-dev \
    libsqlite3-dev \
    libssh2-1-dev \
    libxtst6 \
    libcurl4-openssl-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    libxt-dev \
    unixodbc-dev \
    wget \
    pandoc


RUN R -e "install.packages('remotes')"

RUN R -e "remotes::install_github('rstudio/renv@0.16.0')"

RUN mkdir /home/dvisual

RUN mkdir /home/dvisual/pipeline_output

RUN mkdir /home/dvisual/shared_folder

COPY renv.lock   /home/dvisual/renv.lock

#COPY functions /home/LinReg/functions

COPY proj_I.Rmd /home/dvisual/proj_I.Rmd

COPY insurance.csv /home/dvisual/insurance.csv

# COPY _targets.R /home/housing/_targets.R

RUN R -e "setwd('/home/dvisual');renv::init();renv::restore()"

RUN cd /home/dvisual  && R -e "rmarkdown::render('/home/dvisual/proj_I.Rmd', output_file = '/home/dvisual/pipeline_output/proj_I.html')"

CMD mv  /home/dvisual/pipeline_output/*  /home/dvisual/shared_folder/
