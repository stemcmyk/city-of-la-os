# City Of LA Server Files

## Requirements

### Subscriptions

- Wasabi Ambulance (Required)
- Wasabi Police (Required)
- Wasabi Carlock (Not Required)
- Wasabi Bridge (Required)
- [Cosmo Driveby](https://forum.cfx.re/t/paid-enhanced-driveby-animations-v1-1-custom-clipsets-2-0-teaser-out-now/4880157) (Not Required)
- [K4MB1 Casino](https://www.k4mb1maps.com/product/5325085) (Required for casino)

## Setup

This is a guide for Windows any other system you gotta figure out yourself

1. Download the latest server build files using `https://runtime.fivem.net/artifacts/fivem/build_server_windows/master/`
2. Un-zip it and you should have a folder containing a FXServer.exe
3. In this folder create another folder called "servers" and open it
4. Install Git LFS [git-lfs](https://git-lfs.com/) (Used for for the larger files)
5. Clone this repository in that folder
   You can do this by running `git clone https://github.com/city-of-la/city-of-la-server-files.git` if you have [git](https://git-scm.com/) installed
6. Run the ./start.bat file in the folder that was cloned
7. This should start the server, it might not work without config tho.

## Post-Setup

1. Go into stem_discord and modify the server.js file to configure it to your discord server
2. Edit the webhooks in webhooks.cfg
3. Remove any instances of previous admins or staff members
4. Run `city-of-la.sql` then run `city-of-la-data.sql` in your MySQL database.
