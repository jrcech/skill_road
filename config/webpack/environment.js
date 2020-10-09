const { environment } = require("@rails/webpacker");
const erb = require("./loaders/erb");
const pluginProvide = require("./plugins/provide");

environment.plugins.prepend("Provide", pluginProvide.plugin);
environment.loaders.prepend("erb", erb);

module.exports = environment;
