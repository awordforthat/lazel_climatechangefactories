package 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class SliderBar_ForcedProgress extends SliderBar
	{
		private var m_SliderDirection:int;
				
		
		private static const SLIDER_DIRECTION_POS:int = 1; 
		private static const SLIDER_DIRECTION_NEG:int = -1;
		
		public function SliderBar_ForcedProgress(handle:MovieClip, background:MovieClip, horizontal:Boolean = true, movePositiveFirst:Boolean = true)
		{
			super(handle, background, horizontal);
			
			
		
			// very verbose way of saying move right/up first, or left/down
			if(movePositiveFirst)
			{
				if(horizontal)
				{
					m_SliderDirection = SLIDER_DIRECTION_POS;
				}
				else
				{
					m_SliderDirection = SLIDER_DIRECTION_NEG;
				}

			}
			else // move left/down first
			{
				if(horizontal)
				{
					m_SliderDirection = SLIDER_DIRECTION_NEG;
				}
				else
				{
					m_SliderDirection = SLIDER_DIRECTION_POS;
				}
			}
		}
		
		override protected function eh_MouseUp(e:MouseEvent):void
		{
			super.eh_MouseUp(e);
			
		}
		
		override protected function eh_MouseMove(e:MouseEvent):void
		{
		
			var currentPoint = new Point(e.stageX, e.stageY);
			if(m_PreviousPoint == null)
			{
				m_PreviousPoint = currentPoint;
				return;
			}
			
			if(this.allowMovement(currentPoint))
			{
				super.eh_MouseMove(e);
				m_PreviousPoint = currentPoint;
			}
		}
		
		private function allowMovement(newPoint:Point):Boolean
		{
			// determine if we've moved in the pos or neg direction
			var movementDirection:int;
			
			if(m_Orientation == SLIDER_ORIENTATION_HORIZONTAL)
			{
				if(newPoint.x > m_PreviousPoint.x)
				{
					movementDirection = SLIDER_DIRECTION_POS;
				}
				else
				{
					movementDirection = SLIDER_DIRECTION_NEG;
				}
				
			}
			else
			{
				if(newPoint.y > m_PreviousPoint.y)
				{
					movementDirection = SLIDER_DIRECTION_POS;
				}
				else
				{
					movementDirection = SLIDER_DIRECTION_NEG;
				}
			}
			
			if(movementDirection > 0)
			{
				
				return m_SliderDirection == SLIDER_DIRECTION_POS;
			}
			else
			{
				
				return m_SliderDirection == SLIDER_DIRECTION_NEG;
			}
			
			
		}
		
		override protected function endpointDetected(point:Point):void
		{
			super.endpointDetected(point);
			m_SliderDirection = -m_SliderDirection;
			
		}
	}
	
	
	
	
}