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
    
    voorspellingenRef = new Firebase "https://resplendent-fire-2516.firebaseio.com/voorspellingen"
    personenRef = new Firebase "https://resplendent-fire-2516.firebaseio.com/personen"
    $firebase(personenRef).$bind($scope,"personenBind") # Deze wordt in sync gehouden met de db
#    $scope.personen = $firebase personenRef # Dit wordt niet 3-way gesyncd
#    $scope.voegToe = (persoon, ploeg) ->
#      console.log "aan het toevoegen"
#      $scope.personen.persoon.ploeg = ploeg
    
