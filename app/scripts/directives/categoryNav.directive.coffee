angular.module('middlistApp').directive('categoryNav',['postsService', '$routeParams', (postsService, $routeParams) ->
  return (
    scope: {}
    link: (scope) ->
      #used for populating dropdown list
      scope.categories = []
      postsService.getCategories().then((cats) -> scope.categories = cats)


      #used for displaying category name on dropdown button
      scope.currentCat = {}
      categoryId = $routeParams.categoryId
      #need to change the way categoryId mapping works so that a if/else is unnecessary here
      if categoryId is '0'
        scope.currentCat = {name: 'All Posts'}
      else
        postsService.getCategory(categoryId).then((cat) -> scope.currentCat = cat)

    template:"""
      <div class="col-xs-8 col-xs-push-2 btn-group">
        <button type="button" class="btn btn-primary btn-lg">{{currentCat.name}}</button>
        <button id="main-dropdown-toggle" type="button" class="btn btn-primary btn-lg dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <span class="glyphicon glyphicon-triangle-bottom"></span>
          <span class="sr-only">Toggle Dropdown</span>
        </button>
        <ul class="dropdown-menu">
          <li class="dropdown-header">
          <li><a ng-href="#/list">All Posts</a></li>
          <li ng-repeat="cat in categories"><a ng-href="#/list/{{cat.id}}">{{cat.name}}</a></li>
        </ul>
      </div>
    """
  )
])
