const { environment } = require("@rails/webpacker");
const pluginProvide = require("./plugins/provide");

environment.plugins.prepend("Provide", pluginProvide.plugin);

module.exports = environment;
