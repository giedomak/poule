'use strict'

###*
 # @ngdoc function
 # @name poule2App.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the poule2App
###
angular.module('poule2App')
  .controller 'MainCtrl', ($scope, $rootScope, $firebase, $firebaseSimpleLogin) ->
    console.log "MainCtrl init"
    $rootScope.curTab = "main"
    
    $scope.punten = (key_persoon) ->
      $punten = 0
      for key_voorspelling, voorspelling of $rootScope.personen[key_persoon].voorspellingen# when voorspelling.score1
        for key_wedstrijd, wedstrijd of $rootScope.wedstrijden when wedstrijd.gespeeld #only gespeelde wedstrijden
          if key_voorspelling == key_wedstrijd
            $punten += $rootScope.punten(wedstrijd, voorspelling)
            
      $punten
      
    $scope.addChat = () ->
      if $scope.newChat and $scope.newChat.bericht != "" and ($scope.newChat.naam or $rootScope.loginObj.user)
        chat = $scope.newChat
        $scope.newChat = null
        chat.naam = chat.naam || $rootScope.loginObj.user.thirdPartyUserData.first_name
        $rootScope.chatsRef.$add(chat)
    $rootScope.$on "$firebaseSimpleLogin:login", (e, user) ->
      console.log("User " + user.id + " successfully logged in!")
      console.log user
      console.log $rootScope.loginObj
  .filter 'orderByPunten', ->
    (items, scope) ->
      items.sort (a,b) ->
        scope.punten(b.$id) - scope.punten(a.$id)
    