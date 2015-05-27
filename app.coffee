#Circular Stats
# (numCircles) pages
# Display test in the middle

bg = new BackgroundLayer
	backgroundColor: "#515151"

	
# Circle btns	
numCircles = 6
radius = 300
circleSize = 160
circleCount = 0
circles = []
circlebg = []
tintColor = "#ff5151"
curve = "spring(220, 30, 0, 0.015)"

returnMode = false

#circle
circleLine = new Layer
	width: radius * 2
	height: radius * 2
	borderRadius: "50%"
	shadowColor: "rgba(255,255,255,0.4)"
	shadowSpread: 5
	backgroundColor:"Transparent"
			
circleLine.center()	
# Loop
for index in [0...numCircles] 
	returnMode = true
	
	circle = new Layer
		width: circleSize
		height: circleSize
		midX: radius*Math.cos(index/numCircles*2*Math.PI + 0.5*Math.PI)
		midY: radius*Math.sin(index/numCircles*2*Math.PI + 0.5*Math.PI)
		borderRadius: "50%"
# 		shadowColor: "white"
		backgroundColor:"white"		
	circles.push(circle)
	circlebg.push(circle.backgroundColor)
		
	circle.midX += Screen.width/2
	circle.midY += Screen.height/2
	circle.on Events.TouchEnd, ->
		@colorAnimation = new Animation
			layer: @
			properties: 
				scale: 0.5
				brightness: 10
# 				hueRotate: 180 
			curve: curve
# 			time: 0.1
	
	
		@colorAnimation.start()
		@reverseAnimation = @colorAnimation.reverse()

		if returnMode is false
			returnMode = true
		
			@bringToFront()
						
			for circle in circles
				if @ isnt circle	
					circle.animate
						properties: scale: 0.4, opacity: 0
						curve: curve
						brightness: 100
						time: 0.1
				else
					circle.animate
						properties: scale: 0.4, opacity: 0.2
						curve: curve
						brightness: 100
						time: 0.1			
			
		else if returnMode is true
			returnMode = false
			
			@placeBehind()
				
			@reverseAnimation.start()
				
			for circle in circles
				circle.animate
					properties: scale: 1, opacity: 1
					curve: curve
					time: 0.1
									