# Usage

```text
Usage: 302poignees -k=key [-b=fd]
        --key=pass                   Key (Passphrase)
        --base64=fd                  Output in ASCII Base64
```

Example:
```bash
$>  echo "bonjour" | ./tor257 -k "ohk" -bout
BBeADBebFA==
$>  echo "bonjour" | ./tor257 -k "ohk" -bout | ./tor257 -k "ohk" -bin
bonjour
```
