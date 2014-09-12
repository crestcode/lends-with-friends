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

myApp.controller("FriendAddCtr", ['$scope', '$resource', 'Friends', '$location', function ($scope, $resource, Friends, $location) {
  $scope.friend = {loan: [{item: ''}]}
  $scope.save = function () {
    if ($scope.friendForm.$valid) {
      Friends.create({friend: $scope.friend}, function () {
        $location.path('/');
      }, function (error) {
        console.log(error)
      });
    }
  };
}]);

myApp.controller("FriendUpdateCtr", ['$scope', '$resource', 'Friend', '$location', '$routeParams', function($scope, $resource, Friend, $location, $routeParams) {
  $scope.friend = Friend.get({id: $routeParams.id})
  $scope.update = function(){
    if ($scope.friendForm.$valid){
      Friend.update({id: $scope.friend.id},{friend: $scope.friend},function(){
        $location.path('/');
      }, function(error) {
        console.log(error)
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
