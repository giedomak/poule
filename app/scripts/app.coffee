'use strict'

###*
 # @ngdoc overview
 # @name poule2App
 # @description
 # # poule2App
 #
 # Main module of the application.
###
angular
  .module('poule2App', [
    'ngAnimate',
    'ngCookies',
    'ngResource',
    'ngRoute',
    'ngSanitize',
    'ngTouch',
    'firebase'
  ])
  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .when '/about',
        templateUrl: 'views/about.html'
        controller: 'AboutCtrl'
      .otherwise
        redirectTo: '/'
  .run ($rootScope, $firebase) ->

