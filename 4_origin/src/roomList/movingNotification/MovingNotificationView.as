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
      
      public function set list(value:Array) : void
      {
         if(value && _list != value)
         {
            _list = value;
            updateTextFields();
            updateCurrentTTF();
         }
         if(_list)
         {
            _timer.addEventListener("timer",stopEnterFrame);
            addEventListener("enterFrame",moveFFT);
         }
      }
      
      private function stopEnterFrame(event:TimerEvent) : void
      {
         _timer.stop();
         addEventListener("enterFrame",moveFFT);
      }
      
      private function clearTextFields() : void
      {
         var textField:FilterFrameText = _textFields.shift();
         while(textField != null)
         {
            ObjectUtils.disposeObject(textField);
            textField = _textFields.shift();
         }
      }
      
      private function updateTextFields() : void
      {
         var i:int = 0;
         var tf:* = null;
         var str:* = null;
         var left:* = undefined;
         var right:* = undefined;
         clearTextFields();
         for(i = 0; i < _list.length; )
         {
            tf = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.MovingNotificationText");
            str = _list[i];
            left = new Vector.<uint>();
            right = new Vector.<uint>();
            while(str.indexOf("{") > -1)
            {
               left.push(str.indexOf("{"));
               right.push(str.indexOf("}"));
               str = str.replace("{","");
               str = str.replace("}","");
            }
            tf.text = str;
            while(left.length > 0)
            {
               tf.setTextFormat(_keyWordTF,left.shift(),right.shift() - 1);
            }
            _textFields.push(tf);
            if(!contains(tf))
            {
               addChildAt(tf,0);
            }
            i++;
         }
      }
      
      private function updateCurrentTTF() : void
      {
         _currentIndex = Math.round(Math.random() * (_list.length - 1));
         _currentMovingFFT = _textFields[_currentIndex];
      }
      
      private function moveFFT(e:Event) : void
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
