var myApp = angular.module('lendswithfriends', ['ngRoute', 'ngResource']);

// Factories
myApp.factory('Friends', ['$resource', function ($resource) {
  return $resource('/friends.json', {}, {
    query: { method: 'GET', isArray: true },
    create: { method: 'POST' }
  })
}]);

myApp.factory('Friend', ['$resource', function ($resource) {
  return $resource('/friends/:id.json', {}, {
    show: { method: 'GET' },
    update: { method: 'PUT', params: {id: '@id'} },
    delete: { method: 'DELETE', params: {id: '@id'} }
  });
}]);

// Controllers
myApp.controller("FriendListCtr", ['$scope', '$http', '$resource', 'Friends', 'Friend', '$location', function ($scope, $http, $resource, Friends, Friend, $location) {
  $scope.friends = Friends.query();

  $scope.deleteFriend = function (friendId) {
    if (confirm("Are you sure you want to delete this friend?")) {
      Friend.delete({ id: friendId }, function () {
        $scope.friends = Friends.query();
        $location.path('/');
      });
    }
  };
}]);

// Routes
myApp.config([
  '$routeProvider', '$locationProvider', function ($routeProvider, $locationProvider) {
    $routeProvider.when('/friends', {
      templateUrl: '/templates/friends/index.html',
      controller: 'FriendListCtr'
    });
    $routeProvider.when('/friends/new', {
      templateUrl: '/templates/friends/new.html',
      controller: 'FriendAddCtr'
    });
    $routeProvider.when('/friends/:id/edit', {
      templateUrl: '/templates/friends/edit.html',
      controller: "FriendUpdateCtr"
    });
    $routeProvider.otherwise({
      redirectTo: '/friends'
    });
  }
]);
