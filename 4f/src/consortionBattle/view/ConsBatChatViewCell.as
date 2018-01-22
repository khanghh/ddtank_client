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
      
      public function ConsBatChatViewCell(){super();}
      
      public function get isGuard() : Boolean{return false;}
      
      public function get isActive() : Boolean{return false;}
      
      public function get index() : int{return 0;}
      
      public function set index(param1:int) : void{}
      
      public function set existCount(param1:int) : void{}
      
      private function timerHandler(param1:Event) : void{}
      
      private function disappearCompleteHandler() : void{}
      
      public function setText(param1:String, param2:int = 0) : void{}
      
      public function dispose() : void{}
   }
}
