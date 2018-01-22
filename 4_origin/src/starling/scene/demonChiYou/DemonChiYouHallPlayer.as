package starling.scene.demonChiYou
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.SpriteLayer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import ddt.utils.Helpers;
   import ddt.view.FaceContainer;
   import ddt.view.chat.ChatData;
   import ddt.view.chat.ChatEvent;
   import ddt.view.chat.chatBall.ChatBallPlayer;
   import flash.display.MovieClip;
   import hall.player.vo.PlayerVO;
   import road7th.StarlingMain;
   import starling.scene.hall.player.HallPlayer;
   
   public class DemonChiYouHallPlayer extends HallPlayer
   {
       
      
      private var _face:FaceContainer;
      
      private var _fight:MovieClip;
      
      private var _playerView:PlayerView;
      
      private var _chatBallView:ChatBallPlayer;
      
      public function DemonChiYouHallPlayer(param1:PlayerVO)
      {
         super(param1);
         _playerView = DemonChiYouScene(StarlingMain.instance.currentScene).playerView;
         ChatManager.Instance.addEventListener("addFace",__getFace);
         ChatManager.Instance.model.addEventListener("addChat",__getChat);
      }
      
      private function __getFace(param1:ChatEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:Object = param1.data;
         if(_loc3_["playerid"] == playerVO.playerInfo.ID)
         {
            _loc2_ = LayerManager.Instance.getLayerByType(5);
            if(!_face)
            {
               _face = new FaceContainer(true);
            }
            _loc2_.addChild(_face);
            _face.setFace(_loc3_["faceid"]);
         }
         onPlayerViewPosUpdate();
      }
      
      public function showFightState(param1:Boolean) : void
      {
         var _loc2_:* = null;
         if(param1)
         {
            _loc2_ = LayerManager.Instance.getLayerByType(5);
            if(!_fight)
            {
               _fight = ComponentFactory.Instance.creat("Demonchiyou.fighting");
            }
            _loc2_.addChild(_fight);
            stopWalk();
         }
         else
         {
            if(_fight && _fight.parent)
            {
               _fight.parent.removeChild(_fight);
            }
            startRandomWalk(2,1,{"0_1":[965,1038,1935,1247]});
         }
         onPlayerViewPosUpdate();
      }
      
      override public function updatePlayer() : void
      {
         super.updatePlayer();
         onPlayerViewPosUpdate();
      }
      
      private function onPlayerViewPosUpdate() : void
      {
         if(_face)
         {
            _face.x = _playerView.x + this.x - _face.width / 2 + 40;
            _face.y = _playerView.y + this.y - 90 - 121;
         }
         if(_fight)
         {
            _fight.x = _playerView.x + this.x - _fight.width / 2 + 35;
            _fight.y = _playerView.y + this.y - 150 - 59;
         }
         if(_chatBallView)
         {
            _chatBallView.x = _playerView.x + this.x - _chatBallView.width / 2 + 50;
            _chatBallView.y = _playerView.y + this.y - 135 - 65;
         }
      }
      
      private function __getChat(param1:ChatEvent) : void
      {
         var _loc2_:* = null;
         if(!param1.data)
         {
            return;
         }
         var _loc3_:ChatData = ChatData(param1.data).clone();
         if(!_loc3_)
         {
            return;
         }
         _loc3_.msg = Helpers.deCodeString(_loc3_.msg);
         if(_loc3_.channel == 2 || _loc3_.channel == 3)
         {
            return;
         }
         if(_loc3_ && playerVO.playerInfo && _loc3_.senderID == playerVO.playerInfo.ID)
         {
            if(!_chatBallView)
            {
               _chatBallView = new ChatBallPlayer();
            }
            _loc2_ = LayerManager.Instance.getLayerByType(5);
            _loc2_.addChild(_chatBallView);
            _chatBallView.setText(_loc3_.msg,playerVO.playerInfo.paopaoType);
         }
         onPlayerViewPosUpdate();
      }
      
      override public function dispose() : void
      {
         ChatManager.Instance.removeEventListener("addFace",__getFace);
         ChatManager.Instance.model.removeEventListener("addChat",__getChat);
         ObjectUtils.disposeObject(_face);
         _face = null;
         _fight && _fight.stop();
         ObjectUtils.disposeObject(_fight);
         _fight = null;
         ObjectUtils.disposeObject(_chatBallView);
         _chatBallView = null;
         super.dispose();
      }
   }
}
