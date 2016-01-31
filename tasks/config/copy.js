/**
 * Copy files and folders.
 *
 * ---------------------------------------------------------------
 *
 * # dev task config
 * Copies all directories and files, exept coffescript and less fiels, from the sails
 * assets folder into the .tmp/public directory.
 *
 * # build task config
 * Copies all directories nd files from the .tmp/public directory into a www directory.
 *
 * For usage docs see:
 *    https://github.com/gruntjs/grunt-contrib-copy
 */
module.exports = function (grunt) {
  grunt.config.set('copy', {
    dev: {
      files: [
        {
          expand: true,
          cwd: './assets',
          src: ['**/*.!(coffee|less|ts|*.ts)'],
          dest: '.tmp/public'
        },
        {
          expand: true,
          cwd: './node_modules',
          src: require('../pipeline').angular2Module,
          dest: '.tmp/public/angular2'
        }
      ]
    },
    build: {
      files: [{
        expand: true,
        cwd: '.tmp/public',
        src: ['**/*'],
        dest: 'www'
      }]
    }
  });

  grunt.loadNpmTasks('grunt-contrib-copy');
};