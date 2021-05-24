# Lesson 0: Installation And Other Extremely Boring Things

Congratulations on taking the first step of a long journey to mastering `git`! A tool like `git` can take a lifetime to learn inside and out, but fortunately, it doesn't take very much time to learn enough to get an enormous benefit out of it. Over this and the next few chapters, we'll cover the meat and potatoes of using `git`, which will give you the ability to collaborate in the world of open source, contribute to a project with other software developers in a professionl setting, or work on a project by yourself without worrying about making mistakes that you can't come back from.

# Okay! I'm ready, let's get started!

Awesome! The first thing you'll need to do is see if you already have `git` installed on your machine and whether it's in your `PATH` ([ELI5](0)). The way we'll do this will be by opening up a terminal and using the `which` command to find the `git` program on our system, if it exists in our `PATH`. You can do this by typing this following into your terminal and pressing enter:

```sh
which git
```

If you have `git` installed, you'll be able to see the output from this program as an [absolute path](1) to the location where `git` is installed in your system. My output looks like the following, since I have `git` installed:

```sh
/usr/bin/git
```

**If you do not have `git` installed you will see no output!**

# Installing `git`

## Windows

If you are using the recommended terminals in this guide, you're in luck! Installing `git` will be very straightforward. If you are using Git for Windows, you already have `git` installed! Great job!

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

This should automatically add `git` to your `PATH`. You can check that `git` installed successfully when you're done by using the version command for `git`.

```sh
git --version
```

If it worked, you should see version information printed to your console!

## Linux

You may need to use a distro-specific package manager besides `apt` to install `git`. The following instructions are for the Ubuntu distro, which uses `apt` as its package manager.

```sh
sudo apt install git
```

As with the Mac instructions, you should be able to check if `git` installed successfully by using `git --version` to see if you receive any version information output.

# Nice, turns out I'm actually ready now!

Cool beans! Now it's time to do something with your new `git` command. Let's clone this repository!

## Wait... What does clone mean? And what's a repository?

Ah, I'm glad that you asked, you rhetorically convenient person! Let's break down these concepts. We'll start with what a repository is.

According to the [man pages](2) for `git-init`, a repository is:

> basically a [directory containing a] .git directory with subdirectories for objects, refs/heads, refs/tags, and template files.

Is that useful? Not really! I probably should have quoted from the [Geeks For Geeks](3) article instead:

> Repositories in GIT contain a collection of files of various different versions of a Project. These files are imported from the repository into the local server of the user for further updations (*sic*) and modifications in the content of the file.

Let's try to dig into this a little more. What is meant by different versions? What about "local server"?

## As a rhetorical figment, I just want to know what a repository is without the smokescreen, please and thank you.

Right! Thanks for keeping me honest and on-task, fictional counterpart.

A `git` repository (commonly referred to as "repo" for short) is a collection of files that are being managed by `git`. Let's take this repository as an example (Yep! This file and the associated lessons are all in a `git` repo!). These files are located in a physical sense on a GitHub server, and you are viewing them through your web browser (presumably). They were put there by me, the creator of this repository. I don't have access to GitHub's servers in an intimate way, though, and I had to create the files locally, first, before sending them to GitHub.

So far, GitHub has an idea of these files altogether, and my local dev machine has an idea of these files altogether. The concept of these files altogether, being managed by `git`, is called a "repository". Repositories can physically exist in different places, but when they refer to the same collection of files, we say that they are the same repository.

What does it mean for these files to be managed by `git`? Well, `git` is a version control program, which means that it concerns itself with managing changes in collections of files. Have you ever been writing a paper for a class when you weren't quite sure what you were doing, and you ended up having to create several different versions of the paper as you worked through it?

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

What `git` does is come up with a way to manage these _versions_ in a way that doesn't require keeping the version files themselves out in plain sight. It gives us a way to refer to versions of files in a leaner, more abstract way that functions in a similar fashion to saving the state of your video game. We'll dive pretty deeply into exactly how that works in later lessons. For now, let's put a pin in that concept and get back to this idea of repositories living in multiple places, but all being a part of the "same" repository.

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

I'm creating and altering files in the "Local repository" (this is in the filesystem on my computer) and eventually, those changes are making their way to the "GitHub repository". Relative to me, the "GitHub repository" has a special name. It's a `remote` repository.

This concept of `remote` repositories is how we can say that there are collections of files managed by `git` on two different computers, and that they both belong to the "same" repository. What a repository _actually_ is, is an association, created by `git`, between a collection of files, who have a property of being synchronizing with other collections of files with the same association.

How this synchronization works is also something that we can elaborate on in a later lesson (Spoiler alert: It's INCREDIBLE!). For now, we can content ourselves with learning what `clone` means, and how to do it.

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

You too can participate in this diagram and its system of cryptic arrows! What that should imply to you is that if you know what you're doing, you can become a part of this system, and have a local repository of this code, yourself. This means that me, you, (hopefully) other readers, and GitHub will all have a local instance of this repository, and to each other, we will all be `remote`. In this case, the only `remote` that we have mutual access to is the repository that is hosted by GitHub. Sorry, it's nothing personal, but you can't talk to me, and I can't talk to you. We're beholden to GitHub, in that way.

Mechanically, the way you'll participate in this system and become a part of the action is by using the [`git clone`](4) command. Toward the top of your window (if you're viewing this page in a web browser), you should see the "Code" button. Click it to see the following:

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

The output this gives is all of the folders and files in the current working directory. You should now be able to change directories into the `git-tutorial` directory with `cd`:

```
cd git-tutorial
```

Now, if you use `ls`, you should see the root level contents of this directory, which at the time of this writing are a `LICENSE`, a `README.md`, a `lessons` directory, and an `images` directory. 

```
ls
```
Output:
```
LICENSE README.md images lessons
```
But where is the `.git` folder?

If you want to see the `.git` folder, you have to use `ls` with the `-a` argument to show all files and folders. In Linux (and Linux-like shells), `ls` does not show files and folders that are prefixed with `.`, by default. These are said to be "hidden" files/folders.

```
ls -a
```

Output:

```
. .. .git LICENSE README.md images lessons
```

You should now see the `.git` directory, which is all the assurance we need that we are now in a `git` repository! Woohoo!

Congratulations on making it this far, you've succeeded in completing the preliminary steps in learning `git`! When you're ready, check out the next lesson of this tutorial, which can be found here: [LESSON 1](/lessons/1/LESSON.md)!

## What did we learn?

- `git` is a version control system, which means that it has functionality for controlling versions for a collection of files, as well as functionality for synchronization with other locations that have this same collection of files. Such a collection of files is called a `repository`.
- Repositories that are on your device are called "local" repositories. Repositories that are on foreign devices are called `remote` repositories.
- We can use `git clone` to create a local repository from a `remote` repository.

[0]: https://www.reddit.com/r/explainlikeimfive/comments/25duh7/eli5_path_variables_home_and_enviromental/
[1]: https://www.linux.com/training-tutorials/absolute-path-vs-relative-path-linuxunix/
[2]: https://www.man7.org/linux/man-pages/man1/git-init.1.html
[3]: https://www.geeksforgeeks.org/what-is-a-git-repository/
[4]: https://www.toolsqa.com/git/git-clone/
