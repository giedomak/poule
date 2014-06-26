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
      .when '/personen/:naam',
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
    
    $rootScope.chatsRef = $firebase(new Firebase "https://resplendent-fire-2516.firebaseio.com/chats")
    $rootScope.chatsRef.$bind($rootScope,"chats")
    
    #Volledige uitslag goed is 10 punten, alleen winnaar correct is 5 punten, gelijkspel correct is 7 punten, doelpunten thuis of uit team correct is 2 punten
    $rootScope.punten = (wedstrijd, voorspelling) ->
      points = 0
      if correct(wedstrijd, voorspelling) then return 10
      if gelijk(wedstrijd, voorspelling) then return 7
      if winst(wedstrijd, voorspelling) then points = 5
      if doelpuntCorrect(wedstrijd, voorspelling) then return points += 2
      return points
    
    winst = (wedstrijd, voorspelling) ->
      return ((wedstrijd.scorePloeg1 > wedstrijd.scorePloeg2 && voorspelling.score1 > voorspelling.score2) || (wedstrijd.scorePloeg1 < wedstrijd.scorePloeg2 && voorspelling.score1 < voorspelling.score2))

    gelijk = (wedstrijd, voorspelling) ->
      return (wedstrijd.scorePloeg1 == wedstrijd.scorePloeg2 && voorspelling.score1 == voorspelling.score2)

    correct = (wedstrijd, voorspelling) ->
      return (wedstrijd.scorePloeg1 == voorspelling.score1 && wedstrijd.scorePloeg2 == voorspelling.score2)

    doelpuntCorrect = (wedstrijd, voorspelling) ->
      return (wedstrijd.scorePloeg1 == voorspelling.score1 || wedstrijd.scorePloeg2 == voorspelling.score2)

    $rootScope.wedstrijdenRef.$on("loaded", () ->
      $rootScope.loading = false
    )
  .filter 'reverse', ->
    (items) ->
      items.slice().reverse();

