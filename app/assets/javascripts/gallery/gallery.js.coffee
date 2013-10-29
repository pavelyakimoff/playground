# заняться улучшением этого кода - пофиксить баги, добавить фичи

class window.Gallery

  speed: 200
  move_speed: 400
  preload: true
  current_page: 0
  reversed: false

  constructor: (element) ->
    @element = $(element)
    @items = @element.find('.item')

    if @items.length
      @control_mini = @element.find('.control_mini')
      @control = @element.find('.control, .control-placeholder')
      @next = @element.find('.control_next')
      @prev = @element.find('.control_prev')
      @announce_toggler = @element.find('.announce-toggler')
      @announce = @element.find('.announce')
      @announce_hidder = @announce.find('.toggler')
      @frame = @element.find('.photo')
      @viewport = @element.find('.items')
      @image = @element.find('.image')
      @counter = @element.find('.count')
      @current_counter = @element.find('.count .current')
      @caption = @element.find('.description .caption')
      @credits = @element.find('.description .credits')
      @text = $('#text')
      @count = @items.length
      @number_of_pages = Math.ceil @count/8

      # Если галерея размером в одну картинку (магнум к примеру)
      @element.addClass('b-topic_gallery_single') if 1 == @count

      # обработчики/events
      @control.on 'click', $.proxy(@move, @)
      @control_mini.on 'click', $.proxy(@move_section, @)
      @items.on 'click', $.proxy(@set_picture, @)

      if '' != document.location.hash
        index = parseInt(document.location.hash.substr(1), 10)
        index = 0 if isNaN(index) || index > @count-1

      index ||= 0
      @set_picture(index, true) 

      $(document).on 'keyup', (e) =>
        switch e.keyCode
          when 39
            @next.transition opacity: 1, @move_speed, =>
              @next.transition opacity: 0
            @move_next()

          when 37
            @prev.transition opacity: 1, @move_speed, =>
              @prev.transition opacity: 0
            @move_prev()

      @announce_toggler.on 'click', (e) =>
        @announce.fadeToggle(@speed * 2)
        @announce_toggler.toggleClass('gallery_description_hover')

      @announce_hidder.on 'click', (e) =>
        @announce.fadeOut(@speed * 2)
        @announce_toggler.removeClass('gallery_description_hover')

  preload_siblings: (index) ->   
    if @count < 4
      @items.each  ->
        img = new Image
        img.src = $(this).data('image').url
    else 
      if index is @count-1 or index is 0
        indexes = [-1,0,1]
      else
        indexes = [index-1, index, index+1]

      for index in indexes
        do (index) =>
          img = new Image
          img.src = @items.eq(index-1).data('image').url 

  set_picture: (e, force = false) ->
    target = $(e.target) if e.target?
    if target?
      new_index = target.data('index')
    else
      new_index = e

    @preload_siblings(new_index) if @preload

    if @current != new_index
      @items.eq(@current).removeClass('active')
      new_item = @items.eq(new_index)
      new_item.addClass('active')
      data = new_item.data('image')
      if force then speed = 0 else speed = @speed

      @image.transition opacity: 0, speed, =>
        @image[0].onload = => @image.transition opacity: 1, speed
        @image.attr('src', data.url)
        @image.width(data.width)
        @image.height(data.height)
        @image.css('margin-top', (@frame.height() - data.height)/2)

        if data.alt?
          @text.show().html(data.alt)
        else
          @text.hide()
        if data.credits? then @credits.show().html(data.credits) else @credits.hide()
        if data.caption? 
          @caption.show().html(data.caption)
          @image.attr('alt', data.caption)
        else
          @caption.hide()
          @image.attr('alt', '')

      @current = new_index
      document.location.hash = new_index
      @update_count()
      if @reversed
        correction = (@number_of_pages * 8) - @count
        @set_page(Math.floor((@current + correction)/8), force)
      else 
        @set_page(Math.floor(@current/8), force)

  set_page: (page, force = false) ->
    if force then speed = 0 else speed = @move_speed
    viewport_item_width = @items.eq(0).width() + 15
    page = 0 if page == @number_of_pages && @current_page == @number_of_pages - 1
    page = @number_of_pages - 1 if page == @number_of_pages && @current_page == 0
    position = page * (viewport_item_width * 8)
    correction = 0
    
    if @number_of_pages > 1      
      if @number_of_pages == (page + 1)
        correction = viewport_item_width * ((@number_of_pages * 8) - @count)
        @reversed = true
      if page == 0
        @reversed = false
        
    correction = viewport_item_width * ((@number_of_pages * 8) - @count) if @reversed
     
    @viewport.transition left: (-1 * position) + correction, speed
    @current_page = page

  update_count: ->
    @current_counter.text(@current + 1)

  move_next: ->
    if @current + 1 > @count - 1 then new_current = 0 else new_current = @current + 1
    @set_picture(new_current)

  move_prev: ->
    if @current - 1 < 0 then new_current = @count-1 else new_current = @current - 1
    @set_picture(new_current)

  move: (e) ->
    e.stopPropagation()
    target = $(e.target)
    if target.hasClass('control_prev') ||  target.hasClass('control-placeholder_left')
      @move_prev()
    else
      @move_next()

  move_section: (e) ->
    target = $(e.target)
    if target.hasClass('control_prev_mini')
      if @current_page - 1 < 0  then new_page = Math.floor(@count/8) else new_page = @current_page - 1
      @set_page(new_page)
    else
      if @current_page + 1 > Math.floor(@count/8) then new_page = 0 else new_page = @current_page + 1
      @set_page(new_page)
      
