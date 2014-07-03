'use strict'

###*
 # @ngdoc function
 # @name poule2App.controller:AboutCtrl
 # @description
 # # AboutCtrl
 # Controller of the poule2App
###
angular.module('poule2App')
  .controller 'OptiesCtrl', ($scope, $rootScope, $firebase, $routeParams, $filter) ->
    console.log "OptiesCtrl init"
    $rootScope.curTab = "opties"