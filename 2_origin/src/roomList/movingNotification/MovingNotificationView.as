package roomList.movingNotification
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.text.TextFormat;
   import flash.utils.Timer;
   
   public class MovingNotificationView extends Sprite
   {
       
      
      private var _list:Array;
      
      private var _mask:Shape;
      
      private var _currentIndex:uint;
      
      private var _currentMovingFFT:FilterFrameText;
      
      private var _textFields:Vector.<FilterFrameText>;
      
      private var _keyWordTF:TextFormat;
      
      private var _timer:Timer;
      
      public function MovingNotificationView()
      {
         _textFields = new Vector.<FilterFrameText>();
         super();
         init();
      }
      
      private function init() : void
      {
         _currentIndex = 0;
         _timer = new Timer(15000);
         scrollRect = ComponentFactory.Instance.creatCustomObject("roomList.MovingNotification.DisplayRect");
         _keyWordTF = ComponentFactory.Instance.model.getSet("roomList.MovingNotificationKeyWordTF");
      }
      
      public function get list() : Array
      {
         return _list;
      }
      
      public function set list(param1:Array) : void
      {
         if(param1 && _list != param1)
         {
            _list = param1;
            updateTextFields();
            updateCurrentTTF();
         }
         if(_list)
         {
            _timer.addEventListener("timer",stopEnterFrame);
            addEventListener("enterFrame",moveFFT);
         }
      }
      
      private function stopEnterFrame(param1:TimerEvent) : void
      {
         _timer.stop();
         addEventListener("enterFrame",moveFFT);
      }
      
      private function clearTextFields() : void
      {
         var _loc1_:FilterFrameText = _textFields.shift();
         while(_loc1_ != null)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = _textFields.shift();
         }
      }
      
      private function updateTextFields() : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         clearTextFields();
         _loc5_ = 0;
         while(_loc5_ < _list.length)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.MovingNotificationText");
            _loc1_ = _list[_loc5_];
            _loc3_ = new Vector.<uint>();
            _loc4_ = new Vector.<uint>();
            while(_loc1_.indexOf("{") > -1)
            {
               _loc3_.push(_loc1_.indexOf("{"));
               _loc4_.push(_loc1_.indexOf("}"));
               _loc1_ = _loc1_.replace("{","");
               _loc1_ = _loc1_.replace("}","");
            }
            _loc2_.text = _loc1_;
            while(_loc3_.length > 0)
            {
               _loc2_.setTextFormat(_keyWordTF,_loc3_.shift(),_loc4_.shift() - 1);
            }
            _textFields.push(_loc2_);
            if(!contains(_loc2_))
            {
               addChildAt(_loc2_,0);
            }
            _loc5_++;
         }
      }
      
      private function updateCurrentTTF() : void
      {
         _currentIndex = Math.round(Math.random() * (_list.length - 1));
         _currentMovingFFT = _textFields[_currentIndex];
      }
      
      private function moveFFT(param1:Event) : void
      {
         if(_currentMovingFFT)
         {
            _currentMovingFFT.y = _currentMovingFFT.y - 1;
            if(_currentMovingFFT.y == 0)
            {
               _timer.start();
               removeEventListener("enterFrame",moveFFT);
            }
            if(_currentMovingFFT.y < -(_currentMovingFFT.textHeight + 2))
            {
               _currentMovingFFT.y = 22;
               updateCurrentTTF();
            }
         }
      }
      
      public function dispose() : void
      {
         removeEventListener("enterFrame",moveFFT);
         _timer.stop();
         clearTextFields();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
