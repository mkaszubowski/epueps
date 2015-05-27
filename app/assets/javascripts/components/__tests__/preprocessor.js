var ReactTools = require('react-tools');
//
// module.exports = {
//   process: function(src) {
//     return ReactTools.transform(src);
//   }
// };
//

// preprocessor.js
var coffee = require('coffee-script');

module.exports = {
  process: function(src, path) {
    // CoffeeScript files can be .coffee, .litcoffee, or .coffee.md
    if (coffee.helpers.isCoffee(path)) {
      coffee_src = coffee.compile(src, {'bare': true});
      return ReactTools.transform(coffee_src);
    }
    return src;
  }
};
