### Repo Settings
- You need to keep this repo as public to use github pages
- For private repo you have to buy subscription 

### Installation
- Install Ruby 
  - [Ruby Installer](https://rubyinstaller.org/downloads/)
  - install Ruby + Devkit x64
  - Go with all default settings for installation
  - on Finish page it will move to next phase which is msys2 installtion
  - here in command prompt you have to install each item one by one
  - so press 1 to install first item
  - after that is done press 2 to install second item
  - same goes for item 3
  - after all 3 done, close console
- Reopen command prompt to install jekyll
  - `gem install jekyll` to install jekyll
  - `jekyll -v` to check jekyll version after installation is done
  - `gem install bundler` to install bundler
  - `bundler -v` to check bundler version after installation is done

### Build first working version
- use cmd/visual studio to move to your working folder/repo
- `jekyll new website` command will create new website folder at your active folder location
- here website is name your folder, you can name it whatever you like but for repo i am going to keep website as default
- jekyll will also generate all necessary setup files which require to generate new website to this folder
- This process might take few mins to wait until it's running
- now to build your first website set this website folder as your active directory using command prompt
- `bundle exec jekyll server`  to build new website, here we are using bundle exec only for first time
- `jekyll build` Builds the site and outputs a static site to a directory called _site.
- `jekyll serve` Does jekyll build and runs it on a local web server at http://localhost:4000, rebuilding the site any time you make a change.
- `bundle install` to install new gem, for new theme or plugins

### GitHub Repo Setup
- So basically there's 3 main folder
  - Docs 
    - Contain all Documents related to site setup / development / content
  - Setup
    - Contain Jekyll setup to build/test new site
  - Website
    - Contain generated site which is approved by developer

### Resources
- [Jekyll Installation for windows](https://jekyllrb.com/docs/installation/windows/)
- [How to install Jekyll for windows](https://www.youtube.com/watch?v=semqYpqoY_k)
- [Jekyll Detailed Tutorial Playlist](https://www.youtube.com/watch?v=T1itpPvFWHI&list=PLLAZ4kZ9dFpOPV5C5Ay0pHaa0RJFhcmcB)
