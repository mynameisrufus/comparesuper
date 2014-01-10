'use strict';

angular.module('super2014ausApp')
  .service('Data', ['$http', function Data($http) {

    this.set = [];

    var Data = this;

    this.$promise = $http.get('/data/2013.json').then(function(response) {
      Data.set = response.data;
    });

    this.sortComparison = function(comparison) {
      this.sortName().sort(function(a, b) {

        var ra = a.comparisons[comparison].rank,
            rb = b.comparisons[comparison].rank;

        if(ra === null) return 1;
        if(ra < rb) return -1;
        if(ra > rb) return 1;
        return 0;
      });
    };

    this.sortName = function() {
      return this.set.sort(function(a, b) {
        if(a.trustee < b.trustee) return -1;
        if(a.trustee > b.trustee) return 1;
        return 0;
      }).sort(function(a, b) {
        if(a.name < b.name) return -1;
        if(a.name > b.name) return 1;
        return 0;
      });
    };

  }]);
