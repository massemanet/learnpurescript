module.exports = function(grunt) {

    "use strict";

    grunt.initConfig({

        srcFiles: ["src/**/*.purs", "bower_components/**/src/**/*.purs"],

        psc: {
            options: {
                main: "HappyMessage",
                modules: ["HappyMessage"]
            },
            all: {
                src: ["<%=srcFiles%>"],
                dest: "dist/Happy.js"
            }
        }
    });

    grunt.loadNpmTasks("grunt-purescript");

    grunt.registerTask("default", ["psc:all"]);
};
