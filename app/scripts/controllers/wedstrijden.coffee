'use strict'

###*
 # @ngdoc function
 # @name poule2App.controller:AboutCtrl
 # @description
 # # AboutCtrl
 # Controller of the poule2App
###
angular.module('poule2App')
  .controller 'WedstrijdenCtrl', ($scope, $rootScope, $firebase, $filter) ->
    console.log "WedstrijdenCtrl init"
    $rootScope.curTab = "wedstrijden"
    
    $scope.voegToe = () ->
      console.log "ploeg toevoegen"
      newPloegRef = $rootScope.ploegenRef.push()
      newPloegRef.set($scope.newPloeg)
      
    $scope.verwijder = (ploeg) ->
      console.log "ploeg verwijderen"
      console.log ploeg
      $rootScope.ploegenRef.child(ploeg).remove()
