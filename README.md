# Usage

```text
Usage: 302poignees -p=keyphrase | -f=keyfile [-b=fd] [-v]
        --verbose                    Developper mode (on STDERR)
        --passphrase=pass            Key (Passphrase)
        --file=keyfile               Key (File)
        --base64=fd                  Output in ASCII Base64
```

Example:
```bash
$>  echo "bonjour" | ./tor257 -p "ohk" -bout
BBeADBebFA==
$>  echo "bonjour" | ./tor257 -p "ohk" -bout | ./tor257 -p "ohk" -bin
bonjour
```
