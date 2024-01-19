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

RUN mkdir /home/Dvisual

RUN mkdir /home/Dvisual/pipeline_output

RUN mkdir /home/Dvisual/shared_folder

COPY renv.lock   /home/Dvisual/renv.lock

#COPY functions /home/LinReg/functions

COPY proj_II.Rmd /home/Dvisual/proj_I.Rmd

COPY insurance.csv /home/Dvisual/insurance.csv

# COPY _targets.R /home/housing/_targets.R

RUN R -e "setwd('/home/Dvisual');renv::init();renv::restore()"

RUN cd /home/LinReg  && R -e "rmarkdown::render('/home/Dvisual/proj_I.Rmd', output_file = '/home/Dvisual/pipeline_output/proj_I.html')"

CMD mv  /home/Dvisual/pipeline_output/*  /home/Dvisual/shared_folder/
