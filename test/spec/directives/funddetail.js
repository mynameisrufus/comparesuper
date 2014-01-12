'use strict';

describe('Directive: fundDetail', function () {

  // load the directive's module
  beforeEach(module('comparesuperApp'));

  var element,
    scope;

  beforeEach(inject(function ($rootScope) {
    scope = $rootScope.$new();
  }));

  it('should make hidden element visible', inject(function ($compile) {
    element = angular.element('<fund-detail></fund-detail>');
    element = $compile(element)(scope);
    expect(element.text()).toBe('this is the fundDetail directive');
  }));
});
