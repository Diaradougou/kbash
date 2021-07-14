
# kx

```shell 
kx [COMMAND] [help|--help|-help|-h|?] ... 

kx is a bash environment supporting development.

Functions (modify the current shell)
 add-command                Add a command to the kx environment.
 add-component              Add a new component (command scope and directory pair)
 add-function               Add a function.
 bundle                     Runs the project specific bundle
 cd                         cd /home/korsimoro/K/.kbash/test/testdir/kx/[PATH] (or base w/o arg)
 deactivate                 Restores key variables to boot state
 kbash-env                  Display current environment settings.
 kbash-os                   Display os
 kbash-troff                disable KBASH_TRACE
 kbash-tron                 set KBASH_TRACE to trace KBASH internals
 parallel                   Control how many jobs run in parallel.
 reset                      Reload the environment.
 troff                      Stop bash execution trace.
 tron                       Start bash execution trace.


Commands (run as subprocesses)
 about                      Detailed Information about KBASH
 component-list             List all available components
 klang                      Manage KBASH top level languages
 manual                     Generate help manual

No components configured, use kx add-component to add components.

Use kx [FUNCTION|COMMAND|COMPONENT] help for more information.
```

## Functions

Functions manipulate the local shell variables, unlike commands, which are
executed by the shell as a subprocess.

### ```add-command```

kx add_command [help|--help|-help|-h|?] COMMAND_NAME

Add a command to the kx environment.

This will create the file
  /home/korsimoro/K/.kbash/test/testdir/kx/kbash/commands/[COMMAND_NAME].sh
if it does not exist.  You should then edit this file to implement.
The template file used in creation is located at
  /home/korsimoro/K/.kbash/setup/command.sh
You will want to edit 3 things
 1. The oneline help summary that is used in other contexts
 2. The print_help() function, which is the detailed help
 3. The run() function, which is executed as a subprocess



### ```add-component```

kx add_component [help|--help|-help|-h|?] [COMPONENT_ID] [KXX]

Add a new component (command scope and directory pair)


usage: add-component [COMPONENT_ID] [KXX]

This will set up a component in the directory
 - /[COMPONENT_ID]
and will create 
  .... more info

A component



### ```add-function```

kx add_function [help|--help|-help|-h|?] FUNCTION_NAME

Add a function.

This will create the file
  /home/korsimoro/K/.kbash/test/testdir/kx/kbash/functions/[FUNCTION_NAME].sh
if it does not exist.  You should then edit this file to implement.
The template file used in creation is located at
  /home/korsimoro/K/.kbash/setup/function.sh
You will want to edit the 4 function stubs
 1. oneline_help_kx_[FUNCTION_NAME]
 2. cmdline_help_kx_[FUNCTION_NAME]
 3. help_kx_[FUNCTION_NAME]
 4. run_kx_[FUNCTION_NAME]



### ```bundle```

kx bundle [help|--help|-help|-h|?] [Bundle Commend Line]

Runs the project specific bundle


This runs the correctly scoped bundle - ruby requires
a complete path to the bundle wrapper in order to
set the environment correctly.



### ```cd```

kx cd [help|--help|-help|-h|?] [PATH]

cd /home/korsimoro/K/.kbash/test/testdir/kx/[PATH] (or base w/o arg)

This is a shell function, which execute cd as follows:
  cd /home/korsimoro/K/.kbash/test/testdir/kx/[PATH].

If no PATH is provided, this just cds into
  cd /home/korsimoro/K/.kbash/test/testdir/kx



### ```deactivate```

kx deactivate [help|--help|-help|-h|?] 

Restores key variables to boot state



### ```kbash-env```

kx kbash_env [help|--help|-help|-h|?] 

Display current environment settings.

kx env



### ```kbash-os```

kx kbash_os [help|--help|-help|-h|?] 

Display os

This command will report what the kbash utilities think the current operating
system is.

You can use the following functions in the shell environment (or your own)
scripts, if you want a quick check to determine your operating system
- is_osx
- is_linux
- is_windows

This is based off of ```uname``` - so.  You can use kbash-os to show you
the uname output and check the value so is_osx, is_linux, is_windows

For example:
```shell 

  > kx kbash-os
  Checking os: uname ='Linux kisia 4.15.0-48-generic #51-Ubuntu SMP Wed Apr 3 08:28:49 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux'
  Linux Detected
  >
```



### ```kbash-troff```

kx kbash_troff [help|--help|-help|-h|?] 

disable KBASH_TRACE

This is equivalent to
  export KBASH_TRACE=false



### ```kbash-tron```

kx kbash_tron [help|--help|-help|-h|?] 

set KBASH_TRACE to trace KBASH internals

This is equivalent to
  export KBASH_TRACE=true



### ```parallel```

kx parallel [help|--help|-help|-h|?] MAXJOBS

Control how many jobs run in parallel.


Control how many jobs run in parallel



### ```reset```

kx reset [help|--help|-help|-h|?] 

Reload the environment.

In this shell, execute:
  /home/korsimoro/K/.kbash/test/testdir/kx/activate.sh

This will cause the entire kx runtime to be reloaded,
so any changes to functions or commands will be processed.

This will update the activation count from 0 to 1



### ```troff```

kx troff [help|--help|-help|-h|?] 

Stop bash execution trace.

Equivalent to
  set +x



### ```tron```

kx tron [help|--help|-help|-h|?] 

Start bash execution trace.

Equivalent to
  set -x



5
## Commands

### ```about```

```shell 
kx <command> [help]

kx is a bash environment supporting development.

kx is pure anti-pattern, in includes
 - 'within-environment' mutations- bash functions allow forward mutation of the
   active environment, with no guarantees of any stable state, save the single
   application of this function after a clean reset
 - pure 'side-effect' focus.  This is an attempt to identify mutators to the
   filesystem, and to codify them.  All functions and commands in the
   environment are expected to operate upon the filesystem directly.  git
   provides us exceptional visiblity into changes over the active checkout.

kx supports the development of ad-hoc tasks required
to effectively build a complex, multi-project system.

As knowledge is captured w/in the kx script system, it is added
into the compiled node or python build support tools.  But when you have to
adapt to an existing culture, as in a fork, you need a little grease.  The
node and python knowledge is the organized grease to glue a complete system
onto a consistent base.

kx uses a "Convention over Configuration" and heavily seeds a
bash operating environment with functions and variables, supporting
multi-tech integration projects.  The ability to "regenerate" the environment
from the kx reset command means that scripts can be rapidly
edited and applied - recorded in a pull-request, and the collective wisdom
knitting forward.

kx can be rapidly and ad-hoc adjusted, and it is specific to
this repository.  The bashenv orchestrates the connection of the environment
with a conversational mutator - a live bash shell.  As this is bound to a
repository top, the space underneath is managed - so this is effectively a
bash shell over a commit-trail of reference.

kx is scoped by directory (or checkout) - based on the KXX
variable.
  KXX = /home/korsimoro/K/.kbash/test/testdir/kx

For more information, check out this file:
/home/korsimoro/K/.kbash/test/testdir/kx/docs/bashenv.md

In general use kx [cmd] help for more information.
```

### ```component-list```

```shell 
Show component list
```

### ```klang```

```shell 
kx klang kx [LANG] ....

Manage languages

Commands (run as subprocesses)
 node                       System Node
 python                     Manage python configuration
 ruby                       System Node
```

#### ```node```

```shell 
kx klang/node kx node [LANG] ....

Manage Local Node
```

#### ```python```

```shell 
kx klang/python kx klang python [LANG] ....

inspect the local python environment

Commands (run as subprocesses)
 info                       System python information
```

##### ```info```

```shell 
Command not found - no 'info help' in 'project/klang/python'
```

#### ```ruby```

```shell 
kx klang/ruby kx ruby [LANG] ....

Manage Local Ruby

Commands (run as subprocesses)
 cleanrvm                   Detailed Information about KBASH
 info                       Where
 installrvm                 Detailed Information about KBASH
 resetrvm                   Detailed Information about KBASH
```

##### ```cleanrvm```

```shell 
Command not found - no 'cleanrvm help' in 'project/klang/ruby'
```

##### ```info```

```shell 
Command not found - no 'info help' in 'project/klang/ruby'
```

##### ```installrvm```

```shell 
Command not found - no 'installrvm help' in 'project/klang/ruby'
```

##### ```resetrvm```

```shell 
Command not found - no 'resetrvm help' in 'project/klang/ruby'
```

### ```manual```

```shell 
Recursively assemble documentation as a markdown
file.
```


## About

```shell 
kx <command> [help]

kx is a bash environment supporting development.

kx is pure anti-pattern, in includes
 - 'within-environment' mutations- bash functions allow forward mutation of the
   active environment, with no guarantees of any stable state, save the single
   application of this function after a clean reset
 - pure 'side-effect' focus.  This is an attempt to identify mutators to the
   filesystem, and to codify them.  All functions and commands in the
   environment are expected to operate upon the filesystem directly.  git
   provides us exceptional visiblity into changes over the active checkout.

kx supports the development of ad-hoc tasks required
to effectively build a complex, multi-project system.

As knowledge is captured w/in the kx script system, it is added
into the compiled node or python build support tools.  But when you have to
adapt to an existing culture, as in a fork, you need a little grease.  The
node and python knowledge is the organized grease to glue a complete system
onto a consistent base.

kx uses a "Convention over Configuration" and heavily seeds a
bash operating environment with functions and variables, supporting
multi-tech integration projects.  The ability to "regenerate" the environment
from the kx reset command means that scripts can be rapidly
edited and applied - recorded in a pull-request, and the collective wisdom
knitting forward.

kx can be rapidly and ad-hoc adjusted, and it is specific to
this repository.  The bashenv orchestrates the connection of the environment
with a conversational mutator - a live bash shell.  As this is bound to a
repository top, the space underneath is managed - so this is effectively a
bash shell over a commit-trail of reference.

kx is scoped by directory (or checkout) - based on the KXX
variable.
  KXX = /home/korsimoro/K/.kbash/test/testdir/kx

For more information, check out this file:
/home/korsimoro/K/.kbash/test/testdir/kx/docs/bashenv.md

In general use kx [cmd] help for more information.
```

