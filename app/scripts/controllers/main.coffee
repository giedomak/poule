'use strict'

###*
 # @ngdoc function
 # @name poule2App.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the poule2App
###
angular.module('poule2App')
  .controller 'MainCtrl', ($scope, $rootScope, $firebase) ->
    console.log "MainCtrl init"
    $rootScope.curTab = "main"
    
    $scope.punten = (key) ->
      3
    
