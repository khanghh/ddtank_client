package gameStarling.chat
{
   import bones.BoneMovieFactory;
   import bones.loader.BonesLoaderEvent;
   import bones.loader.BonesLoaderManager;
   import com.pickgliss.utils.StarlingObjectUtils;
   import flash.geom.Point;
   import times.utils.timerManager.TimerManager;
   
   public class ChatBallPlayer3D2 extends ChatBallBase3D
   {
       
      
      private var _currentPaopaoType:int = 0;
      
      private var _field2:ChatBallTextAreaBuff3D;
      
      public function ChatBallPlayer3D2(){super();}
      
      private function init() : void{}
      
      override protected function get field() : ChatBallTextAreaBase3D{return null;}
      
      override public function setText(param1:String, param2:int = 0) : void{}
      
      private function __onLoaderComplete(param1:BonesLoaderEvent) : void{}
      
      private function waitShow() : void{}
      
      override public function show() : void{}
      
      override public function set width(param1:Number) : void{}
      
      private function newPaopao() : void{}
      
      private function getChatBallName() : String{return null;}
      
      override public function dispose() : void{}
   }
}
