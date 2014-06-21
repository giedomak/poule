'use strict'

###*
 # @ngdoc function
 # @name poule2App.controller:AboutCtrl
 # @description
 # # AboutCtrl
 # Controller of the poule2App
###
(angular.module('poule2App')
  .controller 'AboutCtrl', ($scope, $rootScope, $firebase) ->
    ploegenRef = new Firebase "https://resplendent-fire-2516.firebaseio.com/ploegen"
    $firebase(ploegenRef).$bind($rootScope,"ploegen")
#    $scope.ploegen = [{naam: "Henk"}] #test
#    personen = angular.copy($rootScope.ploegenBind)
    $scope.ploeg1 = {}
    $scope.voegToe = (ploeg) ->
      $rootScope.ploegen.push(ploeg)
)