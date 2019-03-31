Title:   *nix File System.
Summary: WThe *nix File System, permissions.
Authors: Carlos Ortiz
Date:    March 30, 2019


# The File system

> "On a UNIX system, everything is a file; if something is not a file, it is a process."

It makes no difference between a file and a directory, since a directory is just a file containing names of other files. 
Programs, services, texts, images, and so forth, are all files. Input and output devices, and generally all devices, are considered to be files, 
according to the system.

The `-l` option of `ls` displays the file type, using the first character of each input line

``` bash
~/d/r/m/nix_intro> ls -l
total 12
drwxr-xr-x 1 cortiz cortiz   86 Mar 30 18:11 docs/
-rw-r--r-- 1 cortiz cortiz 1590 Mar 30 11:01 Makefile
drwxr-xr-x 1 cortiz cortiz   16 Mar 30 18:35 material-mod/
-rw-r--r-- 1 cortiz cortiz 1280 Mar 30 18:36 mkdocs.yml
-rw-r--r-- 1 cortiz cortiz  244 Mar 30 10:51 requirements.txt
drwxr-xr-x 1 cortiz cortiz  148 Mar 30 14:51 site/
```

| Symbol                   | Meaning       |
| ------------------------ | ------------- |
| -				           | Regular file  |
| d                        | Directory     |
| l                        | Link          |
| c                        | Special file  |
| s                        | Socket        |
| p                        | Named pipe    |
| b                        | Block device  |

## Permissons

Each file and directory has three user based permission groups

* **owner** Apply only the owner of the file or directory, they will not impact the actions of other users.

* **group** Apply only to the group that has been assigned to the file or directory, they will not effect the actions of other users.

* **all users** - Apply to all other users on the system, **this is the permission group that you want to watch the most.**

There are only 3 types of permissions:

* *read*    _r_    - User's capability to read the contents of the file.
* *write*   _w_   - User's capability to write or modify a file or directory.
* *execute* _x_ - User's capability to execute a file or view the contents of a directory.

This permissions can be view, the same way we saw the file type, by using the `-l` of `ls`

``` bash
~/d/r/m/nix_intro> ls -l
total 12
drwxr-xr-x 1 cortiz cortiz   86 Mar 30 18:11 docs/
-rw-r--r-- 1 cortiz cortiz 1590 Mar 30 11:01 Makefile
drwxr-xr-x 1 cortiz cortiz   16 Mar 30 18:35 material-mod/
-rw-r--r-- 1 cortiz cortiz 1280 Mar 30 18:36 mkdocs.yml
-rw-r--r-- 1 cortiz cortiz  244 Mar 30 10:51 requirements.txt
drwxr-xr-x 1 cortiz cortiz  148 Mar 30 14:51 site/
```
Where after, the file type, the first 3, are the owners permissions, the next 3 are the group permission and finally the last 3 are 
the permissions for all the users.

It's possible to change, permissions by using the command `chmod`  recent version of `chmod` now can accept a more graphical way to change the permissions by using chars instead of bit more.

``` bash
chmod a+wrx file
chmod g-w file2
chmod ug+x file3
```
The syntax looks like this.
First, we specified to whom we will give permission by using
* _u_  owner
* _g_  group
* _o_   others
* _a_  all users

We can define multiple affected user and groups by adding them together `ug` or `ag` for example. Then we use `+` or  `-` to add or remove permissions 
*  *_r_* for read
*  *_w_* for write 
* *_x_* for execute  

Like the recipient of the permissions, we can concardate the permission to give multiple at the same time.

For more information about `chmod` check the [command documentation](/cmds/common/chmod), or it's man page `man chmod`