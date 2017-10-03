package 
{
	import flash.events.Event;
	import flash.geom.Point;

	public class Event_SliderMove extends Event
	{
		public static const SLIDER_MOVED:String = "com.events.Event_SliderMove";
		private var m_PercentAlongLength:Number;
		private var m_SliderPosition:Point;
		private var m_Delta:Number;
		
		public function Event_SliderMove(percentDistance:Number, globalPosition:Point, delta:Number)
		{
			super(Event_SliderMove.SLIDER_MOVED);
			m_PercentAlongLength = percentDistance;
			m_SliderPosition = globalPosition;
			m_Delta = delta;
		}
		
		public function get percentDistance():Number
		{
			return m_PercentAlongLength;
		}
		
		public function get sliderPosition():Point
		{
			return m_SliderPosition;
		}
		
		public function get delta():Number
		{
			return m_Delta;
		}
	}
}