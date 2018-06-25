package gameStarling.view
{
   import ddt.view.FaceSource;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import gameStarling.objects.GamePlayer3D;
   
   public class FaceContainer3D extends Sprite
   {
       
      
      private var _face:MovieClip;
      
      private var _oldScale:int;
      
      private var _isActingExpression:Boolean;
      
      private var _nickName:TextField;
      
      public var player:GamePlayer3D;
      
      private var _expressionID:int;
      
      public function FaceContainer3D(topLayer:Boolean = false)
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
      
      public function set isShowNickName(value:Boolean) : void
      {
         if(value && _face != null)
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
      
      public function setNickName(str:String) : void
      {
         if(str == null)
         {
            return;
         }
         _nickName.text = str + ":";
         this.addChild(_nickName);
         _nickName.visible = false;
      }
      
      private function init() : void
      {
         var tf:TextFormat = new TextFormat();
         tf.color = "0xff0000";
         _nickName = new TextField();
         _nickName.defaultTextFormat = tf;
      }
      
      private function __timerComplete(evt:TimerEvent) : void
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
      
      public function setFace(id:int) : void
      {
         clearFace();
         _face = FaceSource.getFaceById(id);
         _expressionID = id;
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
      
      private function __enterFrame(event:Event) : void
      {
         if(_face.currentFrame >= _face.totalFrames)
         {
            _isActingExpression = false;
            clearFace();
         }
      }
      
      public function setPos(x:Number, y:Number) : void
      {
         this.x = x + player.pos.x;
         this.y = y + player.pos.y;
      }
      
      public function doClearFace() : void
      {
         _isActingExpression = false;
      }
      
      public function dispose() : void
      {
         clearFace();
         if(parent)
         {
            parent.removeChild(this);
         }
         player = null;
      }
   }
}
