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
      
      public function GameLittlePlayer(player:LittlePlayer)
      {
         super(player);
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      override protected function addEvent() : void
      {
         super.addEvent();
         ChatManager.Instance.addEventListener("addFace",__getFace);
         _living.addEventListener("headChanged",__headChanged);
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         ChatManager.Instance.removeEventListener("addFace",__getFace);
         if(_facecontainer)
         {
            _facecontainer.removeEventListener("complete",onFaceComplete);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeObject(_nameField);
         _nameField = null;
         ObjectUtils.disposeObject(_facecontainer);
         _facecontainer = null;
      }
      
      private function __getFace(evt:ChatEvent) : void
      {
         var id:int = 0;
         var delay:int = 0;
         var data:Object = evt.data;
         if(data["playerid"] == player.playerInfo.ID)
         {
            id = data["faceid"];
            delay = data["delay"];
            showFace(id);
         }
      }
      
      private function onFaceComplete(event:Event) : void
      {
         if(_facecontainer && contains(_facecontainer))
         {
            removeChild(_facecontainer);
         }
      }
      
      private function showFace(id:int) : void
      {
         if(_facecontainer == null)
         {
            _facecontainer = new FaceContainer();
            _facecontainer.addEventListener("complete",onFaceComplete);
            _facecontainer.y = -100;
         }
         addChild(_facecontainer);
         _facecontainer.scaleX = 1;
         _facecontainer.setFace(id);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         _nameField = ComponentFactory.Instance.creatCustomObject("littleGame.PlayerName",[player.playerInfo]);
         _nameField.x = -_nameField.width >> 1;
         addChild(_nameField);
      }
      
      override protected function createBody() : void
      {
         var ch:LittleGameCharacter = new LittleGameCharacter(player.playerInfo);
         ch.soundEnabled = false;
         ch.addEventListener("complete",onComplete);
         _body = addChild(ch);
         if(!ch.isComplete)
         {
            _defaultBody = ComponentFactory.Instance.creatBitmap("game.player.defaultPlayerCharacter");
            _defaultBody.x = -33;
            _defaultBody.y = -126;
            addChild(_defaultBody);
         }
         __directionChanged(null);
         if(_living.currentAction)
         {
            LittleGameCharacter(_body).doAction(_living.currentAction);
         }
         else
         {
            LittleGameCharacter(_body).doAction("stand");
         }
      }
      
      private function onComplete(event:Event) : void
      {
         var ch:LittleGameCharacter = event.currentTarget as LittleGameCharacter;
         ch.removeEventListener("complete",onComplete);
         ch.x = -ch.registerPoint.x;
         ch.y = -ch.registerPoint.y;
         _defaultBody.parent.removeChild(_defaultBody);
         _defaultBody.bitmapData.dispose();
         _defaultBody = null;
         __directionChanged(null);
      }
      
      override protected function centerBody() : void
      {
         var ch:LittleGameCharacter = _body as LittleGameCharacter;
         if(_body && ch)
         {
            _body.x = _body.scaleX == 1?-ch.registerPoint.x:Number(ch.registerPoint.x);
         }
      }
      
      override protected function __doAction(event:LittleLivingEvent) : void
      {
         if(_body)
         {
            LittleGameCharacter(_body).doAction(_living.currentAction);
         }
      }
      
      protected function __headChanged(event:LittleLivingEvent) : void
      {
         LittleGameCharacter(_body).setFunnyHead(int(event.paras[0]));
      }
      
      protected function get player() : LittlePlayer
      {
         return _living as LittlePlayer;
      }
   }
}
