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
    'ui.bootstrap',
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
      .when '/personen/:id',
        templateUrl: 'views/personen.html'
        controller: 'PersonenCtrl'
      .when '/ploegen',
        templateUrl: 'views/ploegen.html'
        controller: 'PloegenCtrl'
      .when '/opties',
        templateUrl: 'views/opties.html'
        controller: 'OptiesCtrl'
      .when '/wedstrijden',
        templateUrl: 'views/wedstrijden.html'
        controller: 'WedstrijdenCtrl'
      .otherwise
        redirectTo: '/'
  .run ($rootScope, $firebase, $firebaseSimpleLogin, $http) -> # Wanneer iets bij init gerund moet worden
    $rootScope.loading = true
    personenRefLoaded = false
    $rootScope.profilePic = null
    $rootScope.ploegen = {}
    $rootScope.personen = {}
    $rootScope.wedstrijden = {}
    $rootScope.chats = {}
    $rootScope.opties = {}
    
    #firebase bindings
    $rootScope.ploegenRef = $firebase(new Firebase "https://resplendent-fire-2516.firebaseio.com/ploegen")
    $rootScope.ploegenRef.$bind($rootScope,"ploegen")
    
    $rootScope.wedstrijdenRef = $firebase(new Firebase "https://resplendent-fire-2516.firebaseio.com/wedstrijden")
    $rootScope.wedstrijdenRef.$bind($rootScope,"wedstrijden")
    
    $rootScope.personenRef = $firebase(new Firebase "https://resplendent-fire-2516.firebaseio.com/personen")
    $rootScope.personenRef.$bind($rootScope,"personen")
    
    $rootScope.chatsRef = $firebase(new Firebase "https://resplendent-fire-2516.firebaseio.com/chats")
    $rootScope.chatsRef.$bind($rootScope,"chats")
    
    $rootScope.optiesRef = $firebase(new Firebase "https://resplendent-fire-2516.firebaseio.com/opties")
    $rootScope.optiesRef.$bind($rootScope,"opties")

    #set loading to false
    $rootScope.wedstrijdenRef.$on("loaded", () ->
      $rootScope.loading = false
      $rootScope.wedstrijdenRefLoaded = true
    )
    
    $rootScope.personenRef.$on "loaded", () ->
      $rootScope.personenRefLoaded = true
    
    #login object for firebase easy login
    dataRef = new Firebase("https://resplendent-fire-2516.firebaseio.com");
    $rootScope.loginObj = $firebaseSimpleLogin(dataRef);
    
    #Volledige uitslag goed is 10 punten, alleen winnaar correct is 5 punten, gelijkspel correct is 7 punten, doelpunten thuis of uit team correct is 2 punten
    $rootScope.punten = (wedstrijd, voorspelling) ->
      if !voorspelling.hasOwnProperty('score1') or !voorspelling.hasOwnProperty('score2') then return 0
      if correct(wedstrijd, voorspelling) then return 10
      if gelijk(wedstrijd, voorspelling) then return 7
      points = 0
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
    
    #persoon toevoegen
    $rootScope.voegPersoonToe = (newPersoon) ->
      console.log "persoon toevoegen"
      $rootScope.personenRef.$add(newPersoon)
      
    #persoon toevoegen aan de hand van facebook
    addPersoonFb = (user) ->
      $rootScope.personenRef.$on "loaded", () ->
        if user.id in $rootScope.personenRef.$getIndex()
          console.log "Id exists", user
        else 
          console.log "It doesn't, creating it", user
          $rootScope.personen[user.id] = {naam: user.thirdPartyUserData.first_name, thirdPartyUserData: user.thirdPartyUserData}
      
    #On firebase login event. Get's fired when logged in already or when logging in
    $rootScope.$on "$firebaseSimpleLogin:login", (e, user) ->
      #add user if it does not exist
      addPersoonFb(user)
      #update profile picture
      $http.get "https://graph.facebook.com/"+user.id+"/picture?redirect=false"
      .success (data) ->
        $rootScope.profilePic = data.data.url
        
    $rootScope.isAdmin = () ->
      if $rootScope.loginObj.user and $rootScope.personenRefLoaded
        return $rootScope.personen[$rootScope.loginObj.user.id].role is 'admin' 
    
    $rootScope.wedstrijdGespeeld = (wedstrijd) ->
#      wedstrijd = $rootScope.wedstrijden[key]
      now = new Date
      wedstrijddate = new Date(wedstrijd.date)
      
      return now.getTime() >= wedstrijddate.getTime()
      
#      if now.getYear() > wedstrijddate.getYear() then return true
#      
#      if now.getMonth() > wedstrijddate.getMonth() then return true
#      
#      if now.getDay() > wedstrijddate.getDay() then return true
#      
#      if (now.getDay() is (wedstrijddate.getDay()))
#        if now.getHours() > wedstrijd.hour then return true
#      
#        if now.getHours() is wedstrijd.hour
#          if now.getMinutes() >= wedstrijd.minute
#            return true
#            
#      return false
    
  .filter 'reverse', ->
    (items) ->
      items.slice().reverse();

