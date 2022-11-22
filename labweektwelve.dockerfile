FROM Ubuntu:18.04

# Installing zsh and curl
RUN apt update && apt upgrade
RUN apt install -y zsh curl

# Make server with memory, CPU, etc.   https://github.com/coder/code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# If a docker file doesn't have a command or entrypoint to execute, it will die.
# When the command finishes its execution, it will die.
# docker rmi -- means docker remove images.
# 0.0.0.0 lets the computer know that the server can be accessed by IP4 addresses on the local machine.
# We cannot use the loopback address because the host and the client machines are different machines. 
CMD ["code-server", "--bind-addr", "0.0.0.0:8080"]



#########################################################################################
# INSTRUCTIONS FOR USER:
# Build : "docker build . -t code-server" in the terminal. "code-server" can be any name.
# run : "docker run -p 80:8080 --name=code-server -d code-server:latest -v C:\Users\least:/root/data". This is saying
#   that the client machine is going to be mapped to port 80 in the host machine. The -d means
#   detach. This will not show the logs. That way the user can keep using the terminal they had
#   open before. This will also allow data to persist by storing it in the host computer instead of
#   the container itself.
# Go onto a web browser and search "localhost"
# To get the password:
#   "docker exec -it coder-server /bin/zsh". This connects the user to the docker container. 
#   In this case, the docker container is using the code-server.
#   "cat ~/.config/code-server/config.yaml"     this will give you the default password
#   to connect to the server.