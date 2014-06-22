'use strict'

###*
 # @ngdoc function
 # @name poule2App.controller:AboutCtrl
 # @description
 # # AboutCtrl
 # Controller of the poule2App
###
angular.module('poule2App')
  .controller 'PloegenCtrl', ($scope, $rootScope, $firebase, $filter) ->
    console.log "PloegenCtrl init"
    $rootScope.curTab = "ploegen"
    
    $scope.voegToe = () ->
      console.log "ploeg toevoegen"
      newPloegRef = $rootScope.ploegenRef.push()
      newPloegRef.set($scope.newPloeg)
      
    $scope.verwijder = (ploeg) ->
      console.log "ploeg verwijderen"
      console.log ploeg
      $rootScope.ploegenRef.child(ploeg).remove()
