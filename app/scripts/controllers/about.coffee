'use strict'

###*
 # @ngdoc function
 # @name poule2App.controller:AboutCtrl
 # @description
 # # AboutCtrl
 # Controller of the poule2App
###
angular.module('poule2App')
  .controller 'AboutCtrl', ($scope, $rootScope, $firebase, $filter) ->
    console.log "AboutCtrl init"
    ploegenRef = new Firebase "https://resplendent-fire-2516.firebaseio.com/ploegen"
    $firebase(ploegenRef).$bind($rootScope,"ploegen")
    $scope.ploegen2 = $filter("orderByPriority")($rootScope.ploegen)
#    $scope.ploegen = [{naam: "Henk"}]
#    personen = angular.copy($rootScope.ploegenBind)
    $scope.newPloeg = {naam: "Henk"}
    $scope.voegToe = () ->
      console.log "ploeg toevoegen"
      ploegenRef.push($scope.newPloeg)
