package   {
	
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import com.events.Event_SliderMove;
	import com.events.Event_SliderEndpointReached;
	import flash.geom.Orientation3D;
	
	
	public class SliderBar extends EventDispatcher
	{
		public static const SLIDER_ORIENTATION_HORIZONTAL:String = "HORIZONTAL";
		public static const SLIDER_ORIENTATION_VERTICAL:String = "VERTICAL";
		protected var m_Handle:MovieClip;
		protected var m_Background:MovieClip;
		protected var m_Offset:Point;
		protected var m_GlobalBackgroundLeftBound:Point;
		protected var m_GlobalBackgroundRightBound:Point;
		protected var m_GlobalBackgroundUpperBound:Point;
		protected var m_GlobalBackgroundLowerBound:Point;
		protected var m_Orientation:String;
		protected var m_PreviousPoint:Point;
		protected var m_BackgroundBounds:Point;
		
		public function SliderBar(handle:MovieClip, background:MovieClip, horizontal:Boolean = true)
		{
			m_Handle = handle;
			m_Background = background;
		
			
			if(horizontal)
			{
				m_GlobalBackgroundLeftBound = new Point(m_Background.x - m_Background.width / 2, m_Background.y);
				m_GlobalBackgroundRightBound =  new Point(m_Background.x + m_Background.width / 2, m_Background.y);
				m_BackgroundBounds = new Point(background.x - background.width / 2, background.x + background.width /2);
				m_Handle.x = m_GlobalBackgroundLeftBound.x;
				m_Orientation = SliderBar.SLIDER_ORIENTATION_HORIZONTAL;
			}
			else
			{
				m_GlobalBackgroundUpperBound = new Point(m_Background.x, m_Background.y - m_Background.height / 2);
				m_GlobalBackgroundLowerBound = new Point(m_Background.x, m_Background.y + m_Background.height / 2);
				m_BackgroundBounds = new Point(background.y - background.height / 2, background.y + background.height / 2);
				m_Handle.y =  m_GlobalBackgroundLowerBound.y;
				m_Orientation = SliderBar.SLIDER_ORIENTATION_VERTICAL;			}
			
			
			m_Handle.addEventListener(MouseEvent.MOUSE_DOWN, this.eh_MouseDown);
			
		}
		
		protected function eh_MouseDown(e:MouseEvent):void
		{
			trace(e);
			// calculate the offset between the handle zero and the mouse position
			m_Offset = new Point(e.localX, e.localY);
			m_Handle.removeEventListener(MouseEvent.MOUSE_DOWN, this.eh_MouseDown);
			e.target.stage.addEventListener(MouseEvent.MOUSE_UP, this.eh_MouseUp);
			e.target.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.eh_MouseMove);
		}
		
		protected function eh_MouseUp(e:MouseEvent):void
		{
			m_Offset = null;
			m_PreviousPoint = null;
			m_Handle.addEventListener(MouseEvent.MOUSE_DOWN, this.eh_MouseDown);
			e.target.stage.removeEventListener(MouseEvent.MOUSE_UP, this.eh_MouseUp);
			e.target.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.eh_MouseMove);

		}
		
		protected function eh_MouseMove(e:MouseEvent):void
		{
			var globalPoint = new Point(e.stageX, e.stageY);
			var delta:Number = 0;
			// handle delta first
			if(m_PreviousPoint == null)
			{
				m_PreviousPoint = globalPoint;
			}
			else
			{
				if(m_Orientation == SLIDER_ORIENTATION_HORIZONTAL)
				{
					delta = globalPoint.x - m_PreviousPoint.x;
				}
				else
				{
					delta = globalPoint.y - m_PreviousPoint.y;
				}
			}
			
			// this function assumes that the origin of each movie clip is at its center
			
			var distFromEdge:Number;
			
			if(m_Orientation == SliderBar.SLIDER_ORIENTATION_HORIZONTAL)
			{
				if(m_Handle.x + delta < m_BackgroundBounds.x || m_Handle.x + delta > m_BackgroundBounds.y)
				{
					endpointDetected(globalPoint);
				}
				
				else
				{
					m_Handle.x = globalPoint.x - m_Offset.x;
					distFromEdge = m_Handle.x - m_GlobalBackgroundLeftBound.x;
					this.dispatchEvent(new Event_SliderMove(distFromEdge / m_Background.width, globalPoint, delta));
				}
				
				//failsafe
				if(m_Handle.x < m_BackgroundBounds.x)
				{
					m_Handle.x = m_BackgroundBounds.x;
				}
				
				if(m_Handle.x > m_BackgroundBounds.y)
				{
					m_Handle.x = m_BackgroundBounds.y;
				}
			}
			else
			{
				if(m_Handle.y + delta < m_BackgroundBounds.x || m_Handle.y + delta > m_BackgroundBounds.y)
				{
					endpointDetected(globalPoint);
				}
				
				else
				{
					m_Handle.y = globalPoint.y - m_Offset.y;
					distFromEdge = m_Handle.y - m_GlobalBackgroundLowerBound.y;
					this.dispatchEvent(new Event_SliderMove(distFromEdge / m_Background.height, globalPoint, delta));
				}
				
				//failsafe
				if(m_Handle.y < m_BackgroundBounds.x)
				{
					m_Handle.y = m_BackgroundBounds.x;
				}
				
				if(m_Handle.y > m_BackgroundBounds.y)
				{
					m_Handle.y = m_BackgroundBounds.y;
				}
			}
			
			
		}
		
		protected function endpointDetected(point:Point):void
		{
			this.dispatchEvent(new Event_SliderEndpointReached(point));
		}
		
	}
	
}
