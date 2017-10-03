package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.utils.Utils;
	import flash.events.MouseEvent;
	
	
	public class Document extends MovieClip {
		
		private var m_CurrentState:int;
		private const SECTION_ANIMATION_LENGTH:int = 30;
		private const NUM_STATES:int = 5;
		
		public function Document() {
			this.addEventListener(Event.ADDED_TO_STAGE, this.init);
			this.addEventListener(Event.ENTER_FRAME, this.eh_HandleAnimationControl);
		}
		
		private function init(e:Event)
		{
			Utils.StopAtFrameN(mcInteractivePanel);
			m_CurrentState = 1;
			this.enablePlusButton();
		}
		
		private function eh_HandlePlusClick(e:MouseEvent):void
		{
			var animationFrame = m_CurrentState * SECTION_ANIMATION_LENGTH;
			mcInteractivePanel.gotoAndPlay(animationFrame);
			m_CurrentState = (m_CurrentState + 1) % NUM_STATES;
		}
		
		private function eh_HandleAnimationControl(e:Event)
		{
			if(mcInteractivePanel.currentFrame % SECTION_ANIMATION_LENGTH == 0)
			{
				mcInteractivePanel.stop();
				this.enablePlusButton();
			}
		}
		
		private function disablePlusButton()
		{
			mcInteractivePanel.mcButtonPlus.removeEventListener(MouseEvent.CLICK, this.eh_HandlePlusClick);
			mcInteractivePanel.mcButtonPlus.gotoAndStop(2);
		}
		
		private function enablePlusButton()
		{
			mcInteractivePanel.mcButtonPlus.addEventListener(MouseEvent.CLICK, this.eh_HandlePlusClick);
			mcInteractivePanel.mcButtonPlus.gotoAndStop(1);
		}
		
		
	}
	
}
