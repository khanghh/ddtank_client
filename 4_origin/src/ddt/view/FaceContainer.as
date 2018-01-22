package ddt.view
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class FaceContainer extends Sprite
   {
       
      
      private var _face:MovieClip;
      
      private var _oldScale:int;
      
      private var _isActingExpression:Boolean;
      
      private var _nickName:TextField;
      
      private var _expressionID:int;
      
      public function FaceContainer(param1:Boolean = false)
      {
         super();
         init();
      }
      
      public function get nickName() : TextField
      {
         return _nickName;
      }
      
      public function get expressionID() : int
      {
         return _expressionID;
      }
      
      public function set isShowNickName(param1:Boolean) : void
      {
         if(param1 && _face != null)
         {
            _nickName.y = _face.y - 20 - _face.height / 2;
            _nickName.x = -_face.width / 2;
            _nickName.visible = true;
         }
         else
         {
            _nickName.y = 0;
            _nickName.x = 0;
            _nickName.visible = false;
         }
      }
      
      public function get isActingExpression() : Boolean
      {
         return _isActingExpression;
      }
      
      public function setNickName(param1:String) : void
      {
         if(param1 == null)
         {
            return;
         }
         _nickName.text = param1 + ":";
         this.addChild(_nickName);
         _nickName.visible = false;
      }
      
      private function init() : void
      {
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.color = "0xff0000";
         _nickName = new TextField();
         _nickName.defaultTextFormat = _loc1_;
      }
      
      private function __timerComplete(param1:TimerEvent) : void
      {
         clearFace();
         dispatchEvent(new Event("complete"));
      }
      
      public function clearFace() : void
      {
         if(_face != null)
         {
            if(_face.parent)
            {
               _face.stop();
               _face.parent.removeChild(_face);
            }
            _face.removeEventListener("enterFrame",__enterFrame);
            _face = null;
            _nickName.visible = false;
         }
      }
      
      public function setFace(param1:int) : void
      {
         clearFace();
         _face = FaceSource.getFaceById(param1);
         _expressionID = param1;
         if(_face != null)
         {
            _isActingExpression = true;
            var _loc2_:int = 1;
            this.scaleX = _loc2_;
            _face.scaleX = _loc2_;
            _face.addEventListener("enterFrame",__enterFrame);
            addChild(_face);
         }
      }
      
      public function doClearFace() : void
      {
         _isActingExpression = false;
         clearFace();
      }
      
      private function __enterFrame(param1:Event) : void
      {
         if(_face.currentFrame >= _face.totalFrames)
         {
            _isActingExpression = false;
            clearFace();
         }
      }
      
      public function dispose() : void
      {
         clearFace();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
