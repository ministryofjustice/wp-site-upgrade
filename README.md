# Site Updates Management Utility ***(SUMU)***

![logo](https://github.com/ministryofjustice/wp-site-upgrade/raw/master/sumu-small.png) 

This utility provides a collection of bash scripts that can be used for a variety of task such as; applying software updates to website dependencies located in a bedrock structured website. It also contains helper commands to assist in your local development.

In order to execute the utility correctly please make sure the structure of your local site’s directory follows the [Mac Bootstrap](https://github.com/ministryofjustice/wp-mac-bootstrap) configuration.

## Installation

Use this quick access, chained command to get your system ready to use the utility:
```bash
cd ~/.composer && composer global config repositories.sumu vcs https://github.com/ministryofjustice/wp-sumu && composer global require ministryofjustice/wp-sumu:dev-master
```

#### A deeper look at the installation:

1. Add the GitHub repository as a package source for your global composer install:
   
   ```bash
   composer global config repositories.sumu vcs https://github.com/ministryofjustice/wp-sumu
   ```
2. Install `site-upgrade` and `site-upgrade-run` from the `master` branch:
   
   ```bash
   composer global require ministryofjustice/wp-sumu:dev-master
   ```
   
3. You may need to update composer if this wasn't automatically executed:

   ```bash
   cd ~/.composer && composer update
   ```

3. To verify installation run `site-upgrade-run`. If all is well you'll be asked to update a website. 

**Note:** If you see an error `site-upgrade-run: command not found`, it'll likely be because you don't have the composer bin directory in your PATH. Refer to the [composer requirements](#composer) section of this document.

## Commands

#### `site-upgrade`
- Run this command from anywhere
- It requires one argument; the path to the sites' directory
  - Pass `.` (dot) from within the directory itself
  - `all` is an alias, use this from anywhere to invoke `site-upgrade-run`
- Generally used to upgrade a single site

There are 5 steps in the upgrade process:

1. Handling composer packages
2. Handling node dependencies
3. Launching Docker for review
4. Submitting pull requests via GitHub
5. Cleanup; always occurs, even if there is an error

Each step provides just enough output to ensure successful updates.

Execute `site-upgrade .` from a site directory (requires `wp-mac-bootstrap` directory formation) - the command currently requires one argument which is the path to the root directory of a website.

You can find a bulk command in this package named `site-upgrade-run` (details below). 


#### `site-upgrade-run`
- Run this command from anywhere on your computer
- Takes zero arguments
- Great for updating all sites

Looks in the `~/sites` directory and traverses through each sub-directory looking for `composer.json` and `package.json` files. It effectively executes `site-upgrade *directory-path*` on each validated sub-directory found.

---

## Helpers

#### `site-image-regen`
Useful while developing a base image such as:

- https://github.com/ministryofjustice/wp-multisite-base-docker
- https://github.com/ministryofjustice/wordpress-base-docker

This command will re-build a base image associated with a website. It will do it locally using `docker build` and then re-build the site.

- Run this command from the root of a website - not the base-docker image itself
- Takes zero arguments
- Automated base repo detection built in

#### Please watch out for...
The auto detect feature of `site-image-regen` expects uniquely named base repositories on your system. If you have the same repo (by name) located in different directories the command may fail. For instance, consider these 2 *hypothetical* directory locations for `wordpress-base-docker`.

- `~/utils/wordpress-base-docker`
- `~/utils-dev/wordpress-base-docker`

This example will produce a failure causing the command to exit.

**Could we mitigate this issue?**

Making an exception for this type of issue was not possible at the time of writing because we cannot determine if the first or second result is the repo we need to rebuild.

A possible solution is to feedback multiple results in the UI and ask the user to confirm which one. Of course, another solution is to make sure we have one source of truth on our systems.  


## Requirements
Please ensure the directory structure matches the default layout detailed in `wp-mac-bootstrap`

With process automation comes a level of software dependancy. This script requires the following software to operate:

- npm-update (auto install at runtime available)
- Docker
- Dory proxy : `gem install dory`
- Git version&nbsp;&nbsp; `>=` &nbsp;&nbsp;2.22.0 :  `git --version` 

### Composer

Composer should be accessible globally with the command `composer`.

Composer's global bin directory `~/.composer/vendor/bin/` should be added to your PATH so that binaries provided by installed packages can be run from your terminal. [Instructions available here.](https://akrabat.com/global-installation-of-php-tools-with-composer/)

### Caveats 
There has been a permission issue encountered using `site-upgrade` when updating node dependencies. This is related to the `node_modules` directory and the user it was created under.

This is fixable by modifying permissions on the directory using `chmod` or, removing the directory completely and allowing the utility to rebuild it.