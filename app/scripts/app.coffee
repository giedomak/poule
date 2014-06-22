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
      .when '/ploegen',
        templateUrl: 'views/ploegen.html'
        controller: 'AboutCtrl'
      .when '/wedstrijden',
        templateUrl: 'views/wedstrijden.html'
        controller: 'WedstrijdenCtrl'
      .otherwise
        redirectTo: '/'
#  .controller 'IndexCtrl', ($scope, $rootScope, $firebase, $filter) ->
#    $rootScope.curTab = "
  .run ($rootScope, $firebase) -> # Wanneer iets bij init gerund moet worden
    $rootScope.ploegenRef = new Firebase "https://resplendent-fire-2516.firebaseio.com/ploegen"
    $firebase($rootScope.ploegenRef).$bind($rootScope,"ploegen")

