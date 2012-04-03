###
(c) 2011 Stephane Alnet
###
$(document).ready ->

  width = 327
  height = 421
  actual_width = 3*width

  initial_hue = 160
  hue_increments = 20
  max_hue = 360
  saturation = 90
  brightness = 100
  radius_to_radius = 1.25
  angle_1 = -1
  angle_2 = +1

  sketch = (p) ->

    n_bubbles = 31

    bubbles = []
    hue = initial_hue

    new_bubble = ->
      if bubbles.length > n_bubbles
        bubbles.pop()
      bubbles.unshift
        color: p.color hue, saturation, brightness
        angle: if Math.random() < 0.5 then angle_1 else angle_2

      hue += hue_increments
      hue -= max_hue while hue >= max_hue

    white = p.color 0, 0, 100, 1.0

    p.setup = ->
      p.size actual_width, height
      p.colorMode(p.HSB,max_hue,100,100,1.0)
      p.ellipseMode p.RADIUS
      p.noStroke()

    initial_radius = 0.1

    p.draw = ->
      p.background white

      x = width / 2.0
      radius = initial_radius
      y = height - radius
      for bubble in bubbles
        if bubble
          p.fill bubble.color
          bubble_radius = radius
          p.ellipse x, y, bubble_radius, bubble_radius

          radius *= radius_to_radius
          x += bubble.angle * (bubble_radius+radius)
          y -= radius

      initial_radius += 0.01
      if initial_radius >= radius_to_radius*0.1
        new_bubble()
        initial_radius = 0.1
      return

  $('#code').each ->
    p = new Processing(@,sketch)