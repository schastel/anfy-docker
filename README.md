Pull image from docker.io (no account needed)
docker pull docker.io/schastel/anfy:latest

Run a container:
docker run --rm -ti docker.io/schastel/anfy:latest bash
Notes:
--rm: Delete the container when exiting
-ti: Interactive mode (equivalent to -t -i) 

SUGGESTIONS:
- Use a (local) docker volume to store the index files
-> Save space 
- Use a (local) docker volume for the work directory
-> Save your work outside docker 