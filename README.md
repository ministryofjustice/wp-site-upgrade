# WordPress Site Upgrade Utility
Execute `site-upgrade .` from any site directory (requires `wp-mac-bootstrap` directory formation) - the command currently requires one argument; the path to the root directory of a bedrock website.

You can find a helper script in this package called `run.sh`. If you execute this script it will cycle through your `sites` directory picking up websites that have a docker-compose.yml file inside. 

## Installation

1. Add this GitHub repository as a package source for your global composer install:
   
   ```bash
   composer global config repositories.repo-name vcs https://github.com/ministryofjustice/wp-site-upgrade
   ```
2. Install `site-upgrade` from the `master` branch:
   
   ```bash
   composer global require ministryofjustice/wp-site-upgrade:dev-master
   ```

3. You should now be able to run `site-upgrade` from any sites/directory.

**Note:** If you see an error `site-upgrade: command not found`, it'll likely be because you don't have the composer bin directory in your PATH. Refer to the [composer requirements](#composer) section of this document.

## Requirements
Please ensure the directory structure matches the layout detailed in `wp-mac-bootstrap`

### Composer

Composer should be accessible globally with the command `composer`.

Composer's global bin directory `~/.composer/vendor/bin/` should be added to your PATH so that binaries provided by installed packages can be run from your terminal. [Instructions available here.](https://akrabat.com/global-installation-of-php-tools-with-composer/)
