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
      punten = 0
      for key_voorspelling, voorspelling of $rootScope.personen[key_persoon].voorspellingen# when voorspelling.score1
        for key_wedstrijd, wedstrijd of $rootScope.wedstrijden
          if key_voorspelling == key_wedstrijd
            if winst(wedstrijd, voorspelling)
              punten += 5
            if gelijk(wedstrijd, voorspelling)
              punten += 1
      punten
    
    winst = (wedstrijd, voorspelling) ->
      false
      
    gelijk = (wedstrijd, voorspelling) ->
      true