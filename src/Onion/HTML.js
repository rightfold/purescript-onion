'use strict';

var VirtualDOM = {
  h: require('virtual-dom/h'),
};

exports._element = function(element) {
  return function(props) {
    return function(children) {
      var propsObject = {};
      props.forEach(function(prop) {
        propsObject[prop.key] = prop.value;
      });
      return VirtualDOM.h(element, propsObject, children);
    };
  };
};

exports._text = function(text) {
  return text;
};

exports._unsafeProp = function(key) {
  return function(value) {
    return {key: key, value: value};
  };
};
