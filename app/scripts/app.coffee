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
      .when '/personen',
        templateUrl: 'views/personen.html'
        controller: 'PersonenCtrl'
      .when '/ploegen',
        templateUrl: 'views/ploegen.html'
        controller: 'PloegenCtrl'
      .when '/wedstrijden',
        templateUrl: 'views/wedstrijden.html'
        controller: 'WedstrijdenCtrl'
      .otherwise
        redirectTo: '/'
#  .controller 'IndexCtrl', ($scope, $rootScope, $firebase, $filter) ->
#    $rootScope.curTab = "
  .run ($rootScope, $firebase) -> # Wanneer iets bij init gerund moet worden
    $rootScope.loading = true
    
    $rootScope.ploegenRef = $firebase(new Firebase "https://resplendent-fire-2516.firebaseio.com/ploegen")
    $rootScope.ploegenRef.$bind($rootScope,"ploegen")
    
    $rootScope.wedstrijdenRef = $firebase(new Firebase "https://resplendent-fire-2516.firebaseio.com/wedstrijden")
    $rootScope.wedstrijdenRef.$bind($rootScope,"wedstrijden")
    
    $rootScope.personenRef = $firebase(new Firebase "https://resplendent-fire-2516.firebaseio.com/personen")
    $rootScope.personenRef.$bind($rootScope,"personen")
    
    $rootScope.voorspellingenRef = $firebase(new Firebase "https://resplendent-fire-2516.firebaseio.com/voorspellingen")
    $rootScope.voorspellingenRef.$bind($rootScope,"voorspellingen")
    
    $rootScope.wedstrijdenRef.$on("loaded", () ->
      $rootScope.loading = false
    )

