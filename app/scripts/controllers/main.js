'use strict';

angular.module('super2014ausApp')
  .controller('MainCtrl', ['$scope', 'Data', function ($scope, Data) {

    $scope.funds = [];

    Data.$promise.then(function() {

      $scope.render = true;
      $scope.funds = Data.set;

      $scope.sortOneYearReturn = function() {
        Data.sortComparison('2012-2013');
      };

      $scope.sortFiveYearReturn = function() {
        Data.sortComparison('2009-2013');
      };

      $scope.sortTenYearReturn = function() {
        Data.sortComparison('2004-2013');
      };

      $scope.sortAlpha = function() {
        Data.sortName();
      };

      $scope.sortWealthy = function() {
        Data.sortNAVPM();
      };

    });

  }]);
