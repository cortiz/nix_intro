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
export JAVA_HOME=/opt/java
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

# Pattern Matching

Also known as globbing or glob, is a term used to describe the expansion or the match of values returned when using wildcards, regular expressions, or other pattern matches. 
The special pattern characters (or wildcards) have the following meanings:
 
* `*` Matches any string, including the null string. 
* `?`  Matches any single character. 
* `[…]` Matches any one of the enclosed characters. A pair of characters separated by a hyphen denotes a range expression; 
* `?(pattern-list)` Matches zero or one occurrence of the given patterns.
* `*(pattern-list)` Matches zero or more occurrences of the given patterns.
* `+(pattern-list)` Matches one or more occurrences of the given patterns.
* `@(pattern-list)` Matches one of the given patterns.
* `!(pattern-list)` Matches anything except one of the given patterns. 

Examples:

```bash
ls *.jar
```
```bash
ls ch[e]*
```

## Shell Expansions

An expansion is performed on the command line after it has been split into tokens. There are seven kinds of expansion performed:

* brace expansion Brace expansion is a mechanism by which arbitrary strings may be generated. 

``` bash
echo a{d,c,b}e
```

* tilde expansion The tilde (~) may be used to refer your own home directory or other users home directory.

	* If the tilde-prefix is a ~+, the value of the shell variable PWD replaces the tilde-prefix
	* If the tilde-prefix is a ~-, the value of the shell variable OLDPWD, if it is set, is substituted.

``` bash
ls ~
```

```bash
cd /etc
pwd
cd /bin
pwd
echo $OLDPWD
# display /etc/ directory listing and not /bin
ls ~-
``` 

* parameter and variable expansion The ‘$’ character introduces parameter expansion, command substitution, or arithmetic expansion. 

``` bash
string=01234567890abcdefgh
echo ${string:7}
echo ${string: -7:2}
```
* ommand substitution allows the output of a command to replace the command itself.
```bash
$(command)
`command`
```

* arithmetic expansion allows the evaluation of an arithmetic expression and the substitution of the result.
```bash
$(( expression ))
```

* process substitution allows a process’s input or output to be referred to using a filename. 

```bash
<(list)
>(list)
```

* word splitting The shell scans the results of parameter expansion, command substitution, 
 and arithmetic expansion that did not occur within double quotes for word splitting. 

* [filename expansion](#pattern-matching)



# Alias

An alias is a keyboard shortcut, an abbreviation to avoiding typing a long command sequence

``` bash
alias la=ls -alh
```
The command-line will automatically be replaced `la` with `ls -alh` 
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
`command2` is executed if, and only if, `command1` **returns an exits status of zero (success).**

``` bash
command1 || command2
```

`command2` is executed if, and only if, `command1` **returns a non-zero exit status.**

The return status of AND and OR lists is the exit status of the last command executed in the list

‘&&’ and ‘||’ have equal precedence, followed by ‘;’ and ‘&’, which have equal precedence 

# Shell Scripts
Shells can also read a file, and execute the commands within the file this file is commonly known as shell scripts. Each shell can have its own syntax for these files, but in this guide, we will use the most common syntax, the `sh` which is also compatible with `zsh` shell.

It's common to add `#!` as the first line of the scripts, this tells the shell which interpreter should be used to execute the script. `#!` is also known as _shebang_  and its **always** followed by the full path of the interpreter that will run the script.

``` bash 
#!/usr/bin/bash 
echo "Hello World"
```
This will make our file to be interpreted by bash, it's also possible to use other interpreters like python, ruby,  nodejs and since Java 10, Java.

``` bash
#!/usr/bin/python3 
print("Hello World")
```

``` bash
#!/usr/bin/env node
const http = require('http');

const hostname = '127.0.0.1';
const port = 3000;

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('Hello World\n');
});

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});
```

It is possible to the a script to use a specific version of a interpreter like the python example, or let the environment decided (node js example) which interpreter will be used (usualy, its the first found in the _$PATH_ variable), the latter is the best practice.


## Condicionals

### If,else & If else

The _test-commands_ list is executed, and if its return status is zero, the consequent-commands list is executed.

* If

``` bash
if [ test-commands  ]; then
	<commands>
fi
```
* If else

``` bash
if [ test-commands  ]
then
<commands>
else
<other commands>
fi
```

* If else if else

``` bash
if [ test-commands  ]
then
<commands>
elif [ test-commands ]
then
<different commands>
else
<other commands>
fi
```


Test Expressions 

* ! EXPRESSION     The EXPRESSION is false.
* -n STRING     The length of STRING is greater than zero.
* -z STRING     The lengh of STRING is zero (ie it is empty).
* STRING1 = STRING2     STRING1 is equal to STRING2
* STRING1 != STRING2     STRING1 is not equal to STRING2
* INTEGER1 -eq INTEGER2     INTEGER1 is numerically equal to INTEGER2
* INTEGER1 -gt INTEGER2     INTEGER1 is numerically greater than INTEGER2
* INTEGER1 -lt INTEGER2     INTEGER1 is numerically less than INTEGER2
* INTEGER1 -ge INTEGER2     INTEGER1 is numerically greater or equal than INTEGER2
* INTEGER1 -le INTEGER2     INTEGER1 is numerically less or equal than INTEGER2
* -d FILE     FILE exists and is a directory.
* -e FILE     FILE exists.
* -r FILE     FILE exists and the read permission is granted.
* -s FILE     FILE exists and it's size is greater than zero (ie. it is not empty).
* -w FILE     FILE exists and the write permission is granted.
* -x FILE     FILE exists and the execute permission is granted.

### Examples
```bash
if [ $value -eq 1 ]
then
  echo "has value"
fi
```

```bash
my_file="myfile.txt"

if [ -s $my_file ]
then
  cat $my_file
else
  echo "File not found"
fi

```

```bash
my_var=2

if [ $my_var -gt 0 ]
then
  echo "More than 2"
elif [ $my_var -lt 0 ]
then
	echo "it's negative"
else
  echo "it's zero"
fi

```

### Case

`case` will selectively execute the command-list corresponding to the first pattern that matches the word.

``` bash
case <variable> in
<pattern 1>)
	commands
;;
<pattern 2>)
	other_command
;;
	*)
	 defautl_command
	;;
esac
```

```bash
case $action in
	start)
		echo starting
	;;
	stop)
		echo stoping
	;;
	restart)
		echo restarting
	;;
	*)
		echo don\'t know
	;;
esac
```


## Loops

* `until` Execute consequent-commands as long as test-commands has an exit status which is not zero.
```bash
until test-commands; do consequent-commands; done
```

``` bash
count=1
until [ $count -gt 5 ]
do
   printf "Count has a value of $count\n"
  ((count++))
done
```

* `while` Execute consequent-commands as long as test-commands has an exit status of zero. 
``` bash
while test-commands; do consequent-commands; don
```

``` bash
i="0"
while [ $i -lt 4 ]
do
	echo "$i"
	i=$[$i+1]
done
```
* `for` Expand words (see Shell Expansions), and execute commands once for each member in the resultant list, with `name` bound to the current member (as internal loop variable $name)
``` bash
for name [ [in [words …] ] ; ] do commands; done
```

``` bash
for (( expr1 ; expr2 ; expr3 )) ; do commands ; done
```

```bash
for file in $(ls); do 
	echo "File is $file";
 done
```

## Functions
A function is essentially a set of commands that can be called numerous times. The purpose of a function is to help you make your bash scripts more readable and to avoid writing the same code over and over again.

``` bash
function_name () {
  commands
}
```

``` bash
function function_name {
  commands
}
```

Variables can also have, the same name as commands, like an alias, this will always take precedence over the actual command. 

Since all shell scripts are interpreted, functions must be declared, before using them.

### Variables Scope
Global variables are variables that can be accessed from anywhere in the script regardless of the scope.  All variables by default are defined as global, even if declared inside the function.

Local variables can be declared within the function body with the _local_ keyword and can be used only inside that function.

``` bash
#!/bin/bash

var1='A'
var2='B'

my_function () {
  local var1='C'
  var2='D'
  echo "Inside function: var1: $var1, var2: $var2"
}
echo "Before executing function: var1: $var1, var2: $var2"

my_function

echo "After executing function: var1: $var1, var2: $var2"
```

### Return Values
When a  function completes, its return value is the status of the last statement executed in the function

```bash
my_function () {
  echo "some result"
  return 55
}
my_function
echo $?
```

### Arguments

To pass any number of arguments to the bash function simply put them right after the function’s name *It is a best practice to double quote the arguments*

*The passed parameters are `$1`, `$2`, `$3` … `$n`, corresponding to the position of the parameter after the function’s name.,

* The `$0` variable is reserved for the function’s name.

* The``$#` variable holds the number of positional parameters/arguments passed to the function.

* The `$*` or `$@` variable holds all positional parameters/arguments passed to the function.

```bash
greeting () {
  echo "Hello $1"
}

greeting "Joe"
```