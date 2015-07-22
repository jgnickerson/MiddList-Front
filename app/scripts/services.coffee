angular.module('middlistApp').service('postRepository', ->
  currentId = 100

  service = {}

  categories = [
    {name: 'Electronics', id: 1}
    {name: 'Gear', id: 2}
    {name: 'Books', id: 3}
  ]

  allPosts = [
    {
      'author': 'Gordon'
      'title': 'Computer for sale'
      'description': 'Enodivi anatet cikax emadap eyadex te dideto! Rasoci roq titenuk unarerel rer. Cu esutat erapet ieti nalegi. Ito soc mi ce celelo suto rac tine tes vi. Tako epad iena! Uturar ne irul cipu dese cu ci mi. Hed owor umot elirenel? Mie sel gela riere yoso refe iecim epirihet relede larini, nurab rere rib tic doreru. Oteresil nu gevim miterar rososo roc cepehis. Gig tavel iyem niey dow mit tom yolo otimehal meti.'
      'date': new Date(2015, 6, 7, 14, 57)
      postId: 1
      categoryId: 1
    }
    {
      'author': 'Andrew'
      'title': 'Selling my Bike'
      'description': 'Ga katon pienot otanipor onifet? Semofar olier tieminac oresa ese piebiro tezapis oceyi esices. Egeropi cet hido atienomam mecalu uner yepa sag? Enoh yi otoseye danoti milase lamadab nemepieg teh. Elozies niteyav uyabemil les; torowes irasa yad ru nieme te vatahay. Li su catis ura.'
      'date': new Date(2015, 6, 8, 14, 0)
      postId: 2
      categoryId: 2
    }
    {
      'author': 'Reno'
      'title': 'Backpack for sale'
      'description': 'Getelip unad tanecir erosuc noran bic gosanas talel nir tovo. Apo egada wurice awep risoril now botam! Niru ibito sas adim. Pem emipaya biene heta. Camisa eviti aniro donelab nama. Atinihoc uyohe ire curuqit iegosayah. Ha lete ton toliraz eyelaler ti obe hief. Hise nilom ga ceha ca elegehen kakomat osepopem ticano. Rielo lofohis rute higa tor amefira pi lineten! Niroco ru qu cawoceb agiko liehit tureci rizun kanay, duso rosisur mebe iralo raset adolas codon mug beyur.'
      'date': new Date(2015, 6, 9, 15, 30)
      postId: 3
      categoryId: 2
    }
    {
      'author': 'Kelly'
      'title': 'Textbook for sale'
      'description': 'Tehira ro radotes ino neyege uropim lemeg rirene. Etexep novop aveci lotoya inire. Emetetag he olerecec fevehi calabo tohiyol ila tari pa. Gotir liwis hoyo. Yonucos kuba ram soni yot kabog tetini.'
      'date': new Date(2015, 6, 8, 17, 12)
      postId: 4
      categoryId: 3
    }
    {
      'author': 'Tim'
      'title': 'headphones for sale'
      'description': 'dideto! Rasoci roq titenuk unarerel rer. Cu esutat erapet ieti nalegi. Ito soc mi ce celelo suto rac tine tes vi. Tako epad iena! Uturar ne irul cipu dese cu ci mi. Hed owor umot elirenel? Mie sel gela riere yoso refe iecim epirihet relede larini, nurab rere rib tic doreru. Oteresil nu gevim miterar rososo roc cepehis. Gig tavel iyem niey dow mit tom yolo otimehal meti.'
      'date': new Date(2015, 6, 8, 14, 57)
      postId: 5
      categoryId: 1
    }
    {
      'author': 'Dave'
      'title': 'Shirts for sale'
      'description': 'Getelip unad tanecir erosuc noran bic gosanas talel nir tovo. Apo egada wurice awep risoril now botam! Niru ibito sas adim. Pem emipaya biene heta. Camisa eviti aniro donelab nama. Atinihoc uyohe ire curuqit iegosayah. Ha lete ton toliraz eyelaler ti obe hief. Hise nilom ga ceha ca elegehen kakomat osepopem ticano. Rielo lofohis rute higa tor amefira pi lineten! Niroco ru qu cawoceb agiko liehit tureci rizun kanay, duso rosisur mebe iralo raset adolas codon mug beyur.'
      'date': new Date(2015, 6, 9, 15, 30)
      postId: 6
      categoryId: 2
    }
    {
      'author': 'Vlad'
      'title': 'Tolstoy novels for sale'
      'description': 'Getelip unad tanecir erosuc noran bicuropim lemeg rirene. Etexep novop aveci lotoya inire. Emetetag he olerecec fevehi calabo tohiyol ila tari pa. Gotir liwis hoyo. Yonucos kuba ram soni yot kabog tetini.'
      'date': new Date(2015, 6, 8, 17, 12)
      postId: 7
      categoryId: 3
    }
  ]

  service.getAllPosts = ->
    return allPosts

  service.getCategoryPosts = (categoryId) ->
    #return array of only those posts which
    #have matching categoryId
    categoryId = parseInt(categoryId)
    return _.filter(allPosts, (p) -> p.categoryId is categoryId)

  service.getPost = (postId) ->
    postId = parseInt(postId)
    return _.find(allPosts, (p) -> p.postId is postId)

  service.getCategoryObject = (categoryId) ->
    categoryId = parseInt(categoryId)
    if categoryId is 0
      return
    return _.find(categories, (category) -> category.id is categoryId)

  service.getCategories = ->
    categories

  service.addPost = (newPost) ->
    newPost.postId = currentId++
    newPost.date = new Date()
    allPosts.push(newPost)

  service.updatePost = (editedPost) ->
    originalPost = _.find(allPosts, (p) -> p.postId is editedPost.postId)
    service.deletePost(originalPost.postId)
    allPosts.push(editedPost)

  service.deletePost = (postId) ->
    postId = parseInt(postId)
    _.remove(allPosts, (p) -> p.postId is postId)

  service.postIsNew = (post) ->
    return !post.postId?

  return service
)
