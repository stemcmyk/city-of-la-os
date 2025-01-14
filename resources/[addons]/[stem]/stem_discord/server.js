/// Code ///
var cache = {};
const axios = require("axios").default;
const ms = require("ms");

const { blacklistMessage, blacklistRoles, botToken, cacheMaxTime, debugMode, enableWhitelist, guildId, noGuildMessage, notWhitelistedMessage, whitelistRoles } = {
  enableWhitelist: true, // Enable the Whitelist/Allowlist
  guildId: "1234", // Guild ID for a Discord Server
  botToken:
    "1234", // This must be a Discord bot token, create a bot @ https://discord.com/developers/applications

  whitelistRoles: [
    // Roles by ID that are whitelisted.
    "1234",
  ],

  blacklistRoles: [],

  notWhitelistedMessage: "You need to be verified in our discord to join: https://discord.gg/cityofla.",
  noGuildMessage: "Guild Not Detected. It seems you're not in the guild for this community. https://discord.gg/cityofla",
  blacklistMessage: "You're blacklisted from this server.",
  debugMode: false,
  cacheMaxTime: "12h",
}

var work = true;
axios.defaults.baseURL = "https://discord.com/api/v9";
axios.defaults.headers = {};
const version = "4.0";

const setWork = (boolean) => work = boolean
const getWork = () => work

const getUserDiscord = async function (source, callback) {
  if (typeof source == "string") return source;
  if (!GetPlayerName(source)) return false;
  let arr = [];
  for (let index = 0; index <= GetNumPlayerIdentifiers(source); index++) {
    if (GetPlayerIdentifier(source, index)) {
      arr.push(GetPlayerIdentifier(source, index));
    }
  }
  setTimeout(() => {
    const found = arr.find((e) => e.startsWith("discord:"));
    if (found) {
      callback(found.replace("discord:", ""));
    } else {
      callback(null);
    }
  }, 500);
};

exports("getUserDiscord", getUserDiscord)


setTimeout(async () => {
  let botAccount = await axios({
    method: "GET",
    url: `https://discord.com/api/v9/users/@me`,
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bot ${botToken}`,
    },
  }).catch(async (err) => {
    console.log(
      `[${version}] ^5Bot token is incorrect, ensure your token is correct. ^1Stopping...^7`
    );
    setWork(false)
  });

  if (botAccount.data) {
    await axios({
      method: "GET",
      url: `https://discord.com/api/v9/guilds/${guildId}`,
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bot ${botToken}`,
      },
    }).catch(async (err) => {
      console.log(
        `[${version}] ^5Guild ID is incorrect or bot isn't in guild. ^1Stopping...^7`
      );
      console.log(
        `[${version}] ^5Invite: https://discord.com/api/oauth2/authorize?client_id=${botAccount.data.id}&permissions=1024&scope=bot ^7`
      );
      setWork(false)
    });
  }
}, 2000);

// 0 = Not whitelisted
// 1 = Whitelisted
// 2 = Expired cache / refresh
// 3 = Blacklisted
function checkCache(userId) {
  if (cache[userId]) {
    // Check cache
    // Check timeout
    if (Date.now() > cache[userId].timeAt) {
      // cache expired
      return 2;
    } else {
      if (cache[userId].passed == 1) {
        return 1;
      } else if (cache[userId].passed == 3) {
        return 3;
      } else {
        return 0;
      }
    }
  } else {
    return 2;
  }
}


on("playerConnecting", async (name, setKickReason, deferrals) => {
  if (!getWork()) return;
  if (!enableWhitelist) return;
  let src = global.source;
  deferrals.defer();
  setTimeout(() => {
    deferrals.update(
      `Hello ${name}. Your Discord ID is being checked with our whitelist.`
    );
    setTimeout(async function () {
      getUserDiscord(src, async function (userId) {
        if (userId) {
          let resDis = await axios({
            method: "GET",
            url: `https://discord.com/api/v9/guilds/${guildId}/members/${userId}`,
            headers: {
              "Content-Type": "application/json",
              Authorization: `Bot ${botToken}`,
            },
          }).catch(async (err) => {
            if (debugMode) console.error(JSON.stringify(err));
            if (debugMode)
              console.log(`[${version}] ^5${name} is not in the guild.^7`);
            return deferrals.done(noGuildMessage);
          });
          if (!resDis) {
            if (debugMode)
              console.log(
                `[${version}] ^5Error in Discord call. Maybe consider extending the 'cacheMaxTime' option.^7`
              );
            return deferrals.done(
              "There was an error checking your Discord Id. Please contact the server owner."
            );
          }
          if (!resDis.data) {
            if (debugMode)
              console.log(
                `[${version}] ^5${name} is not in the guild. Cache created^7`
              );
            return deferrals.done(noGuildMessage);
          }
          const hasRole =
            typeof whitelistRoles === "string"
              ? resDis.data.roles.includes(whitelistRoles)
              : resDis.data.roles.some((cRole, i) =>
                resDis.data.roles.includes(whitelistRoles[i])
              );
          const hasBlackRole =
            typeof blacklistRoles === "string"
              ? resDis.data.roles.includes(blacklistRoles)
              : resDis.data.roles.some((cRole, i) =>
                resDis.data.roles.includes(blacklistRoles[i])
              );
          if (hasBlackRole) {
            if (debugMode)
              console.log(
                `[${version}] ^5${name} is blacklisted. Cache created^7`
              );
            return deferrals.done(blacklistMessage);
          }
          if (hasRole) {
            if (debugMode)
              console.log(
                `[${version}] ^5${name} is whitelisted. Cache created^7`
              );
            return deferrals.done();
          } else {
            if (debugMode) {
              console.log(
                `[${version}] ^5${name} is not whitelisted. Cache created^7`
              );
              console.log(
                `[${version}] ^5${name}s Roles: ^7`,
                resDis.data.roles
              );
            }
            return deferrals.done(notWhitelistedMessage);
          }
        } else {
          return deferrals.done(
            `Your Discord credentials were not detected. See this link for some tips to get it detected - https://docs.faxes.zone/c/fivem/debugging-discord`
          );
        }
      });
    }, 0);
  }, 0);
});


function getRoles(src) {
  if (!getWork()) return;
  return new Promise((res, rej) => {
    getUserDiscord(src, function (userId) {
      if (userId) {
        axios(`/guilds/${guildId}/members/${userId}`, {
          headers: {
            "Authorization": `Bot ${botToken}`
          }
        })
          .then((resDis) => {
            if (!resDis.data) {
              res([]);
            }
            res(resDis.data.roles);
          })
          .catch((err) => {
            console.log(err)
            res([]);
          });
      } else {
        res([]);
      }
    });
  });
}

function setRole(discordId, role, status) {
  if (!getWork()) return;
  return new Promise((res, rej) => {
    axios(`/guilds/${guildId}/members/${discordId}/roles/${role}`, {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bot ${botToken}`,
      },
      method: status ? "PUT" : "DELETE"
    })
      .then((resDis) => {
        res(true)
      })
      .catch((err) => {
        res(false);
      });
  });
}
exports("setRole", setRole);
exports("setRoleCallback", (src, role, status, cb) => {
  if (!getWork()) return;
  (async (res, rej) => {
    const response = await setRole(src, role, status)
    cb(response)
  })()
});

exports("getRoles", getRoles);

exports("getRolesCallback", (src, cb) => {
  if (!getWork()) return;
  (async (res, rej) => {
    const roles = await getRoles(src)
    cb(roles)
  })()
})

function userHasRole(src, roles) {
  if (!getWork()) return;
  return new Promise((res, rej) => {
    getUserDiscord(src, function (userId) {
      if (userId) {
        axios(`/guilds/${guildId}/members/${userId}`, {
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bot ${botToken}`,
          },
        })
          .then((resDis) => {
            if (!resDis.data) {
              res(false);
            }
            const hasRole =
              typeof roles === "string"
                ? resDis.data.roles.includes(roles)
                : resDis.data.roles.some((cRole, i) =>
                  resDis.data.roles.includes(roles[i])
                );
            if (hasRole) {
              res(true);
            } else {
              res(false);
            }
          })
          .catch((err) => {
            res(false);
          });
      } else {
        res(false);
      }
    });
  });
}
exports("userHasRole", userHasRole);
exports("userHasRoleCallback", (src, roles, cb) => {
  if (!getWork()) return;
  (async (res, rej) => {
    const response = await userHasRole(src, roles)
    cb(response)
  })()
});

exports("getName", (src) => {
  if (!getWork()) return;
  return new Promise((res, rej) => {
    getUserDiscord(src, function (userId) {
      if (userId) {
        axios(`/guilds/${guildId}/members/${userId}`)
          .then((resDis) => {
            if (!resDis.data) {
              res(null);
            }
            res({
              username: resDis.data.username,
              discriminator: resDis.data.discriminator,
              nickname: resDis.data.nick,
            });
          })
          .catch((err) => {
            res(null);
          });
      } else {
        res(null);
      }
    });
  });
});


const fallbackCallback = () => { }

exports("sendMessage", ({
  channelId,
  embeds = [],
  content,
  addTimestamp,
}, cb) => {
  if (!getWork()) return;
  if (GetConvar("environment") != "production") {
    if (cb) cb({ id: "xxx" })
    return console.log("[stem_discord] Production mode not enabled, discord message not sent with data:", {
      content: content,
      embeds: embeds.map((embed) => {
        if (addTimestamp) return { ...embed, timestamp: new Date().toISOString() }
        return embed
      })
    })
  }
  axios({
    method: "POST",
    url: `https://discord.com/api/v10/channels/${channelId}/messages`,
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bot ${botToken}`,
    },
    data: JSON.stringify({
      content: content,
      embeds: embeds.map((embed) => {
        if (addTimestamp) return { ...embed, timestamp: new Date().toISOString() }
        return embed
      })
    })
  }).then(async (res) => { if (cb) cb(res.data); }).catch(console.log)
})

exports("sendThroughWebhook", ({
  webhook,
  params,
  ignoreEnv
}, cb) => {
  if (!getWork()) return;
  if (!ignoreEnv && GetConvar("environment") != "production") {
    return console.log("[stem_discord] Production mode not enabled, discord message not sent with data:", {
      params: params,
    })
  }
  axios({
    method: "POST",
    url: webhook,
    headers: {
      "Content-Type": "application/json",
    },
    data: JSON.stringify(params)
  }).then(async (res) => { if (cb) cb(res.data); }).catch(console.log)
})

exports("updateEmbed", ({
  channelId,
  messageId,
  embeds = [],
  addTimestamp,
}, cb) => {
  if (!getWork()) return;
  axios({
    method: "PATCH",
    url: `https://discord.com/api/v10/channels/${channelId}/messages/${messageId}`,
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bot ${botToken}`,
    },
    data: JSON.stringify({
      embeds: embeds.map((embed) => {
        if (addTimestamp) return { ...embed, timestamp: new Date().toISOString() }
        return embed
      })
    })
  }).then(async (res) => { if (cb) cb(res.data); }).catch(console.log)
})

const sendILIke = ({
  channelId,
  mentionId
}) => {
  if (!getWork()) return;
  return new Promise(async (res, rej) => {
    await axios({
      method: "POST",
      url: `https://discord.com/api/v10/channels/${channelId}/messages`,
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bot ${botToken}`,
      },
      data: JSON.stringify({
        content: mentionId ? `<@!${mentionId}>` : undefined,
        embeds: [{
          type: "gifv",
          image: {
            url: "https://c.tenor.com/ZQbD9ld_J9oAAAAC/tenor.gif"
          }
        }]
      })
    }).catch(console.log)
  })
}
exports("sendILike", sendILIke)

RegisterCommand("boratSendILike", (source, args) => {
  const [channelId, userId] = args;
  sendILIke({ channelId, mentionId: userId })
}, true)
