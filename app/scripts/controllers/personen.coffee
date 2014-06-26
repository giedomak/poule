'use strict'

###*
 # @ngdoc function
 # @name poule2App.controller:AboutCtrl
 # @description
 # # AboutCtrl
 # Controller of the poule2App
###
angular.module('poule2App')
  .controller 'PersonenCtrl', ($scope, $rootScope, $firebase, $routeParams, $filter) ->
    console.log "PersonenCtrl init"
    $rootScope.curTab = "personen"
    $scope.wed = {}
    
    $rootScope.personenRef.$on "loaded", () ->
      if $routeParams.naam
        ($scope.select(persoon.$id)) for persoon in ($filter('orderByPriority')($rootScope.personen)) when $filter('lowercase')(persoon.naam) is $filter('lowercase')($routeParams.naam)
    
    $scope.select = (key) ->
      $rootScope.selectedPersoon = $rootScope.personen.$child key
      console.log "Persoon selected: ",$rootScope.selectedPersoon.naam
      ref = $rootScope.wedstrijden.$getIndex()
      ref.forEach( (key2, i) ->
#        console.log(i, $rootScope.wedstrijden[key2]);
#        name = child.name()
        $scope.wed[key2] = { score1: 3}
        $rootScope.personen[key].voorspellingen = $rootScope.personen[key].voorspellingen || {}
        $rootScope.personen[key].voorspellingen[key2] = $rootScope.personen[key].voorspellingen[key2] || {score1:0, score2:0}
      )
      
    $scope.canChange = (wedstrijd) ->
      $rootScope.loginObj.user and $rootScope.selectedPersoon and parseInt($rootScope.loginObj.user.id) is parseInt($rootScope.selectedPersoon.id) and !wedstrijd.gespeeld
    
    $scope.voegToe = () ->
      console.log "persoon toevoegen"
      $rootScope.personenRef.$add($scope.newPersoon)
      
    $scope.verwijder = () ->
      console.log "persoon verwijderen"
      console.log $rootScope.selectedPersoon
      $rootScope.personenRef.$remove($rootScope.selectedPersoon.$id)
      $rootScope.selectedPersoon = null
      
    $scope.puntenWedstrijd = (key, wedstrijd) ->
      if $rootScope.selectedPersoon && wedstrijd.gespeeld
        return $rootScope.punten(wedstrijd, $rootScope.personen[$rootScope.selectedPersoon.$id].voorspellingen[key])
      else 
        return 0