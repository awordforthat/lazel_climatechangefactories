package 
{
	import flash.events.Event;
	import flash.geom.Point;

	public class Event_SliderEndpointReached extends Event
	{
		public static const ENDPOINT_REACHED:String = "com.events.Event_SliderEndpointReached";
		private var endpoint:Point;
		
		public function Event_SliderEndpointReached(globalPoint:Point)
		{
			super(ENDPOINT_REACHED);
			endpoint = globalPoint;
		}
		
		public function get endpointCoordinates():Point
		{
			return endpoint;
		}
	}
}