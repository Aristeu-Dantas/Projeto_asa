docker stop $(docker ps -q)
docker rm $(docker ps -a)
docker rmi $(docker images -a)


docker network rm asa-net

echo "Criando imagens..."
docker build -t c01 -f Dockerfile.c01 .
docker build -t c02 -f Dockerfile.c02 .
docker build -t c03 -f Dockerfile.c03 .

docker build -t proxy -f Dockerfile.proxy .
docker image ls
echo "Criando a rede..."
docker network create -d bridge asa-net

echo "Criando conteiners..."
docker run -d --net=asa-net --name web01 c01
docker run -d --net=asa-net --name web02 c02
docker run -d --net=asa-net --name web03 c03

docker run -dp 80:80 --net=asa-net --name proxy proxy
