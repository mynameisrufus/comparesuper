'use strict';

angular.module('super2014ausApp')
  .directive('fundDetail', function () {
    return {
      scope: { 'fund': '=', 'index': '@' },
      templateUrl: '/views/funddetail.html',
      restrict: 'E',
      link: function postLink(scope) {
        scope.open = false;
        scope.toggle = function() {
          scope.open = !scope.open;
        };
        scope.definition = function(type) {
          var url = 'https://www.moneysmart.gov.au/superannuation-and-retirement/how-super-works/choosing-a-super-fund/types-of-super-funds';
          switch(type)
          {
          case 'Retail':
            return url + '#Retail';
          case 'Retail - ERF':
            return url + '#eligiblerollover';
          case 'Corporate':
            return url + '#corporate';
          case 'Industry':
            return url + '#industry';
          case 'Public Sector':
            return url + '#publicsector';
          default:
            return url;
          }
        }
      }
    };
  });
