{
  delta = {
    enable = true;
    options = { side-by-side = true; };
  };
  lfs.enable = true;
  userName = "alexandre-charlot_qonto";
  userEmail = "alexandre.charlot@qonto.com";
  extraConfig = {
    url."git@github.com:".insteadOf = "https://github.com/";
    core = {
      ignoreCase = false;
      editor = "vim";
    };
    push = { autoSetupRemote = true; };
    pull = { rebase = true; };
    gpg.format = "ssh";
    user.signingKey = "~/.ssh/id_ed25519.pub"; # chemin vers la clé publique
    commit.gpgSign = true;
    color = {
      ui = "auto";
      branch = {
        current = "yellow reverse";
        local = "yellow";
        remote = "green";
      };
    };
  };
  aliases = {
    push = "push.default current";
    st = "status";
    ci = "commit";
    co = "checkout";
    br = "branch";
    bra = ''
      !sh -c "git branch --sort=-committerdate | fzf --layout=reverse | xargs -I{} git switch '{}'"'';
    di = "diff";
    sdi = "diff --cached";
    dis = "diff --ignore-all-space";
    logg = "log --decorate --graph";
    lg =
      "log --graph --pretty=tformat:'%Cred%h%Creset -%C(yellow)%d%Creset%s %Cgreen(%an %cr)%Creset' --abbrev-commit --date=relative";
    lga = ''!sh -c 'git log --author="$1" -p $2' -'';
    lol = "log --graph --decorate --pretty=oneline --abbrev-commit";
    lola = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
    lint =
      "!sh -c 'git status | awk \"/modified/ {print \\$3}\" | xargs -L 1 php -l'";
    logfull = "log --pretty=fuller --graph --stat -p";
    cat = "cat-file -p";
    unstage = "reset HEAD";
    uncommit = "update-ref HEAD HEAD^";
    uncommithard = "reset --hard HEAD^";
    undomerge = "reset --hard ORIG_HEAD";
    oups = "commit -a --amend -C HEAD";
  };
}
