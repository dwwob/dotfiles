/**
 * @fileoverview Linting rules for tree sitter
 * @author Christian Murphy
 */
"use strict";

//------------------------------------------------------------------------------
// Requirements
//------------------------------------------------------------------------------

var requireIndex = require("requireindex");

//------------------------------------------------------------------------------
// Plugin Definition
//------------------------------------------------------------------------------

module.exports = {
  configs: {
    recommended: {
      plugins: ["tree-sitter"],
      parserOptions: {
        ecmaVersion: 2018
      },
      env: {
        node: true,
        es6: true,
        "tree-sitter/globals": true
      },
      rules: {
        "no-undef": "error"
      }
    }
  },
  environments: {
    globals: {
      globals: {
        // globals provided by tree sitter
        grammar: false,
        seq: false,
        choice: false,
        repeat: false,
        repeat1: false,
        optional: false,
        prec: false,
        token: false,
        alias: false
      }
    }
  },
  // import all rules in lib/rules
  rules: requireIndex(__dirname + "/rules")
};
