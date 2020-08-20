
# GDBKPER

Tool to backup and restore projects to a google drive folder


## Setup

Create a `.env` file in the root of your project

```
# files to zip and backup to google drive
GDBKPER_FILES=*

# google drive folder ID to save zips
GDBKPER_FOLDER_ID=...

# gdbkper will insert this line automatically after init
GDBKPER_TOKEN="..."
```


## Usage

```
docker run -it --rm -v $PWD:/backup n1zes/gdbkper <cmd>
```

> You must always mount PWD folder into /backup


* Init

```
docker run -it --rm -v $PWD:/backup n1zes/gdbkper init
```

> Follow the screen instructions to get a google drive token


* Backup

```
docker run -it --rm -v $PWD:/backup n1zes/gdbkper backup
```


* Restore

```
docker run -it --rm -v $PWD:/backup n1zes/gdbkper restore <query>
```
