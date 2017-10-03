package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.utils.Utils;
	
	
	public class Document extends MovieClip {
		
		
		public function Document() {
			this.addEventListener(Event.ADDED_TO_STAGE, this.init);
		}
		
		private function init(e:Event)
		{
			Utils.StopAtFrameN(mcInteractivePanel);
		}
	}
	
}
