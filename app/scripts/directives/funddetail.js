'use strict';

angular.module('super2014ausApp')
  .directive('fundDetail', function () {
    return {
      scope: { 'fund': '=' },
      templateUrl: '/views/funddetail.html',
      restrict: 'E',
      link: function postLink(scope, element, attrs) {
        scope.open = false;
        scope.toggle = function() {
          scope.open = !scope.open;
        }
      }
    };
  });
