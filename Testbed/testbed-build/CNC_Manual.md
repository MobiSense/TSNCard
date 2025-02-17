# CNC Script Usage Guide
## 1. Before running the script, configure the following variables in batch.mjs:

```javascript
// IP address format: 192.168.137.*
// Test data
const conf_default = "<configuration name to execute>"
// Clock master node
const master = 40

const hosts = {
 device: [43, 44],
 switch: [40, 41],
}
```

Install the necessary dependencies:
```bash
sudo npm install -g zx@4.3.0
pip install -r requirements.txt
npm install
```

Configure the environment variables, add the following in .bashrc:

```bash
export PYTHONPATH="/home/<username>/scripts"
```

## 2. Download the software code for Switch and TSNPerf

> (Remember to configure the ssh public key between the Raspberry Pi and all boards in advance to facilitate password-free login)

```bash
./batch.mjs clone
```

## 3. Pull the latest software code and sync it to remote boards

> The default branch is master, if a specific branch is needed, modify the pull() function in the batch.mjs file, refer to the commented part for details

```javascript
// pull all the latest code
const pull = async () => {
cd(`${os.homedir()}/repos`)
// If you need to specify a branch, similar to the operation of specifying the qbv-test branch below
// await $`cd pkt_gen_app; git stash; git checkout qbv-test; git pull origin qbv-test; cd ..`
// await $`cd time_sync_app; git stash; git checkout qbv-test; git pull origin qbv-test; cd ..`

await Promise.all(hosts.all.map(host => {
   const type = hosts.device.includes(host) ? 'device' : 'switch'

   if (type === 'device') {
       return $`rsync -avPh ${os.homedir}/repos/pkt_gen_app root@192.168.137.${host}:~/`
   } else if (type === 'switch') {
       return $`rsync -avPh ${os.homedir}/repos/time_sync_app root@192.168.137.${host}:~/;`
   }
}))
}
```

Sync to all boards:

```bash
./batch.mjs pull
```

## 4. Make all remote boards compile the code

```bash
./batch.mjs build
```

## 5. Distribute the configuration files to all boards

```bash
./batch.mjs distribute
```

## 6. Start launching the programs on all boards

```bash
./batch.mjs launch
```

## 7. Collect statistics on latency and jitter

```bash
./batch.mjs collect
```