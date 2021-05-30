# Lesson 0: Using The CLI (and installing `git`!)

Congratulations on taking the first step of a long journey to mastering `git`! A tool like `git` can take a lifetime to
learn inside and out, but fortunately, it doesn't take very much time to learn enough to get an enormous benefit out of
it. Over this and the next few chapters, we'll cover the meat and potatoes of using `git`, which will give you the
ability to collaborate in the world of open source, contribute to a project with other software developers in a
professional setting, or work on a project by yourself without worrying about making mistakes that you can't come back
from.

This lesson is divided into two parts - the first part deals with learning how to use a command line and navigate a
file system with it. This is the foundation necessary to use `git`. If you already understand how to navigate around in
a command line, feel free to skip ahead to [the git section](#git-start).

## Using The Command Line

### What is the command line?

To understand what a command line is, let's talk about user interfaces on your computer. Your computer has some software
installed on it called an operating system, and among many things, it provides a graphical user interface (GUI,
pronounced "gooey") that makes your computer easy to use and reason about. This GUI allows you to interact with your
computer by doing things like clicking on icons, or seeing webpages rendered in your web browser.

When you open up your web browser using your GUI, you (1) locate its icon visually, and then (2) use your mouse to
click on it. The basic operation you just performed was that you ran a program. This isn't the only way that you can
run programs, though. Another way is by using a command line (user interface). This is also referred to as a CLI
(no special pronunciation). A CLI is often powered by a terminal or terminal emulator, and is in many ways similar
to a GUI. You use it for basically the same purpose - to run programs.

### Using the CLI

At this point, let's open up a terminal. Here is a picture of a terminal that I have installed on the device I'm
using right this moment:

`Git Bash`

![Git Bash](/images/git-bash.png)

What are we looking at? Here are the components of my terminal, broken down by color:

- The text in green (`jakeh@baozi`) is my user name and host name. A host is just a device on a network, and in our
  case, my personal computer, which I have named `baozi`.
- The text in purple (`MSYS`) is a little complicated to explain. I am using `Git For Windows` in this screenshot,
  which is basically a small environment for running `git` on a Windows operating system. Windows doesn't natively
  support running `git` all by itself because `git` relies on a bunch of programs which primarily live on a Linux
  operating system. What `Git For Windows` does is create a small environment for `git` to run in that acts like a tiny
  Linux distribution. The name of this particular environment is `MSYS`.
- The text in yellow (`~`) is the name of my current directory. `~` is a special directory that acts as an alias for
  the home directory for my user account. Using a special program called `echo`, we can see what the alias `~` stands
  for.

  ![Echo Home Directory](/images/echo-home-dir.png)

- The last bit of text in white (`$`) is simply the start of my command line. It's impossible to tell from the
  screenshot, but I have a blinking cursor at that position which signifies that I can type there.

### Looking at the file system (`pwd`, `ls`)

Let's try out some commands. First, we'll get our bearings. In case you don't have a component of your terminal
that gives your current directory, you can use the following command to figure out where you are, and print
this location. Type it into your terminal and press the enter key.

```sh
pwd
```

`pwd` stands for Personal Working Directory. It is a command that returns the filepath of the directory where it
is run, so it can tell you where you are when navigating your filesystem from CLI. In my case, I got the following
output:

```sh
/c/Users/jakeh
```

More than likely, you are in the home directory (`~`). This is a common place to put "personal" files that do
not belong to the operating system. Your home directory is a very convenient place to put code, notes, or other
personal files of any kind.

You can see the files that are in your current directory by using the `ls` command.

```
ls
```

`ls` is short for "list". This will list out the contents of the current folder you're in, both files and folders. I have a lot of things in my
home directory - I should probably clean it up, sometime.

![ls output](/images/ls.png)

### Adding to and deleting from the file system (`touch`, `rm`, `mkdir`)

I'm going to assume that you don't have any files or folders at all in your home directory, which is not realistic,
but will allow us to do some operations without worrying about impacting your existing files and folders.

So! Since you don't have any files in your home directory, let's make one. We can use `touch` for this. Unlike the previous
two commands, we have to give an _argument_ to `mkdir` so that it knows what we want to call our file.

```sh
touch my-test-file
```

An argument is one way that we can change the behavior of a program. A lot of the time, a simple program will act kind of like
a function in mathematics. When you give an argument to a mathematical function, you are giving it _input_, which may change its
_output_. The argument we supplied to `touch` was the input value `my-test-file`, and the output it gives us is a file named
`my-test-file`. Arguments are separated by spaces, which is why I didn't use any in the multi-word file name: `my-test-folder`.
If we had instead used:

```sh
touch my test file
```

We would have ended up with three files, named `my`, `test`, and `file`.

Now that we've run `touch` and created `my-test-file`, let's see if it exists by using `ls` again to see the contents of our
current directory.

```sh
ls
```

We should get some output that looks like:

```sh
my-test-file
```

And maybe some output that looks like:

```sh
file my my-test-file test
```

... if we accidentally ran both shell commands!

Now that we understand how to create files, let's try creating a directory with `mkdir`. Like `touch`, you need to
specifiy an argument when you invoke it. The argument will be the name of the directory you want to make with `mkdir`.
Let's try the following:

```sh
mkdir my-test-directory && ls
```

This will perform two commands, one after the other:

1.  `mkdir my-test-directory`, which will create the directory.
2.  `ls`, which will list the contents of the folder. Since it will be run after the first command, we'll be able to see our new directory.

Now that we have created all of these files and folders, we can clean up after ourselves with some deletion. We use `rm`
(short for "remove") to delete files and folders. We can even specify multiple arguments if we would like. Try
running the following. It has the names for the other files that may have been accidentally created, too, in case we did
actually create those files by mistake:

```sh
rm my-test-file my test file
```

In case you didn't accidentally create those files, you can still run the above code as-is, and it will simply output
a message to the console for any files that did not exist, saying that it cannot remove it (fair enough!). The other
files that do exist will still be deleted.

Now we can try to delete the directory. Please run the following:

```sh
rm my-test-directory
```

Emphasis on the word "try"... we got an error!

```sh
rm: cannot remove 'my-test-directory': Is a directory
```

We have to use something special to delete directories called an `Option`. Some commands have special
behavior when you specify some `Option` as you invoke it. It usually looks like a dash (`-`) followed by a letter
that signifies the specific option. It can also look like two dashes (`--`), followed by dash-separated words, like
`--one-file-system` or `--no-preserve-root`.

The option we want to use with `rm` is `-r`, which stands for "recursive". It's the option that allows us to
remove directories and their contents. We can now try the following:

```sh
rm -r my-test-directory
```

We can check our work with `ls`. As a rule of thumb, you should use `ls` a lot; basically, any time you would
ever need to know about the state of the directory that you're working in (which is more than likely, constantly).

```sh
ls
```

### Navigating in the filesystem (`cd`, tab-completion, filepaths)

Let's talk about how to get around our filesystem and break free of our safe, familiar home directory. First,
let's create a directory that we can use to practice moving round.

```sh
mkdir go-in-here
```

Now, we can `cd` to move into the directory. `cd` is short for "change directory". We can try the following,
now:

```sh
cd go-in-here
```

Now, if we use `pwd` to see where we are...

```sh
pwd
```

You should see that we're in `go-in-here`, which is inside of your home directory. My output for `pwd` looks
like this:

```sh
/c/Users/jakeh/go-in-here
```

We can also use `cd` to go up a directory. To do that, we use the special directory object `..`. First, we
can see that this object exists in `go-in-here` using `ls` with the `-a` flag (for all objects, even hidden ones).

```sh
ls -a
```

This should give the output:

```sh
. ..
```

The single `.` is an object that stands for the directory itself. We can use `cd` with it, as well.

```sh
cd .
```

If we use `pwd` now, we should see that we haven't moved. Weird, but not unexpected. The `..` object always
refers to a directory's parent directory, which in this case, would be the home directory. Using it will bring
us back home:

```sh
cd ..
```

We can traverse directories in even more direct ways than going up and down directory structures a single level
at a time. Let's create some nested directories that we can practice using `cd` with some more. Copy and paste
the following code so that you don't have to type it all up, where we use `mkdir` with the `-p` option (which
stands for "parents", and allows us to create arbitrarily nested directories like this):

```sh
mkdir -p go-in-here/and-here/and-here/and-here/and-here/and-here/and-here/and-here/and-here/and-here/and-here/and-here/and-here
```

Now, we can `cd` as far in as we like. Let's go in just two levels, for now.

```sh
cd go-in-here/and-here
```

To get back home, we can use `../..`, which is another way of saying the parent directory's parent directory.

```sh
cd ../..
```

Finally, let's go all the way into that nested directory structure. We don't want to have to type all of that junk ourselves, though.
We can use tab completion to decrease the effort necessary to navigate to that deeply nested directory.

```sh
# First, type the first couple of letters of `go-in-here`
cd go-

# Now, press the TAB key. It should autocomplete the directory name `go-in-here`.
# Don't push ENTER yet!
cd go-in-here

# Continue pressing the TAB key until the argument to `cd` is the entire filepath
# to the deeply nested directory, and press ENTER.
cd go-in-here/and-here/and-here/and-here/and-here/and-here/and-here/and-here/and-here/and-here/and-here/and-here/and-here
```

Using `pwd` now should give us a very long filepath! But how can we get out of here? Do you remember how we said that
`~` is an alias for the home directory? Well, instead of using `cd ..` over and over, or even tab-completing the `cd ../../`
filepath that we could use to escape, that way, we can just use the alias:

```cd
cd ~
```

Now, we're back in our home directory!

### Extended reading (`cat`, `less`, `man`, `mv`, `cp`, `which`)

There are many, many commands that you will find useful for navigating and manipulating the world of your filesystem.
There are too many good ones to talk about here, but here are some of the really important ones:

- `cat`: Has many uses, including concatenating files, and printing file contents as output to the console. This is a good
  thing to do for short files that are not longer than the length of your terminal window (maybe 10 lines).
- `less`: This is a useful command for reading the contents of a file in a buffer. Good for longer files than what you
  would print with `cat`. You can use `j` and `k` to scroll up and down in `less`, and `q` to quit.
- `man`: "man" is short for "manual", and you can use it to read any documentation on a built-in or otherwise CLI command,
  using the format `man program-name`. For example, `man rm` will allow you to read the "man page" for the `rm` command. This
  can tell you what kinds of subcommands it may have, flags it may accept, the format for its arguments, and everything else
  you would want to know about using `rm`. Man pages are opened in a `less` buffer, so understanding basic `less` is ideal.
- `cp`: Short for "copy", creates a copy of a file using two arguments, a SRC filepath and a DEST filepath. Use the `-r` flag
  to copy directories.
- `mv`: Short for "move", allows you to move files around your filesystem. This is also how you rename files in the same directory.
  Has the same arguments as `cp`. Fun fact: `mv` is an alias for `cp` and `rm`!
- `which`: This tells you where exactly on your filesystem a command or built-in is located. For example, the output for `which less`
  may be `/usr/bin/less`, meaning that `less` lives at that filepath.

## <div id="git-start" />Okay! I'm ready to learn more about `git`, let's get started!

Awesome! The first thing you'll need to do is see if you already have `git` installed on your machine and whether it's
in your `PATH` ([ELI5](0)). The way we'll do this will be by opening up a terminal and using the `which` command to
find the `git` program on our system, if it exists in our `PATH`. You can do this by typing the following into your
terminal and pressing enter:

```bash
which git
```

If you have `git` installed, you'll be able to see the output from this program as an [absolute path](1) to the
location where `git` is installed in your system. My output looks like the following, since I have `git` installed:

```sh
/usr/bin/git
```

**If you do not have `git` installed you will see no output!**

# Installing `git`

## Windows

If you are using the recommended terminals in this guide, you're in luck! Installing `git` will be very
straightforward. If you are using Git for Windows, you already have `git` installed! Great job!

If you are using `WSL`, you should follow the instructions for installing `git` that are found in the Linux section.

## Mac

If you have `homebrew` installed, you can skip this step. First, use the following script to install `homebrew`:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Once you have `homebrew` installed, you can install `git` with it like so:

```sh
brew install git
```

This should automatically add `git` to your `PATH`. You can check that `git` installed successfully when you're done by
using the version command for `git`.

```sh
git --version
```

If it worked, you should see version information printed to your console!

## Linux

You may need to use a distro-specific package manager besides `apt` to install `git`. The following instructions are
for the Ubuntu distro, which uses `apt` as its package manager.

```sh
sudo apt install git
```

As with the Mac instructions, you should be able to check if `git` installed successfully by using `git --version` to
see if you receive any version information output.

# Nice, turns out I'm actually ready now!

Cool beans! Now it's time to do something with your new `git` command. Let's clone this repository!

## Wait... What does clone mean? And what's a repository?

Ah, I'm glad that you asked, you rhetorically convenient person! Let's break down these concepts. We'll start with
what a repository is.

According to the [man pages](2) for `git-init`, a repository is:

> basically a [directory containing a] .git directory with subdirectories for objects, refs/heads, refs/tags, and
> template files.

Is that useful? Not really! I probably should have quoted from the [Geeks For Geeks](3) article instead:

> Repositories in GIT contain a collection of files of various different versions of a Project. These files are
> imported from the repository into the local server of the user for further updations (_sic_) and modifications in the
> content of the file.

Let's try to dig into this a little more. What is meant by different versions? What about "local server"?

## As rhetorical window dressing, I just want to know what a repository is without the smokescreen, please and thank you.

Right! Thanks for keeping me honest and on-task, fictional counterpart.

A `git` repository (commonly referred to as "repo" for short) is a collection of files that are being managed by `git`.
Let's take this repository as an example (Yep! This file and the associated lessons are all in a `git` repo!). These
files are located in a physical sense on a GitHub server, and you are viewing them through your web browser
(presumably). They were put there by me, the creator of this repository. I don't have access to GitHub's servers in an
intimate way, though, and I had to create the files locally, first, before sending them to GitHub.

So far, GitHub has an idea of these files altogether, and my local dev machine has an idea of these files altogether.
The concept of these files altogether, being managed by `git`, is called a "repository". Repositories can physically
exist in different places, but when they refer to the same collection of files, we say that they are the same
repository.

What does it mean for these files to be managed by `git`? Well, `git` is a version control program, which means that it
concerns itself with managing changes in collections of files. Have you ever been writing a paper for a class when you
weren't quite sure what you were doing, and you ended up having to create several different versions of the paper as
you worked through it?

```
|- English Papers
   |- hamlet-assignment_rough-draft-v1.txt
   |- hamlet-assignment_rough-draft-v2.txt
   |- hamlet-assignment_rough-draft-v2.1.txt
   |- hamlet-assignment_FINISHED.txt
   |- hamlet-assignment_FINISHED-2.txt
   |- hamlet-assignment_FINISHED-2-FINAL.txt
```

No, just me? Fair enough, but I hope that the example makes sense!

What `git` does is come up with a way to manage these _versions_ in a way that doesn't require keeping the version
files themselves out in plain sight. It gives us a way to refer to versions of files in a leaner, more abstract way
that functions in a similar fashion to saving the state of your video game. We'll dive pretty deeply into exactly how
that works in later lessons. For now, let's put a pin in that concept and get back to this idea of repositories living
in multiple places, but all being a part of the "same" repository.

So far, we know about two repositories. Here's a picture for funsies, and maybe as a reference point:

```
┌───────────────────┐
│ GitHub repository │
└────┬────────▲─────┘
     │        │
     │        │
     │        │
 ┌───▼────────┴───┐
 │Local repository│
 └────────────────┘
```

I'm creating and altering files in the "Local repository" (this is in the filesystem on my computer) and eventually,
those changes are making their way to the "GitHub repository". Relative to me, the "GitHub repository" has a special
name. It's a `remote` repository.

This concept of `remote` repositories is how we can say that there are collections of files managed by `git` on two
different computers, and that they both belong to the "same" repository. What a repository _actually_ is, is an
association, created by `git`, between a collection of files, who have a property of being synchronizing with other
collections of files with the same association.

How this synchronization works is also something that we can elaborate on in a later lesson (Spoiler alert: It's
INCREDIBLE!). For now, we can content ourselves with learning what `clone` means, and how to do it.

## Okay, teach me to "clone"! Whatever that means...

So I didn't include it earlier, but you're actually a part of the above diagram. Here, let me redraw it:

```
┌───────────────────┐             ┌────────────────────────────────────────┐
│ GitHub repository ├────────────►│You, you absolute star! And your device!│
└────┬────────▲─────┘             └────────────────────────────────────────┘
     │        │
     │        │
     │        │
 ┌───▼────────┴───┐
 │Local repository│
 └────────────────┘
```

You too can participate in this diagram and its system of cryptic arrows! What that should imply to you is that if you
know what you're doing, you can become a part of this system, and have a local repository of this code, yourself. This
means that me, you, (hopefully) other readers, and GitHub will all have a local instance of this repository, and to
each other, we will all be `remote`. In this case, the only `remote` that we have mutual access to is the repository
that is hosted by GitHub. Sorry, it's nothing personal, but you can't talk to me, and I can't talk to you. GitHub has to be
the middle man, because I (the repository owner) chose to host my repository, there. We're beholden to GitHub, in that way.

Mechanically, the way you'll participate in this system and become a part of the action is by using the
[`git clone`](4) command. Toward the top of your window (if you're viewing this page in a web browser), you should see
the "Code" button. Click it to see the following:

![git clone code dropdown](/images/git-clone.png)

We want to copy the value under `HTTPS` that includes the text:

```
https://github.com/jakehamtexas/git-tutorial.git
```

Now, you can open a terminal. Use it to navigate to any directory and use the following command:

```
git clone https://github.com/jakehamtexas/git-tutorial.git
```

This will do two things.

1. It will create a directory called `git-tutorial` in whatever directory you ran the command in.
2. It will fill that directory with all the contents of this repository, in addition to a `.git` folder.

You should see some output like the following:

```
Cloning into 'git-tutorial'...
remote: Enumerating objects: 38, done.
remote: Counting objects: 100% (38/38), done.
remote: Compressing objects: 100% (23/23), done.
remote: Total 38 (delta 17), reused 33 (delta 15), pack-reused 0
Receiving objects: 100% (38/38), 10.05 KiB | 3.35 MiB/s, done.
Resolving deltas: 100% (17/17), done.
```

When it finishes, you should be able to run an `ls` to see that the directory was created.

```
ls
```

Output:

```
git-tutorial # and whatever files and directories were already in here, if any
```

The output this gives is all of the folders and files in the current working directory. You should now be
able to change directories into the `git-tutorial` directory with `cd`:

```
cd git-tutorial
```

Now, if you use `ls`, you should see the root level contents of this directory, which at the time of this writing are a
`LICENSE`, a `README.md`, a `lessons` directory, and an `images` directory.

```
ls
```

Output:

```
LICENSE README.md images lessons
```

But where is the `.git` folder?

If you want to see the `.git` folder, you have to use `ls` with the `-a` argument to show all files and folders. In
Linux (and Linux-like shells), `ls` does not show files and folders that are prefixed with `.`, by default. These are
said to be "hidden" files/folders.

```
ls -a
```

Output:

```
. .. .git LICENSE README.md images lessons
```

You should now see the `.git` directory, which is all the assurance we need that we are now in a `git` repository!
Woohoo!

Congratulations on making it this far, you've succeeded in completing the preliminary steps in learning `git`!
When you're ready, check out the next lesson of this tutorial, which can be found here:
[LESSON 1](/lessons/1/README.md)

## What did we learn?

- `git` is a version control system, which means that it has functionality for controlling versions for a collection
  of files, as well as functionality for synchronization with other locations that have this same collection of files.
  Such a collection of files is called a `repository`.
- Repositories that are on your device are called "local" repositories. Repositories that are on foreign devices are
  called `remote` repositories.
- We can use `git clone` to create a local repository from a `remote` repository.

[0]: https://www.reddit.com/r/explainlikeimfive/comments/25duh7/eli5_path_variables_home_and_enviromental/
[1]: https://www.linux.com/training-tutorials/absolute-path-vs-relative-path-linuxunix/
[2]: https://www.man7.org/linux/man-pages/man1/git-init.1.html
[3]: https://www.geeksforgeeks.org/what-is-a-git-repository/
[4]: https://www.toolsqa.com/git/git-clone/
