$(document).ready ->
  new AvatarCropper()
  
#$(document).on "page:change", ->
#  new AvatarCropper()

class AvatarCropper
  constructor: (x = 0, y = 0, w = 160, h = 160) ->
    $('#cropbox').Jcrop
      onSelect: @update
      onChange: @update
      aspectRatio: 1
      setSelect: [x, y, w, h]
      
  update: (coords) =>
    $('#user_crop_x').val(coords.x)
    $('#user_crop_y').val(coords.y)
    $('#user_crop_w').val(coords.w)
    $('#user_crop_h').val(coords.h)
    @updatePreview(coords)
    
  updatePreview: (coords) =>
    rx = 160 / coords.w
    ry = 160 / coords.h
    $('#preview').css
      width: Math.round(rx * $('#cropbox').width()) + 'px'
      height: Math.round(ry * $('#cropbox').height()) + 'px'
      marginLeft: '-' + Math.round(rx * coords.x) + 'px'
      marginTop: '-' + Math.round(ry * coords.y) + 'px'
    return
