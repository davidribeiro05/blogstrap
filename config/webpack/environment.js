const { environment } = require('@rails/webpacker')

// Add the following lines
const webpack = require("webpack")

environment.plugins.append("Provide", new webpack.ProvidePlugin({
    Popper: ['popper.js', 'default']  // Not a typo, we're still using popper.js here
}))

// End new addition
module.exports = environment
