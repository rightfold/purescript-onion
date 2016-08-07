'use strict';

var VirtualDOM = {
  h: require('virtual-dom/h'),
  diff: require('virtual-dom/diff'),
  patch: require('virtual-dom/patch'),
  createElement: require('virtual-dom/create-element'),
};

exports._h = function(element) {
  return function(properties) {
    return function(children) {
      return VirtualDOM.h(element, properties, children);
    };
  };
};

exports._t = function(text) {
  return text;
};

exports._run = function(initialState) {
  return function(component) {
    return function() {
      var state = initialState, tree = null, node;

      var refresh = function() {
        var tree_ = component(state)(function(state_) {
          return function() {
            state = state_;
            refresh();
          };
        });
        if (tree === null) {
          node = VirtualDOM.createElement(tree_);
          document.body.appendChild(node);
        } else {
          VirtualDOM.patch(node, VirtualDOM.diff(tree, tree_));
        }
        tree = tree_;
      };

      addEventListener('load', function() {
        refresh();
      });
    };
  };
};
