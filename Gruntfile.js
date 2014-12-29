module.exports = function(grunt) {

    "use strict";

    grunt.initConfig({

        bowerFiles: ["bower_components/**/src/**/*.purs"],

        dotPsci: {
            src: ["<%=bowerFiles%>"]
        },

        psc: {
            options: {
                modules: ["Main"],
                main: "Main"
            },
            ch0: {
                src: ["ch0/src/HappyMessage.purs"],
                dest: "out/Happy.js"
            },
            ch2: {
                src: ["ch2/src/Chapter2.purs"],
                dest: "out/Chapter2.js"
            }
        }
    });

    grunt.loadNpmTasks("grunt-purescript");

    grunt.registerTask("default", ["dotPsci"]);
    grunt.registerTask("ch0", ["psc:ch0"]);
    grunt.registerTask("ch2", ["psc:ch2"]);
};
