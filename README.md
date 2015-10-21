# Installation

```bash
gem install tor257
```

# Usage

```bash
$>  tor257 --help
Usage: tor257 -p=keyphrase | -f=keyfile [-b=fd] [-v]
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
$>  cat bin/tor257 | tor257 -p aaaa -bout
hYcvdePiL2JgZy9lv6cgctPEeQqzsGNvbWBuZ+vxdXTAizgKmuJlcXxgcmXx
9m9w0tZhcuP1JwoDZG9kpL1lIOfUZ3X99W50AwMgIJGRb3DShj0g/vlsCikp
ZGW38XNlysAucPHic2UDKSAg8ZFAb9bSIHzsrSBPeX1pb7+BYXLVw3Iu/vV3
IG1mIHy+oXRz2qwgILCwICBmeXRz/7NhbsjDciCtsCJVemhnZevxdG/UlDU3
sL1wPWJseXC5o2Fzw4Z8IL32PWtscGZpvbQgW4vEPWb0zSBbJH9dItvbICCG
hiAg/+B0cydmbijz/C12w9Rib+P1IiwpK01vo7QgdsPUYm/j9SIpKW1vCvHx
ICCGhiAgtOZlcmtmc2Xx7CB01NNlCrCwICApKWVutdsKIIaGICCw/3B0eidv
bvnzLS3Cw2J197IsICtNZXa0vW9w1sNyIP3/ZGUpIW9u8YJUROP0UimyuSBk
ZgMgIPHxICCGhiRk9fJ1Zyk0IHSjpGUKhoYgILCwZW5tAwog8fEgIIbJcHTj
vm9uISstLaGwc3PWznJh4/U9cGh6cyL98SJLw98gKMDxc3N5YXJhorQpIo+G
ZG+w7GtlcHUKIPHxICCGhiAk+/V5IDQpa2Wo2yAghoYgIPX+ZAoDKSAg8fEg
b9bScy7//igiJCRmab20PWvD32Zp/PUiLCkrS2Wo8ShGz8plKbK5IGRmKXxr
tKh8CoaGICCwsCAge2hpc7TxIkbPymUgs+trZXB0IGS+tHMnyNIgZej5c3R6
KSEi8aRubMPVcyDW+WxlJ2x4aaKlcz+GzWV5mrAgICkpICDx9Wtl34Y9INb5
bGUne2VhtflrZd+PCiCwsCAgKSkgcrC4c2WGhEZp/PUgI3JiZXms8WlzhsNt
cOTpICErKWlm8fVrZd+IZW3g5Hk/AykgIPHxIGXIwgoKsLAgICkpb3Cloi5v
yI4iLb3yYXNsPzQ9t7UiLIaET3Xk4HV0KWBuIJCCQ0nvhkJh4/U2NCsgIGS+
8XxmwtoKILCwICApKSAkt7g2NIbafD2wuGZkKTQ9IPO4biKPrCAgsLAgICkp
JGa+5zQg2to9ILj2ZCA0NCAivqR0Io+sICCwsCAgKSlyZaCkaXLDhidi8eNl
Nj0uCiDx8SAghsNuZJqaICApKWVutf9wYdTVZSGamiAgKSlyYbiiZSDn1Gd1
/fVudEx7cm+j/SAi7cN5IPnjIHJseHVpo7RkIobTbmz143MgLWJledvxICCG
1GV05eJuIElJb3Cl2woghsNuZJqaZW5tAwpitLZpbqyGIEHi93VtbGd0LqGw
cnPDrAogsPlmIC1tZWKktiAjhtJvIPz/YWQpZW9jsL0gZcjQCiCwsCBsZmhk
IJW4ci7W0WQgu7AnL2VgYi+lvnIyk5EucvK3CiApbGxztNsgIIaGcmXh5Wly
bCkndL6jMjWRgQogsPVuZAMDICC4v2Ns08JlIMT/cjI8PgoK8fF0csfWKCLD
2UdJR10iKfG1bwqGhiAg9ehpdCk5CiDxtG5krKwgIPv1eSA0KUtlqP9uZdGO
JGv16SkKKSlpIOzxMAqGhmxv/+AgZGYDICDx8XN01IY9IMPERElHJ3JlsLUg
NJafNgqwsCAgYG8gc6WjLm7Pyj8KsLAgICkpZXi4pSAwrIYgILD1bmQDKSAg
8aJ0coabICT2+TY0KTYgQrCiZTaSiGRl8/9kZT89KHOloykgnIZzdOKaICAp
KVNUlZRSUojWdXTjsCJCZWZjIPLye2nbhlsj6+N0cnRUIHe4pWgg/YV7a/Xp
fV0rKWlm8fV2ZdTEb3P1miAgKSkjIIKFREX09C5w5eRzICtVIiOqonRy2/oi
IpqwICApZCA98Zxlc9XHZ2W+/mV3KXp0ctvxICCGyXV0sK0gbSdsbmOjqHB0
js1lebmaICApKVNUlZ5VVIjRcmnk9SAkb2Y2NPHuIELH1WU2pL5lbmpmZGXn
5Shv09IpIKqwb3V9AyAg8fFpII2bIDGasCBlZ20KcrSiY3XDhj0+sPVycgMp
IFOFlUVS9IhwdeTjICJMe3Jvo+sgI93DcnK+/WVzemhnZazzCiCG9VRE1cJS
Lnl8dHPxtHJyiMRhY/vkcmFqbC5qvrhuKIT6biK5sGlmKS12ZaOzb3PDrGVu
9Jo=
```
