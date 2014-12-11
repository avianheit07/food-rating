module.exports = function (grunt) {
	grunt.registerTask('build', [
		'compileAssets',
		'linkAssets',
		'clean:build',
		'copy:build'
	]);
};
