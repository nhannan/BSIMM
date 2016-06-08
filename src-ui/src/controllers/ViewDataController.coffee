angular.module('MM_Graph')
  .controller 'ViewDataController', ($scope, $location, MM_Graph_API)->

    target = $location.search().team

    if target
      $scope.status = 'loading team data'
      $scope.target = target
      MM_Graph_API.file_Get target, (data)->
        $scope.status = 'data loaded'
        $scope.data   = JSON.stringify(data, null, 4)
        console.log JSON.stringify(data, null, 2)
    else
      $scope.status = 'No team provided'

