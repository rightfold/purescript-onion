'use strict';

var VirtualDOM = {
  h: require('virtual-dom/h'),
};

exports._unsafeElement = function(element) {
  return function(properties) {
    return function(children) {
      return VirtualDOM.h(element, properties, children);
    };
  };
};

exports._text = function(text) {
  return text;
};
