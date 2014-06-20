'use strict'

###*
 # @ngdoc function
 # @name poule2App.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the poule2App
###
angular.module('poule2App')
  .controller 'MainCtrl', ($scope, $firebase) ->
    personenRef = new Firebase "https://resplendent-fire-2516.firebaseio.com/personen"
    ploegenRef = new Firebase "https://resplendent-fire-2516.firebaseio.com/ploegen"
    voorspellingenRef = new Firebase "https://resplendent-fire-2516.firebaseio.com/voorspellingen"
    $scope.personen = $firebase personenRef
    
