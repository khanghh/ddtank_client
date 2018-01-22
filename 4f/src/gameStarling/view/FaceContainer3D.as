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
      
      public function FaceContainer3D(param1:Boolean = false){super();}
      
      public function get nickName() : TextField{return null;}
      
      public function get expressionID() : int{return 0;}
      
      public function set isShowNickName(param1:Boolean) : void{}
      
      public function get isActingExpression() : Boolean{return false;}
      
      public function setNickName(param1:String) : void{}
      
      private function init() : void{}
      
      private function __timerComplete(param1:TimerEvent) : void{}
      
      public function clearFace() : void{}
      
      public function setFace(param1:int) : void{}
      
      private function __enterFrame(param1:Event) : void{}
      
      public function setPos(param1:Number, param2:Number) : void{}
      
      public function doClearFace() : void{}
      
      public function dispose() : void{}
   }
}
