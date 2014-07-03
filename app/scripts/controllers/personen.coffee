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
    $scope.selected = null
    
    #select user if login was made from within personen
    $rootScope.$on "$firebaseSimpleLogin:login", (e, user) ->
      $scope.select user.id
    
    #select person when loading page
    $rootScope.personenRef.$on "loaded", () ->
      console.log "personenRef loaded event"
      if $routeParams.id
#        ($scope.select(persoon.$id)) for persoon in ($filter('orderByPriority')($rootScope.personen)) when parseInt(persoon.id) is parseInt($routeParams.naam)
        $scope.select(parseInt($routeParams.id))
      else
        if $rootScope.loginObj.user
          $scope.select($rootScope.loginObj.user.id)
      
    initVoorspelling = (persoon_id, wed_id) ->
      $rootScope.personen[persoon_id].voorspellingen = $rootScope.personen[persoon_id].voorspellingen || {}
      $rootScope.personen[persoon_id].voorspellingen[wed_id] = $rootScope.personen[persoon_id].voorspellingen[wed_id] || {bogus: false} #bogus is nodig om daadwerkelijk naar de DB te schrijven
          
    $scope.voorspellingIsSet = (persoon_id, wed_id) ->
      if $rootScope.personen.hasOwnProperty(parseInt(persoon_id))
        if $rootScope.personen[persoon_id].hasOwnProperty('voorspellingen')
          if $rootScope.personen[persoon_id].voorspellingen.hasOwnProperty(wed_id)
            voorspelling = $rootScope.personen[persoon_id].voorspellingen[wed_id]
            return voorspelling.hasOwnProperty('score1') and voorspelling.hasOwnProperty('score2')
    
    $scope.select = (key) ->
      $rootScope.personenRef.$on "loaded", () ->
        if $scope.selected isnt parseInt key
          $scope.selected = parseInt key
          console.log "Persoon selected: ",$rootScope.personen[key].naam
          initVoorspelling $scope.selected, wed_id for foo, wed_id of $rootScope.wedstrijden.$getIndex()
      
    $scope.canChange = (wedstrijd) ->
      $rootScope.loginObj.user and $scope.selected and parseInt($rootScope.loginObj.user.id) is parseInt($scope.selected) and !$rootScope.wedstrijdGespeeld(wedstrijd)
    
    $scope.verwijder = () ->
      console.log "persoon verwijderen"
      console.log $rootScope.selectedPersoon
      $rootScope.personenRef.$remove($rootScope.selectedPersoon.$id)
      $rootScope.selectedPersoon = null
      
    $scope.puntenWedstrijd = (key, wedstrijd) ->
      if $scope.selected && $rootScope.wedstrijdGespeeld(wedstrijd) && $scope.voorspellingIsSet $scope.selected, key
        return $rootScope.punten(wedstrijd, $rootScope.personen[$scope.selected].voorspellingen[key])
      else 
        return 0