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
    $scope.newWedstrijd = {}
    
    $rootScope.ploegenRef.$on("loaded", (value) ->
      $scope.newWedstrijd.ploeg1 = $filter('orderByPriority')($rootScope.ploegen)[0]
      $scope.newWedstrijd.ploeg2 = $filter('orderByPriority')($rootScope.ploegen)[0]
    )
    
    $scope.verwijder = (key) ->
      $rootScope.wedstrijdenRef.$remove(key)
    
    $scope.voegToe = () ->
      console.log "wedstrijd toevoegen"
      console.log $scope.newWedstrijd
#      console.log $rootScope.ploegenRef.child($scope.newWedstrijd.ploeg1.$id)
#      $scope.newWedstrijd.ploegEen = () ->
#        $rootScope.ploegenRef.child(wedstrijd.ploeg1).val()
#      $scope.test1 = $rootScope.ploegenRef.child($scope.newWedstrijd.ploeg1.$id)
#      $scope.test2 = $rootScope.ploegenRef.child($scope.newWedstrijd.ploeg2.$id)
#      $scope.newWedstrijd.ploeg1 = $scope.newWedstrijd.ploeg1.$id
#      $scope.newWedstrijd.ploeg2 = $scope.newWedstrijd.ploeg2.$id
#      $scope.newWedstrijd.ploeg2 = $scope.newWedstrijd.ploeg2.$id
#      console.log $scope.newWedstrijd
#      $scope.ploeg1 = $rootScope.ploegenRef.child($scope.newWedstrijd.ploeg1.$id)
#      $scope.ploeg2 = $rootScope.ploegenRef.child($scope.newWedstrijd.ploeg2.$id)
#      $scope.newWedstrijd.ploeg1 = $scope.ploeg1
#      $scope.newWedstrijd.ploeg2 = $scope.ploeg2
#      newPloegRef = $rootScope.wedstrijdenRef.push()
#      newPloegRef.set($scope.newWedstrijd)

      $rootScope.wedstrijdenRef.$add($scope.newWedstrijd)

    $scope.ploegEen = (wedstrijd) ->
      console.log $rootScope.ploegenRef.child(wedstrijd.ploeg1)
      $rootScope.ploegenRef.child(wedstrijd.ploeg1).val()
