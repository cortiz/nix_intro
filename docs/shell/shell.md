Title:   Shell
Summary: What is nix shell.
Authors: Carlos Ortiz
Date:    March 29, 2019


Unix shell is a command-line interpreter or shell that provides a command line user interface for 
Unix-like operating systems. 
The shell is both an interactive command language and a scripting language, 
and is used by the operating system to control the execution of the system using shell scripts.

[TOC]

# Shell Operation
The following is a brief description of the shell’s operation when it reads and executes a command.
Basically, the shell does the following:

1. Reads its input from a file (see [Shell Scripts](#shell-scripts)) or from the user’s terminal.
2. Breaks the input into words and operators. 
   These tokens are separated by metacharacters. Alias expansion is performed by this step (see [Alias](#alias)).
3. Parses the tokens into simple and compound commands.
4. Performs the various shell expansions, 
   breaking the expanded tokens into lists of filenames and commands and arguments.
5. Performs any necessary redirections (see [Pipes and Redirections](#pipes-and-redirections))
   and removes the redirection operators and 
   their operands from the argument list.
6. Executes the command.
7. Optionally waits for the command to complete and collects its exit status (see Exit Status).


# Variables
As in any other programming language, the shell has variables, these variables do not have any datatype as they can store a number, a character, a string of characters or lists. All variables are global to the current shell session (but not to a sub-process) 
The standard practice is that variables are always in uppercase, but there is no technical reason why they can't be in lowercase.

To create a variable name it, and assign a value to it

``` bash
MY_VAR="hello"
```
To access a variable, add the `$` prefix to the name of the variable 

``` bash
echo $MY_VAR
```
The shell can also, expand variables within strings created by double-quotes `"` 

``` bash
echo "The value of MY_VAR is $MY_VAR"
```

Using  `export` in front of a variable makes the variable available to sub-processes. This variables, also call Environment Variables

``` bash
export JAVA_HOME:/opt/java
```

Variables are always expanded before running the command (step 4, of Shell Operation)

Shells like bash, zsh, and fish will run scripts on there initialization that populate variables, this scripts can for all users, 
and each user can define it's own (.bashrc or .bash_profile for bash, .zshrc for zsh) in user's home dirrectory. 
These variables will be always present in the shell session. Examples of these variables are:

* USER, current user name
* HOSTNAME, name of the machine
* SHELL, current shell
* PATH, list of directories where the shell will look up for commands.


##  $PATH

The $PATH variable is one of the most important variable in a shell session, since it's a list of directories where the shell will look for executables (binaries, or scripts). The shell will always use the first binary found, so a user can override this variable to change which binary will be used. 
This change can done to a current shell session or make it permanent by adding the override in the shell initialization script.

``` bash
export PATH=/my/bin/location:$PATH
```

# Alias

An alias is a keyboard shortcut, an abbreviation to avoiding typing a long command sequence

``` bash
alias la=ls -alh
```
The command-line will automatically be replaced by `la` with `ls -alh` 
Aliases can be set by shell session or, permanent by adding them in the shell initialization script.

Aliases can be named same as commands, this aliases will take priority over the actual command regardless of its position 
in the _$PATH_ variable this is useful when, we want to add default arguments and options to the command, for example

``` bash
alias grep='grep --color'
``` 

List of common and useful aliases.

```bash 
# Search Through Terminal History
alias hs='history | grep'
#Open file with admin access
alias snano='sudo nano'
#clear terminal screen
alias c='clear'
# Shows all open ports
alias ports='netstat -tulanp'
#Tail a file 
alias t='tail -f'
```

# Exit Status 

The [Portable Operating System Interface (POSIX)](https://en.wikipedia.org/wiki/POSIX)  defines that all process should have an exit code. Exit codes are a number between 0 and 255, which is returned by any Unix command when it returns control to its parent process. 
0 always means that the command was run successfully, any other number, will be interpreted as an error by the shell.

Most POSIX compliant shells will store the Exit code in a variable named `$?`

``` bash
ls 
echo $?
ls IdontExist
echo $?
```
The first `echo $?` will return _0_, since ls run without any issue, The following `echo $?` will return _2_ since, ls was not run successfully, since, _IdontExist_ well, does not exists.



# Pipes and Redirections
>Write programs that do one thing and do it well. Write programs to work together. Write programs to handle text
>streams, because that is a universal interface.
>
> ---  Peter H. Salus. A Quarter-Century of Unix. Addison-Wesley. 1994. ISBN 0-201-54777-5.


Commands can send and receive output from other commands using pipelines and redirections. They both do the same basic
thing; they redirect a file descriptor of the process executed.

Pipe is used to pass output to another **program or utility.**

Redirect is used to pass output to either a **file or stream.**


A pipeline is a sequence of one or more commands separated by one of the control operators ‘|’ or ‘|&’. 

The output of each command in the pipeline is connected via a pipe to the input of the next command. That is, each
command reads the previous command’s output.

``` bash
ls | head -3
```

In the example above we send the output of `ls` to `head -3` so we only print the first 3 results of `ls`

A pipe connects the stdout of one process to the stdin of another.

Redirection allows commands’ file handles to be duplicated, opened, closed, made to refer to different 
files, and can change the files the command reads from and writes to.

At any given time there are always three default files descriptors open, _stdin_ (the keyboard), _stdout_ (the screen), 
and _stderr_ (error messages output to the screen). 
The file descriptors for _stdin_, _stdout_, and _stderr_ are _0_, _1_, and _2_, respectively.

`>` (`>` is the same as `1>`) is the simplest redirection, this will redirect all _stdout_ to a given file.

``` bash
ls > results.txt
```
This will redirect the output of `ls` to a file named `results.txt`

We can also "merge" two file descriptors to point to the same file, this is useful when we want to have the output of _stdout_ and _stderr_ in the same file. To point them to the same file descriptor we use `2>&1` ( same as &>)

That means that the output of 2 (_stderr_) should be redirected to 1 (_stdout_).

``` bash
ls  2>&1 > output.txt
```
In this sequence, we tell the shell that we want the output of  _stderr_(2) to be redirected to _stdout_(1) and the second `>` will send the output of _stdout_ (now merge with _stderr_) to a file name output.txt 

Redirrections will delete any information at there destination before writing anything, to avoid that the `>>` redirect should be used, when used, it will append the new output at the end of the destination.


It is also possible to redirect _stdin_ of a command by using `<` this will read the given file descriptor and send it to the command _stdin_.

``` bash
	cat < myFile.txt
```
By default `cat`  will listen to _stdin_ until the EOF character  (ctrl-d) is sent. In the past example, change _stdin_ to be a file.


# Lists of Commands 

It's possible to run multiple commands as a single line making a list of commands to be run, 
the list is made by using `;` between the commands that we want to run.

``` bash
command1 ; command2; command 3 | command3.1 > myoutput.txt ; command 4
```

It's also possible to run the next command depending on the exit value by using `&&` (AND)  or `||` (OR)

``` bash
command1 && command2
```
`command2` is executed if, and only if, `command1` **returns an exit status of zero (success).**

``` bash
command1 || command2
```

`command2` is executed if, and only if, `command1` **returns a non-zero exit status.**

The return status of AND and OR lists is the exit status of the last command executed in the list

‘&&’ and ‘||’ have equal precedence, followed by ‘;’ and ‘&’, which have equal precedence 


# Tab Completions

# Shell Scripts
