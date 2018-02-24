package littleGame.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import ddt.view.FaceContainer;
   import ddt.view.chat.ChatEvent;
   import flash.display.Bitmap;
   import flash.events.Event;
   import littleGame.character.LittleGameCharacter;
   import littleGame.events.LittleLivingEvent;
   import littleGame.model.LittlePlayer;
   
   public class GameLittlePlayer extends GameLittleLiving
   {
       
      
      private var _facecontainer:FaceContainer;
      
      protected var _nameField:PlayerNameField;
      
      private var _defaultBody:Bitmap;
      
      public function GameLittlePlayer(param1:LittlePlayer){super(null);}
      
      override protected function addEvent() : void{}
      
      override protected function removeEvent() : void{}
      
      override public function dispose() : void{}
      
      private function __getFace(param1:ChatEvent) : void{}
      
      private function onFaceComplete(param1:Event) : void{}
      
      private function showFace(param1:int) : void{}
      
      override protected function configUI() : void{}
      
      override protected function createBody() : void{}
      
      private function onComplete(param1:Event) : void{}
      
      override protected function centerBody() : void{}
      
      override protected function __doAction(param1:LittleLivingEvent) : void{}
      
      protected function __headChanged(param1:LittleLivingEvent) : void{}
      
      protected function get player() : LittlePlayer{return null;}
   }
}
