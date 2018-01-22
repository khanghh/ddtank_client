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
      
      public function GameLittlePlayer(param1:LittlePlayer)
      {
         super(param1);
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
      
      private function __getFace(param1:ChatEvent) : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:Object = param1.data;
         if(_loc3_["playerid"] == player.playerInfo.ID)
         {
            _loc2_ = _loc3_["faceid"];
            _loc4_ = _loc3_["delay"];
            showFace(_loc2_);
         }
      }
      
      private function onFaceComplete(param1:Event) : void
      {
         if(_facecontainer && contains(_facecontainer))
         {
            removeChild(_facecontainer);
         }
      }
      
      private function showFace(param1:int) : void
      {
         if(_facecontainer == null)
         {
            _facecontainer = new FaceContainer();
            _facecontainer.addEventListener("complete",onFaceComplete);
            _facecontainer.y = -100;
         }
         addChild(_facecontainer);
         _facecontainer.scaleX = 1;
         _facecontainer.setFace(param1);
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
         var _loc1_:LittleGameCharacter = new LittleGameCharacter(player.playerInfo);
         _loc1_.soundEnabled = false;
         _loc1_.addEventListener("complete",onComplete);
         _body = addChild(_loc1_);
         if(!_loc1_.isComplete)
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
      
      private function onComplete(param1:Event) : void
      {
         var _loc2_:LittleGameCharacter = param1.currentTarget as LittleGameCharacter;
         _loc2_.removeEventListener("complete",onComplete);
         _loc2_.x = -_loc2_.registerPoint.x;
         _loc2_.y = -_loc2_.registerPoint.y;
         _defaultBody.parent.removeChild(_defaultBody);
         _defaultBody.bitmapData.dispose();
         _defaultBody = null;
         __directionChanged(null);
      }
      
      override protected function centerBody() : void
      {
         var _loc1_:LittleGameCharacter = _body as LittleGameCharacter;
         if(_body && _loc1_)
         {
            _body.x = _body.scaleX == 1?-_loc1_.registerPoint.x:Number(_loc1_.registerPoint.x);
         }
      }
      
      override protected function __doAction(param1:LittleLivingEvent) : void
      {
         if(_body)
         {
            LittleGameCharacter(_body).doAction(_living.currentAction);
         }
      }
      
      protected function __headChanged(param1:LittleLivingEvent) : void
      {
         LittleGameCharacter(_body).setFunnyHead(int(param1.paras[0]));
      }
      
      protected function get player() : LittlePlayer
      {
         return _living as LittlePlayer;
      }
   }
}
