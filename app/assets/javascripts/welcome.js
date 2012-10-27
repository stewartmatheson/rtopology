function Sites($scope, $http) {
    $http.get('/sites.json').success(function(data){
        $scope.sites = data;
    });
}
