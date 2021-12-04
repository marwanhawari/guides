# Git guide

## Setup:
1. Go to the working directory and execute `git init` to initialize a repository in the working directory.
2. Go to github.com and create a new blank repo (no LICENSE or README).
3. Copy the repo url from GitHub and execute `git remote add origin <repo_url>`. "origin" is the alias for the URL for the remote repo you are setting up. If you cloned the repo from a URL, "origin" is just an alias for the URL from which you cloned the repo.
4. Execute `git config --global user.email <email>`
5. Execute `git config --global user.name <username>`

## Commits:
1. Use `git status` to track status of files in local repo, and use `git log` to track commits.
2. Create a `README.md` file.
3. Execute `git add <file>` for every file you want to move the staging area.
    * To remove file from staging area, execute `git rm --cached <file>`
4. Use `git commit -m "<description>"` to commit everything in the staging area to the local repository (-m is the commit message).
5. To push local repo to remote repo (like GitHub), execute `git branch -M main`, followed by `git push -u origin main`.
    * If you run the command: `git push --set-upstream origin main` then you only need to type `git push` from now on.

## Pull requests:
1. Fork the source repo into your personal account from the main branch of the repository.
1. Clone your forked repo onto your system.
1. Create a new branch and switch to that branch. It's good practice to only have one pull request per branch.
   * `git branch <new_branch_name>`
   * `git switch <new_branch_name>`
   * OR: just use `git checkout -b <new_branch_name>` to both create and switch to the branch in one command.
1. Make changes to the code on that branch.
1. Push up to GitHub (or whatever remote repository it came from - aka "origin")
   * `git push origin <new_branch_name>`
1. Go back to the original repo and make a pull request to merge your branch with original repo.
1. If approved, this will merge your repo with the main branch of the original repo.

## Tags:
2 ways to do this:
* First method:
1. Commit your source code and push to a remote repo (just do a `git push`).
2. THEN create a tag on that last commit (this will just be on your local repo): `git tag <tag-name>`
3. Push that tag (not the source code) to the remote repo:
   * Use `git push origin <tag-name>` to push a specific tag (RECOMMENDED)
   * Use `git push --tags` to push all tags from local repo to remote repo

* Second method:
1. Commit your source code on local repo (don't push to remote repo yet).
2. Create a tag for that commit: `git tag <tag-name>`
3. Now push the commit and that tag at the same time: `git push origin main tag <tag-name>`

Notes on tags:
1. Can list tags using `git tag --list`
1. Usually you want to do versioning tags. For example: `git tag v0.1.0`
1. Delete local repo tag using: `git tag -d <tag-name>`
1. Delete remote repo tag using: `git push --delete origin <tag-name>`

List your local tags: `git tag` or `git show-ref --tags` to show tags with their SHA

List your remote tags: `git ls-remote --tags`


## Rebase vs. Merge:
1. The main difference is in the topology of the git history:
   * `merge` will create a branched git history and extra "merge commits".
   * `rebase` will allow you to have a linear git history.
3. Generally you should `merge` to the main branch and `rebase` the feature branches

<p align="center">
  <img src="https://github.com/marwanhawari/guides/blob/main/images/git-merge-vs-rebase.png" alt="git-merge-vs-rebase" width="300"/>
</p>
source: https://levelup.gitconnected.com/the-difference-between-git-merge-and-git-rebase-8f7d1b159931
<br></br>

Using `merge` manually (as opposed to merging through a GitHub pull request)
```
# switch to main branch
git checkout main
# make sure main branch is up to day
git pull main
# merge the feature branch into the main branch
git merge feature
```
This will create an extra "merge commit" and your git history will be branching.
*Note: if a fast-forward merge is possible, then `merge` will maintain linear history unless the the `git merge --no-ff` option is used. A fast-forward is possible if no new commits were made on the main branch since you branched off of it with your feature branch.*

<p align="center">
  <img src="https://github.com/marwanhawari/guides/blob/main/images/git-merge-no-ff.png" alt="git-merge-no-ff" width="300"/>
</p>
source: https://stackoverflow.com/questions/9069061/what-is-the-difference-between-git-merge-and-git-merge-no-ff
<br></br>

Using `rebase`
```
# switch to main branch
git checkout main
# make sure main branch is up to day
git pull main
# switch back to your feature branch
git checkout feature
# rebase feature branch on top of main branch
git rebase main
```
This will create a linear git history.
<br></br>

After the rebase, you have 2 options:
1. Push your feature branch to GitHub and open a pull request on GitHub
```
git push origin feature
```

3. If you're working on your own project, merge the feature branch back into the master and push it to GitHub.
```
# switch back to main branch
git checkout main
# merge the feature branch into the main branch
git merge feature
# push back to GitHub
git push origin main
```

## Git pull options:
*This only really applies if you are collaborating with others on a single branch*, otherwise create a feature branch off of the main branch and make a pull request.
<br></br>
3 pull strategies:
1. merge (default): `git config pull.rebase false` OR `git pull --no-rebase`
   * Use this when pulling `main` branch.
   * If more than 1 person is working on a feature branch, then this can be dangerous because it can create a new "merge commit" with a new sha that might mess things up in the remote repo.
3. rebase: `git config pull.rebase true` OR `git pull --rebase`
   * Use this when pulling on a feature branch that more than 1 person is working on. It will fetch the commits that your teammate pushed and then rebase your commits (that you haven't yet pushed) on top. This is better than the `merge` default behavior because it won't add the "merge" commit and will keep the git history of the feature branch linear.
   * This is safer because it first brings your local repo up to speed with the remote repo then adds whatever work you've done on top of it. Rebase will rewrite the commit history (of your new commits), thus the shas of the new commits will be different even if the code is the same. 
5. fast-forward only: `git config pull.ff only` OR `git pull --ff-only`
   * This is the safest, but not practical when working on a team. It only allows you to pull if you haven't made any new local commits.

## Git push
* To create a new branch in a _remote_ repository: `git push --set-upstream origin <new-remote-branch-name>`
  * The `--set-upstream` option makes it so that any future `git pull` (only for the currently checkouted local branch, not all local branches) will pull from the <new-remote-branch-name> branch in the remote repository instead of the default.

## Extra:
* To remove a file from Git repository (and GitHub) but NOT local filesystem (working directory), then use: `git rm file1.txt`
* To remove a file from Git repository (and GitHub) AND local filesystem (working directory), then use: `git rm --cached file1.txt`
* `git clone` is how you get local copy of existing remote repo to work on. Usually only used once.
* `git pull` (which is essentially a `git fetch` + `git merge`) is how you update local repo with new commits from remote repo (likely due to commits from collaborators). Fetch doesn’t change any local files because it doesn’t merge changes with current branch.
* `git pull --rebase` is essentially a `git fetch` + `git rebase`.
* If you try to upload a file that is too large (>100 MB), then remove it and still have issues, then run the following command to remove the history of that file: `git filter-branch --index-filter 'git rm -r --cached --ignore-unmatch <file/dir>' HEAD`
* To clone a repo as a different name, execute: `git clone <repo_url> <path/new_name>`
* To log out of your git account:
  * `git config --global --unset user.name`
  * `git config --global --unset user.email`
  * `git config --global --unset credential.helper`
* Listing files:
  * Use `git diff --name-only --cached` to list files in the staging area
  * Use `git ls-tree --full-tree -r --name-only HEAD` to view already commited files in your local repo
  * Use `git ls-files` to list all files in your local repo including those that are staged but not yet commited.
* Undo your last commit:
  * Use `git reset HEAD~1` to undo the last commit in your local repo BUT keep the actual changes you made to your file. You will need to add the modified files back to the staging area (using `git add`)
  * Use `git reset --hard HEAD~1` to undo the last commit in your local repo AND undo all changes made to your files.
  * Use `git reset --soft HEAD~1` to undo the last commint in your local repo BUT keep the actual changes you made to your file. The modified files are moved back into the staging area and are already ready to be commited again.
  * Download repo without the .git files: `wget https://github.com/[user]/[repo]/archive/[branch].zip`
* Update repo to accept your GitHub personal access token: `git remote set-url origin https://<username>:<token>@github.com/<username>/<repository>.git`
* Make a commit for yesterday: `git commit --date="1 day ago" -m "Your commit message"`.
* The `git checkout <branch>` command does the same thing as `git switch <branch>` command.
* Delete a local branch: `git branch -d <branch>`
* Delete a remote branch: `git push origin --delete <branch>`
* Rename current branch: `git branch -m <new-branch-name>`
* Copy a file FROM one branch <from-branch> TO a new branch <to-branch>
   * First switch to the "destination" branch (that is, switch to the branch where you want the file/file changes to end up): `git checkout <to-branch>`
   * Then run: `git checkout <from-branch> path/to/file`
* Remove untracked files with: `git clean -df -n`. `-d` includes directores, `-f` forces, and `-n` is a dry-run (doesn't actually remove anything). Remove `-n` to actually remove untracked files.
* Use `git log --pretty=oneline` to print log on one line.

## GitHub OSS search terms:
* is:open is:issue language:python label:"good first issue" 

## GitHub issues should tell:
1. What you’re trying to do
2. What you’ve done
3. What you expect to see
4. What actually happened
