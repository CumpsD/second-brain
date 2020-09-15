# Remote Port forward

## On the Server you want to reach

```bash
ssh -R 1337:server.internal-network.be:1433 \
    root@bastion
```

## On the Client you want to connect with

```powershell
PS C:\Users\david> cmdkey /add:"server.internal-network.be:1337" /user:"WINDOWS\xxxxxx" /pass:"xxxxxxx"
```

Connect to: `server.internal-network.be,1337`
