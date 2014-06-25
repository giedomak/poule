'use strict'

###*
 # @ngdoc function
 # @name poule2App.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the poule2App
###
angular.module('poule2App')
  .controller 'MainCtrl', ($scope, $rootScope, $firebase) ->
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
      chat = $rootScope.chats.newChat
      $rootScope.chatsRef.$add(chat).then ->
        $rootScope.chats.newChat = {}
    