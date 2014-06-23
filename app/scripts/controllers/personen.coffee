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
    $scope.wed = {}
    
    
    $scope.select = (key) ->
      $rootScope.selectedPersoon = $rootScope.personen.$child key
      ref = $rootScope.wedstrijden.$getIndex()
      console.log ref
      ref.forEach( (key2, i) ->
#        console.log(i, $rootScope.wedstrijden[key2]);
#        name = child.name()
        $scope.wed[key2] = { score1: 3}
        $rootScope.personen[key].voorspellingen = $rootScope.personen[key].voorspellingen || {}
        console.log $rootScope.personen[key]
        $rootScope.personen[key].voorspellingen[key2] = $rootScope.personen[key].voorspellingen[key2] || {score1:0, score2:0}
        console.log $rootScope.personen[key]
      )
      
    
    $scope.voegToe = () ->
      console.log "persoon toevoegen"
      $rootScope.personenRef.$add($scope.newPersoon)
      
    $scope.verwijder = () ->
      console.log "persoon verwijderen"
      console.log $rootScope.selectedPersoon
      $rootScope.personenRef.$remove($rootScope.selectedPersoon.$id)
      $rootScope.selectedPersoon = null
    
    $scope.scorePloeg1 = () ->
      8