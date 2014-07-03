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
    $scope.currentPage = 1
    $scope.maxItems = 100
    $scope.itemsPerPage = 10
    $scope.newChat = {}
    
    $scope.punten = (key_persoon) ->
      $punten = 0
      for key_voorspelling, voorspelling of $rootScope.personen[key_persoon].voorspellingen# when voorspelling.score1
        for key_wedstrijd, wedstrijd of $rootScope.wedstrijden when $rootScope.wedstrijdGespeeld(wedstrijd) #only gespeelde wedstrijden
          if key_voorspelling == key_wedstrijd
            $punten += $rootScope.punten(wedstrijd, voorspelling)
            
      $punten
      
    $scope.addChat = () ->
      if $scope.newChat and $scope.newChat.bericht != "" and ($scope.newChat.naam or $rootScope.loginObj.user)
        chat = $scope.newChat
        $scope.newChat = null
        if $rootScope.loginObj.user
          chat.naam = $rootScope.loginObj.user.thirdPartyUserData.first_name
          chat.id = $rootScope.loginObj.user.id
        $rootScope.chatsRef.$add(chat)
    $rootScope.$on "$firebaseSimpleLogin:login", (e, user) ->
      console.log("User " + user.id + " successfully logged in!")
  .filter 'orderByPunten', ->
    (items, scope) ->
      items.sort (a,b) ->
        scope.punten(b.$id) - scope.punten(a.$id)
  .filter 'pagination', ->
    (items, scope) ->
      start = (scope.currentPage-1) * scope.itemsPerPage
      end = (scope.currentPage-1) * scope.itemsPerPage + scope.itemsPerPage
      items[start...end]
    