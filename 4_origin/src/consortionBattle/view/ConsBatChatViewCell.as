package consortionBattle.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class ConsBatChatViewCell extends Sprite implements Disposeable
   {
      
      public static const GUARD_COMPLETE:String = "ConsBatChatViewCell_Guard_Complete";
      
      public static const DISAPPEAR_COMPLETE:String = "ConsBatChatViewCell_Disappear_Complete";
       
      
      private var _txt:FilterFrameText;
      
      private var _isGuard:Boolean;
      
      private var _isActive:Boolean;
      
      private var _timer:TimerJuggler;
      
      private var _existCount:int;
      
      private var _index:int;
      
      public function ConsBatChatViewCell()
      {
         super();
         this.mouseChildren = false;
         this.mouseEnabled = false;
         _txt = ComponentFactory.Instance.creatComponentByStylename("consortiaBattle.chatView.cellTxt");
         addChild(_txt);
         _timer = TimerManager.getInstance().addTimerJuggler(1000);
         _timer.addEventListener("timer",timerHandler,false,0,true);
      }
      
      public function get isGuard() : Boolean
      {
         return _isGuard;
      }
      
      public function get isActive() : Boolean
      {
         return _isActive;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function set index(value:int) : void
      {
         _index = value;
         y = _index * 30;
      }
      
      public function set existCount(value:int) : void
      {
         _existCount = value;
      }
      
      private function timerHandler(event:Event) : void
      {
         _existCount = Number(_existCount) + 1;
         if(_existCount >= 2)
         {
            _isGuard = false;
            dispatchEvent(new Event("ConsBatChatViewCell_Guard_Complete"));
         }
         if(_existCount >= 5)
         {
            _timer.stop();
            TweenLite.to(_txt,0.5,{
               "alpha":0,
               "onComplete":disappearCompleteHandler
            });
         }
      }
      
      private function disappearCompleteHandler() : void
      {
         _isActive = false;
         setText("");
         dispatchEvent(new Event("ConsBatChatViewCell_Disappear_Complete"));
      }
      
      public function setText(value:String, existCount:int = 0) : void
      {
         if(!value || value == "")
         {
            _timer.stop();
            _isGuard = false;
            _isActive = false;
            _txt.text = "";
         }
         else
         {
            TweenLite.killTweensOf(_txt);
            _txt.text = value;
            _txt.alpha = 1;
            _isGuard = true;
            _isActive = true;
            _existCount = existCount;
            _timer.reset();
            _timer.start();
         }
      }
      
      public function dispose() : void
      {
         if(_timer)
         {
            _timer.removeEventListener("timer",timerHandler);
            _timer.stop();
            TimerManager.getInstance().removeJugglerByTimer(_timer);
            _timer = null;
         }
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
