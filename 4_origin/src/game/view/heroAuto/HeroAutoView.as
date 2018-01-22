package game.view.heroAuto
{
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import gameCommon.GameControl;
   import gameCommon.HeroAutoControl;
   
   public class HeroAutoView extends Sprite implements Disposeable
   {
       
      
      private var _heroAutoMovie:MovieClip;
      
      private var _heroAutoState:Boolean;
      
      private var _autoControl:HeroAutoControl;
      
      public function HeroAutoView()
      {
         _autoControl = new HeroAutoControl();
         super();
         init();
         initEvent();
         disableOperation();
      }
      
      private function init() : void
      {
         _heroAutoMovie = UICreatShortcut.creatAndAdd("game.view.HeroAutoMC",this);
         _heroAutoState = false;
      }
      
      public function updateWind(param1:int) : void
      {
         if(_autoControl)
         {
            _autoControl.updateWind(param1);
         }
      }
      
      private function disableOperation() : void
      {
         GameControl.Instance.Current.selfGamePlayer.rightPropEnabled = false;
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
      
      public function set autoState(param1:Boolean) : void
      {
         if(_heroAutoState != param1)
         {
            _heroAutoState = param1;
            update();
            if(_autoControl)
            {
               _autoControl.setAutoState(autoState);
            }
         }
      }
      
      public function get autoState() : Boolean
      {
         return _heroAutoState;
      }
      
      private function update() : void
      {
         if(_heroAutoMovie)
         {
            _heroAutoMovie.visible = _heroAutoState;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_heroAutoMovie);
         _heroAutoMovie = null;
         if(_autoControl)
         {
            _autoControl.clear();
         }
         _autoControl = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
