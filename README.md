# Dockerized Neovim
Run neovim in a container and be cool like all the other cool kids.
I like to dockerize all my tools so I am making this repo to dockerize Neovim.

# Step 1: Build the image
The first step is to build the the docker image.
I call mine thornycrackers/neovim so you will have to change that accordingly for the following steps
```
$ make build
```

# Step 2: Run the image
Say you have a local file called 'test.php' and you are in the same directory as the file.
To open that file with the neovim container simply run the following
```
$ docker run -i -t -v $(pwd):/src thornycrackers/neovim /bin/sh -c 'nvim /src/test.php'
```
This will open up neovim and when you exit neovim it will exit the container.

# Step 3: Make this command a little more useful
So using that command is awesome but a little cumbersome everytime you want to run it against a different file.
Create a file called 'nvim' and make sure to give it executable permissions and place it somewhere in your $PATH.
Copy the following inside of the 'nvim' executable file.

```
#!/bin/bash
# Command for running neovim

if [[ "$1" = /* ]]; then
  file_name="$(basename ${1})"
  dir_name="$(dirname ${1})"
else
  file_name="$1"
  dir_name="$(pwd)"
fi

# Run the docker command
docker run -i -t -P -v "$dir_name":/src thornycrackers/neovim /bin/sh -c "cd /src;nvim $file_name"
```

Now you can run neovim as if you would regularly.
The only gotcha I've deiscovered so far is that because you are mounting to the docker container you cannot go above the folder you open neovim in.
This is a pretty rare case in my trials of using this but it is something to note.

## NOTE:
I do set the git identity to myself inside the Dockerfile so do be aware that you might want to change it to yourself.
