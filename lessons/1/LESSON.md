# Please read: Regarding restoring to the default state

This lesson will involve manipulating the project itself in order to practice some `git` skills. If you run into trouble here and would like an opportunity to start over, there is a shell script in this directory that you can use to reset the state of the `commit-practice` directory. You can run it like so:

```sh
cd lessons/1
sh ./restore.sh
```

It is a good rule of thumb to inspect any shell script that another person asks you to run, **BEFORE YOU RUN IT**. Sometimes people use opportunities like these to get you to run nefarious scripts on your computer that make it do things it shouldn't do, otherwise. I hope I have earned your trust and that you will run my script, but you should always try to see if the script you're about to run will do something damaging to your machine or your data.

# Lesson 1: Keeping Track: Indices And Commits

Look at you! You've conjured a repository into existence, on your machine. Now, it's time to learn about the discrete units of version control, _commits_. These are what version control is made from. Commits are one of the currencies of the `git` world, and how you will exchange information and preserve history.

To envision how commits work, let's play a (short) imagination game. Imagine what it would be like to have a magic camera, whose pictures were not only visual representations of the place and time that they captured. Imagine instead that each image was an _actual and total recreation_ of that point in time, and that you could jump into the still image itself and be transported to that exact moment in time. Let's also imagine that you are an extremely contented and boring person, and that you wouldn't use such a camera to [go back in time to win sportbets with precognition](0), or [deposit a healthy sum into a bank account and wait for compound interest to make you rich](1). What would you do with such a camera?

Why, you would use it to version control your software, of course!

## Har har. Enough with the silly example, what exactly is a `commit`?

A `commit` is a snapshot of your project, at a particular moment in time, which is reflective of the project's changes in relation to whatever `commit` happened before it. Whenever a new `git` repository is created, an initial `commit` is created automatically. This means that you can then create a `commit` yourself and begin creating snapshots of your project as it ages.

A `commit` has several properties:

- The changes in question that the `commit` itself is said to contain. Changes in commits are expressed as some selection of added lines and deleted lines. Changes in `git` are expressed in terms of lines because most files which we seek to meaningfully version control are delimited by linebreaks.
- The author of the `commit`. In the case that only one person works on a repository, this will be the primary maintainer.
- A datetime.
- [A commit SHA](2). This functions as a unique identifier for the `commit`.

What commits are and how they really function is something that we will build an intuition about as we proceed with these lessons. For now, we can keep this mental model of a snapshot in mind. Every `git` repository will have commits, including this one. If you would like to see the commits that are in this repository, you can use the following command in your terminal, inside of the directory where you cloned this project:

```
git log
```

You can use `j` to scroll down and `k` to scroll up. When you are finished looking at this view, press `q` to quit and return to your terminal.

## Okay, I think I have a general idea of what a `commit` is now. How do I create one?

Great question!

In this section, we will talk about the `index`, what it means, and how it relates to commits.

Your `index` (also called `staging`) is an area where you are able to put files and changes when you are considering putting them into a `commit`. This isn't a physical area in the sense that it's a location in your filesystem - what you are actually doing is changing the status of these changes and files to one that allows them to be the target of a future `commit` action. Let's use an example to show this in more detail.

Go ahead and `cd` into `commit-practice` at this point, we're going to be using it quite a bit from here on out.

```sh
cd lessons/1/commit-practice
```

At this point, we're going to learn a new command. It's called `git status`. We can go ahead and run it now:

```sh
git status
```

Output:

```sh
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean
```

What `git status` does is give you an idea of what kinds of operations you have already performed on your `git` repo, what operations are currently in progress, and otherwise, give you a general high-level breakdown of the state of your `git` repo. It is _extremely_ important and will follow you for the rest of your life. You will likely use it _every single time_ you create a `commit`.

The above text that we can see in our output is the bog-standard, totally normal "there is nothing special happening right now" status text. In a cold, uncaring world, the message `nothing to commit, working tree clean` is a swan song of stoic resolve. It means that all of our `git` work is done, for the time being, and it's good news, indeed!

Don't fret about the particulars of what this status message means, right now. We'll cover and understand all of this in due time.

Coming back to the `index`, if we were considering putting some changes to our project into a commit, we would expect to see the changes in question when we use our `git status`. We'll see what that looks like in just a moment. First, let's make some changes!

If you look in the `commit-practice` directory, you'll see the following files:

```sh
ls
```

Output:

```
business-agenda delete-me
```

Let's do all of the following, in whatever order you like:

### Add

We need to add a file to this directory. Any old file will do! This command will echo a string to the console, and then write it to a file called `added-file`.

```sh
echo "I am any old text string, but I have feelings\!" >> added-file
```

### Delete

Let's delete a file next. `delete-me` has lost in a trial by combat and is the next in line for user deletion. Don't pity him, he probably deserved it.

```sh
rm delete-me
```

### Modify

We can modify a file without deleting it or creating it from scratch (shocking, I know!). Find the file called `business-agenda`, open it in your text editor of choice, and delete whichever line you feel is the most offensive to your sense of decency. For simplicity's sake, please delete the entire contents of the line instead of just part of the line, so that the two lines surrounding it are now touching with no whitespace between them.

## I did your dirty work... why did you have to anthropomorphize the files? That was kind of weird.

Sorry, you're right. You're totally right. Good thing you deleted that file that I imbued with consciousness!

Let's navigate up a directory and see what the state of the world is, now, with `git status`:

```sh
# From inside of the `commit-practice` 
# directory, go up to the lessons/1/
# directory and then use `git status`
cd .. && git status
```

Output:

```
On branch main
Your branch is up to date with 'origin/main'

Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   commit-practice/business-agenda
        deleted:    commit-practice/delete-me

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        commit-practice/added-file

no changes added to commit (use "git add" and/or "git commit -a")
```

Wow! There's a lot of new stuff to read here! Let's focus on this line-by-line, starting with "Changes not staged for commit:":

1. "`Changes not staged for commit:`"
    - What this means is that we have introduced some changes to the so-called "working directory". These changes are not "staged" currently, which means that they are not a part of the `index`. Recall that the `index` is the on-deck location for changes that may be committed.
1. "`(use "git add/rm <file>..." to update what will be committed)`"
    - Hm, it seems we can use some `git` commands that will add or remove files from our staging area (`index`).
1. "`(use "git restore <file>..." to discard changes in working directory)`"
    - Uh... and we can also discard changes from the working directory? How is that different from adding or removing files?
    - The answer lies in the fact that sometimes we change _whole files_ and sometimes we change _partial files_. If we change a whole file and we want to commit this change, we can add it to the index with `git add`. If we need a way to remove changes from _partial files_, we can't use `git rm`, because that would make it so that the entire file cannot be committed. So, there's another command called `git restore`.
    - Wait a second... this is like three commands all at once, how am I supposed to internalize this?
    - Honestly, don't worry about it yet, we'll talk some more about all of this.
1. "`modified:   commit-practice/business-agenda`"
    - Yep! That makes sense. We modified this file, we didn't add or remove it.
1. "`deleted:    commit-practice/delete-me`"
    - Yes, this also makes plenty of sense. We deleted this file, so it makes sense that it shows up as `deleted`.
1. "`Untracked files:`"
    - Hm... untracked?
    - "Untracked" here refers to the fact that there are files which are known to the `git` repository, and files that have not yet been acquainted with Mr. Git. If you spin a file out of the aether, your `git` repository won't have any concept of it, yet. You'll have to `git add` it (and later `commit` it) before the file is known to `git`. 
1. "`(use "git add <file>..." to include in what will be committed)`"
    - Yeah, this looks familiar compared to what we saw earlier in the text about "Changes not staged for commit".
1. "`commit-practice/added-file`"
    - Sure, that's definitely the file.
1. "`no changes added to commit (use "git add" and/or "git commit -a")`"
    - Hm... another `git` command I don't know yet. We'll have to keep that in mind for later.

There appears to be a lot of information here. First of all, we are being forced to infer that there's a sort of flow or continuity to the states of files, that resembles something like the following:

```
    ┌───────────┬─────────────────┐
    │ Untracked │                 │
    └───────────┘              ┌──▼───┐       ┌────────┐
                               │Staged├───────►Commited│
┌─────────────────────┐        └──▲───┘       └────────┘
│ Tracked but changed │           │
└─────────────────────┴───────────┘
```

Right now, all of the files are in the first two states, either `Untracked` or `Tracked but changed`. Even `delete-me` doesn't actually exist in the directory anymore in a physical sense, but it is in the `Tracked but changed` state as having been deleted.

How can we move things to the `Staged` state? As the output of `git status` suggests, we can use the `git add` command to add files and changes to the `index` (aka "stage" them).

```sh
# Add the business-agenda file to the index,
# which is actually only adding the _changes_
# in that file to the index. The file itself
# already existed in the working directory and
# was known to `git` before we got started.
# Next, print `git status` to show what has changed.
git add commit-practice/business-agenda && git status
```

Output:

```
On branch main
Your branch is up to date with 'origin/main'.

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        modified:   commit-practice/business-agenda

Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        deleted:    commit-practice/delete-me

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        commit-practice/added-file
```

This is looking quite similar, but we can see that there is now a "`Changes to be committed:`" section. It contains the file we just added with `git add`, as well as the following interesting tidbit:

```
(use "git restore --staged <file>..." to unstage)
```

Cool! So we can remove files from our `index` (aka staging area) that we accidentally added, or changed our minds about.

## Interesting! Can we add the rest of the files or...?

Yes, yes, fine. You can quickly add all of the files that have changed in the working directory, **RELATIVE TO YOUR CURRENT PATH**, with the following super popular sequence of characters:

```sh
# Mind the dot
git add .
```

This will add all of the files in the current directory, as well as all of the files in the directories that are children of the current directory, recursively. Use this with care! You can accidentally add things to your index that you don't mean to!

Now, what is `git status` telling us?

```sh
git status
```

Output:

```
On branch main
Your branch is up to date with 'origin/main'.

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        new file:   commit-practice/added-file
        modified:   commit-practice/business-agenda
        deleted:    commit-practice/delete-me
```

Okay! It looks like all of our files are now in our `index`. Looking again at our diagram from earlier, all of our files are now in the `Staged` stage.

```
    ┌───────────┬─────────────────┐
    │ Untracked │                 │
    └───────────┘              ┌──▼───┐       ┌────────┐
                               │Staged├───────►Commited│
┌─────────────────────┐        └──▲───┘       └────────┘
│ Tracked but changed │           │
└─────────────────────┴───────────┘
```

This is great, we can make a `commit` now!

## Hot dog! Let's make a commit!

When you make a `commit`, you are always going to be committing whatever is under `Changes to be committed` when you use `git status`. For this reason, you should **ALWAYS** use `git status` to see what you are committing before you actually make a commit.

Making a `commit` is just as easy as using `git commit`. Really!*

\* Not really. Please read ahead if you don't want to get stuck in `vim`.

```sh
# Buckle up...
git commit
```

When you create a `commit`, you add a message to it that is descriptive of what the `commits` context and/or contents are. The default behavior for doing that is what I would term a character-building experience if you are new to Linux or CLI tools. Now, your terminal is most likely looking at something called `vim`. For me, it looks like this:

```
<- The cursor is here
# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
#
# On branch main
# Your branch is up to date with 'origin/main'.
#
# Changes to be committed:
#       new file:   commit-practice/added-file
#       modified:   commit-practice/business-agenda
#       deleted:    commit-practice/delete-me
#
```

[`vim`](3) is a(n) (in)famous text editor that your default `git` experience will use when you make a `commit`. I encourage you to do any one of the following:

- Get familiar enough with `vim` that you don't get overwhelmed with what you're doing in here. This will involve understanding how to navigate, switching into and out of normal, insert, and visual select mode, and how to force-quit and save-and-quit. It doesn't really take that long, maybe an hour or so to get familiar with the very basic stuff so that you can at least write a commit message. The [`vimtutor`](4) is a great way to get this familiarity.
- Do not use `vim` when you create a commit message - [change your `git` default editor to something else](5), like `nano`.
- Try to make commits small enough that you don't need to write long messages, and try using the `-m` flag when you write your commits. e.g. `git commit -m "My short commit message."`

Now, for better or for worse, I have led you into the dark world of `vim`. Use the following instructions to pull yourself out:

1. Press the `i` key to enter Insert mode.
1. Type: "My first commit".
1. Press the `ESC` key (or use `CTRL+C`) to enter Normal mode.
1. Press `:wq` and then `Enter` to save-and-quit. You should see the `:wq` appear in the bottom left of your screen if you are in Normal mode.

Congratulations! You have made your first commit!

You can now use `git show` to see the content of your latest `commit`. As with `git log`, you use the `j` and `k` keys to move up and down, and `q` when you're done looking:

```sh
git show
```

You are doing great! Keep going to look at the next lesson! When you're ready, check out the next lesson of this tutorial, which can be found here: [LESSON 2](/lessons/2/LESSON.md)!

## What did we learn?

- A `commit` is a snapshot of a repository at a single point in time. It is the combination of changes that occurred since the previous `commit`.
- An `index` is where files go when they get "staged", or ready to `commit`.
- You can use `git status` to get an overview of the state of your repository, with regard to the working directory and the `index`.
- You can be selective about which files you would like to add to your index by using `git add`.
- Using `git commit` will allow you create a snapshot of your repository using the files that you have added to your `index`. A `commit` requires a message, and by default you add this `commit` message in ~~the shadow realm~~ `vim`, but this experience is configurable.

[0]: https://backtothefuture.fandom.com/wiki/Biff_Tannen
[1]: https://tvtropes.org/pmwiki/pmwiki.php/Main/CompoundInterestTimeTravelGambit
[2]: https://blog.thoughtram.io/git/2014/11/18/the-anatomy-of-a-git-commit.html
[3]: https://www.vim.org/
[4]: https://www.systutorials.com/vim-tutorial-beginners-vimtutor/
[5]: https://dev.to/biancapower/how-to-change-your-default-text-editor-for-git-and-avoid-vim-fk0