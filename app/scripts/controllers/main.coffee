'use strict'

###*
 # @ngdoc function
 # @name poule2App.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the poule2App
###
angular.module('poule2App')
  .controller 'MainCtrl', ($scope, $firebase) ->
    personenRef = new Firebase "https://resplendent-fire-2516.firebaseio.com/personen"
    ploegenRef = new Firebase "https://resplendent-fire-2516.firebaseio.com/ploegen"
    voorspellingenRef = new Firebase "https://resplendent-fire-2516.firebaseio.com/voorspellingen"
    $firebase(personenRef).$bind($scope,"personen") # Deze wordt in sync gehouden met de db
#    $scope.personen = $firebase personenRef # Dit wordt niet 3-way gesyncd
    $scope.ploegen = $firebase ploegenRef
    $scope.voegToe = (persoon, ploeg) ->
      console.log "aan het toevoegen"
      $scope.personen.persoon.ploeg = ploeg
    
