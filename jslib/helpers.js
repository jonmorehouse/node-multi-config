// Generated by CoffeeScript 1.6.3
(function() {
  exports.camelCase = function(key) {
    var normalize, piece, pieces;
    normalize = function(input) {
      return input[0].toUpperCase() + input.slice(1, input.length).toLowerCase();
    };
    pieces = key.split("_");
    if (pieces.length > 1) {
      return pieces[0].toLowerCase() + ((function() {
        var _i, _len, _ref, _results;
        _ref = pieces.slice(1, +pieces.length + 1 || 9e9);
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          piece = _ref[_i];
          _results.push(normalize(piece));
        }
        return _results;
      })()).join("");
    } else {
      return pieces[0].toLowerCase();
    }
  };

  exports.normalizeValue = function(value) {
    var array, number;
    number = value.match(/^([0-9\.]+)$/);
    if (number != null) {
      return parseInt(value);
    }
    array = value.split(",");
    if ((array != null) && array.length > 1) {
      return (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = array.length; _i < _len; _i++) {
          value = array[_i];
          _results.push(exports.normalizeValue(value));
        }
        return _results;
      })();
    }
    return value;
  };

}).call(this);
