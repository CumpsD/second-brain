# Update all repositories

Using the following Fish function:

```bash
# Defined in /home/cumpsd/.config/fish/functions/forrepos.fish @ line 1
function forrepos --description 'Evaluates $argv for all repo folders'
    for d in (find ~/repos/ -mindepth 2 -maxdepth 2 ! -path . -type d)
        pushd $d
        set repo (basename $d)
        echo $repo
        eval (abbrex $argv)
        popd > /dev/null
    end
end
```

First fetch all repositores, and then fast forward where possible.

```bash
forrepos git fetch --all
forrepos git pull --ff-only
```
