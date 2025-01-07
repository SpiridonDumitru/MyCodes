	# SETUP GIT
	# setup git: use PAT

1. Make sure you have Personal Access Token for git authentication - PAT
{{{    Log in to GitHub:
        Go to GitHub and log in to your account.

    Access Settings:
        Click on your profile picture in the upper right corner.
        Select Settings from the dropdown menu.

    Navigate to Developer Settings:
        In the left sidebar, scroll down and click on Developer settings.

    Personal Access Tokens:
        Click on Personal access tokens in the left sidebar.
        Then click on Tokens (classic).

    Generate New Token:
        Click on the Generate new token button.

    Configure Token Settings:
        Note: You may need to confirm your password.
        Give your token a descriptive name in the Note field.
        Set an expiration for the token (e.g., 30 days, 60 days, etc.).
        Select the scopes or permissions you want to grant this token. For example:
            repo for full control of private repositories.
            workflow for updating GitHub Actions workflows.
            admin:org for managing organization settings.

    Generate Token:
        Click the Generate token button at the bottom of the page.

    Copy Your Token:
        Important: Copy the generated token immediately and store it securely. You won’t be able to see it again.
}}}
2. git remote -v
3. remote ULR setup to HTTPS: git remote set-url origin https://github.com/username/repository.git
4. Now you can use PAT instead of password.
---
1. git add .
2. git commit -m "update for today"
3. git push
4. git status

	# setup git: use SSH
01. Setup Git Credential Manager: git config --global credential.helper manager-core
02. generate SSH key pair: ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
03. eval "$(ssh-agent -s)"
04. ssh-add ~/.ssh/id_rsa
05. copy key: cat ~/.ssh/id_rsa.pub
06. go to: https://github.com/settings/keys
07. paste your public key  + give it a title
08. check current remote url: git remote -v
09. change git to use SSH instead of HTTPS: git remote set-url origin git@github.com:username/repository.git
10. test your ssh conection: ssh -T git@github.com
11. everything is correct if: Hi username! You've successfully authenticated, but GitHub does not provide shell access.
---
1. git add .
2. git commit -m "update for today"
3. git push origin main
4. git status
