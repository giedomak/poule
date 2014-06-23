'use strict'

###*
 # @ngdoc function
 # @name poule2App.controller:AboutCtrl
 # @description
 # # AboutCtrl
 # Controller of the poule2App
###
angular.module('poule2App')
  .controller 'PersonenCtrl', ($scope, $rootScope, $firebase) ->
    console.log "PersonenCtrl init"
    $rootScope.curTab = "personen"
    
    $scope.select = (key) ->
      $scope.selectedPersoon = $rootScope.personenRef.$child key
    
    $scope.voegToe = () ->
      console.log "persoon toevoegen"
      $rootScope.personenRef.$add($scope.newPersoon)
      
    $scope.verwijder = () ->
      console.log "persoon verwijderen"
      console.log $scope.selectedPersoon
      $rootScope.personenRef.$remove($scope.selectedPersoon.$id)
      $scope.selectedPersoon = null