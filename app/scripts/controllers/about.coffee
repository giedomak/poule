'use strict'

###*
 # @ngdoc function
 # @name poule2App.controller:AboutCtrl
 # @description
 # # AboutCtrl
 # Controller of the poule2App
###
(angular.module('poule2App')
  .controller 'AboutCtrl', ($scope, $firebase) ->
    wedstrijdenRef = new Firebase "https://resplendent-fire-2516.firebaseio.com/wedstrijden"
    $scope.wedstrijden = $firebase wedstrijdenRef
)