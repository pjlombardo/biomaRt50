# rocker/rstudio with biomaRt

From rocker/rstudio:latest

MAINTAINER Phil Lombardo, plombard@endicott.edu

ENV PASSWORD=test123

## Get system ready for the biomaRt packages
# Keep in mind these are run as "sudo", so the
# packages will be available in all user accounts

RUN apt-get update -y

RUN apt-get install -y libxml2 libxt6 zlib1g-dev libbz2-dev liblzma-dev libpcre3-dev libicu-dev libjpeg-dev libpng-dev libxml2-dev libglpk-dev

RUN R -e 'install.packages("BiocManager")'

RUN R -e 'BiocManager("biomaRt")'

## With packages installed, create user accounts

# Create root folder for our files
RUN mkdir -p root
RUN cd root
WORKDIR /root

# Move the users.csv with usernames and passwords to
# the image.  EDIT THIS CSV TO MAKE MORE INTERESTING PASSWORDS
ADD users.csv /root

# Add the shell script for creating accounts
ADD create_user_accounts.sh /root
# Make the shell script executable
RUN chmod +x create_user_accounts.sh
# Run the script to create the user accounts and set passwords
RUN ./create_user_accounts.sh


# Expose the port.
EXPOSE 8787

CMD ["/init"]