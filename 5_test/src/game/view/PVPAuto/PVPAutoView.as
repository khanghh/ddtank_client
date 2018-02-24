package game.view.PVPAuto
{
	import com.pickgliss.ui.UICreatShortcut;
	import com.pickgliss.ui.core.Disposeable;
	import com.pickgliss.utils.ObjectUtils;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import gameCommon.GameControl;
	import gameCommon.PVPAutoControl;

	public class PVPAutoView extends Sprite implements Disposeable
	{
		private var _heroAutoMovie:MovieClip;
		
		private var _pvpAutoState:Boolean;
		
		private var _autoControl:PVPAutoControl;
		
		public function PVPAutoView()
		{
			_autoControl = new PVPAutoControl();
			init();
			initEvent();
			disableOperation();
		}
		
		private function init() : void
		{
			//_heroAutoMovie = UICreatShortcut.creatAndAdd("game.view.HeroAutoMC",this);
			_pvpAutoState = false;
		}
		
		public function updateWind(param1:int) : void
		{
			if(_autoControl)
			{
				//_autoControl.updateWind(param1);
			}
		}
		
		private function disableOperation() : void
		{
			//GameControl.Instance.Current.selfGamePlayer.rightPropEnabled = false;
		}
		
		private function initEvent() : void
		{
			GameControl.Instance.Current.selfGamePlayer.addEventListener("die",__die);
		}
		
		private function removeEvent() : void
		{
			GameControl.Instance.Current.selfGamePlayer.removeEventListener("die",__die);
		}
		
		protected function __die(param1:Event) : void
		{
			visible = false;
			autoState = false;
			dispose();
		}
		
		public function set autoState(value:Boolean) : void
		{
			if(_pvpAutoState != value)
			{
				_pvpAutoState = value;
				update();
				if(_autoControl)
				{
					//_autoControl.setAutoState(autoState);
				}
			}
		}
		
		public function get autoState() : Boolean
		{
			return _pvpAutoState;
		}
		
		private function update() : void
		{
			if(_heroAutoMovie)
			{
				_heroAutoMovie.visible = _pvpAutoState;
			}
		}
		
		public function dispose() : void
		{
			removeEvent();
			ObjectUtils.disposeObject(_heroAutoMovie);
			_heroAutoMovie = null;
			if(_autoControl)
			{
				//_autoControl.clear();
			}
			_autoControl = null;
			if(parent)
			{
				parent.removeChild(this);
			}
		}
	}
}