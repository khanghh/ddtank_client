package starling.scene.consortiaDomain
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieFastStarling;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.SpriteLayer;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StarlingObjectUtils;
   import consortiaDomain.ConsortiaDomainManager;
   import consortiaDomain.ConsortiaDomainPlayerVo;
   import consortiaDomain.EachBuildInfo;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.Helpers;
   import ddt.view.FaceContainer;
   import ddt.view.chat.ChatData;
   import ddt.view.chat.ChatEvent;
   import ddt.view.chat.chatBall.ChatBallPlayer;
   import flash.events.Event;
   import hall.player.vo.PlayerVO;
   import road7th.StarlingMain;
   import starling.display.DisplayObject;
   import starling.scene.consortiaDomain.buildView.BuildView;
   import starling.scene.consortiaDomain.buildView.RepairAni;
   import starling.scene.hall.player.HallPlayer;
   
   public class ConsortiaDomainHallPlayer extends HallPlayer
   {
       
      
      private var _face:FaceContainer;
      
      private var _fight:BoneMovieFastStarling;
      
      private var _repairAni:RepairAni;
      
      private var _playerView:PlayerView;
      
      private var _chatBallView:ChatBallPlayer;
      
      private var _walkTarget:DisplayObject;
      
      public function ConsortiaDomainHallPlayer(param1:PlayerVO)
      {
         super(param1);
         _playerView = ConsortiaDomainScene(StarlingMain.instance.currentScene).playerView;
         ChatManager.Instance.addEventListener("addFace",__getFace);
         ChatManager.Instance.model.addEventListener("addChat",__getChat);
         ConsortiaDomainManager.instance.addEventListener("event_get_consortia_info_res",onGetConsortiaInfoRes);
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
      
      public function showFightState() : void
      {
         if(consortiaDomainPlayerVo.isFight)
         {
            if(!_fight)
            {
               _fight = BoneMovieFactory.instance.creatBoneMovieFast("consortia_domain_bone_fight_state");
               _fight.x = 0;
               _fight.y = -209;
            }
            if(!_fight.parent)
            {
               this.addChild(_fight);
            }
            stopWalk(false);
         }
         else
         {
            _fight && _fight.removeFromParent(false);
         }
      }
      
      public function checkShowRepair() : void
      {
         if(consortiaDomainPlayerVo.repairBuildId > 0)
         {
            if(!_repairAni)
            {
               _repairAni = new RepairAni();
               _repairAni.x = -26;
               _repairAni.y = -209;
            }
            if(!_repairAni.parent)
            {
               this.addChild(_repairAni);
            }
            _repairAni.startRepair();
            stopWalk(false);
         }
         else if(_repairAni)
         {
            _repairAni.stopRepair();
            _repairAni && _repairAni.removeFromParent(false);
         }
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
            _face.y = _playerView.y + this.y - 211;
         }
         if(_chatBallView)
         {
            _chatBallView.x = _playerView.x + this.x - _chatBallView.width / 2 + 50;
            _chatBallView.y = _playerView.y + this.y - 200;
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
      
      public function checkAndFightWithMonster() : void
      {
         var _loc1_:MonsterBone = _walkTarget as MonsterBone;
         if(_loc1_.moveEntityState == 1 || _loc1_.moveEntityState == 3 || _loc1_.moveEntityState == 4)
         {
            if(_loc1_.eachMonsterInfo.FightID <= 0)
            {
               SocketManager.Instance.out.sendConsortiaDomainFight(_loc1_.eachMonsterInfo.LivingID);
            }
         }
      }
      
      public function checkAndRepairBuild() : void
      {
         var _loc1_:* = null;
         var _loc2_:BuildView = _walkTarget as BuildView;
         var _loc3_:int = ConsortiaDomainManager.instance.activeState;
         if(this.consortiaDomainPlayerVo.repairBuildId <= 0 && (_loc3_ == 0 || _loc3_ == 100) && (_loc2_.state == 4 || _loc2_.state == 3))
         {
            _loc1_ = ConsortiaDomainManager.instance.model.allBuildInfo[_loc2_.buildId];
            if(_loc1_ && _loc1_.Repair > 0)
            {
               if(_loc1_.repairPlayerNum >= ConsortiaDomainManager.instance.consortiaLandRepairCount)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("consortiadomain.buildRepair.fullPlayer",ConsortiaDomainManager.instance.buildNameArr[_loc2_.buildId],ConsortiaDomainManager.instance.consortiaLandRepairCount,ConsortiaDomainManager.instance.consortiaLandRepairCount));
               }
               else
               {
                  SocketManager.Instance.out.sendConsortiaDomainRepair(_loc2_.buildId);
               }
            }
         }
      }
      
      public function alertUnRepairBuild() : void
      {
         var _loc3_:Array = ConsortiaDomainManager.instance.buildNameArr;
         var _loc1_:String = _loc3_[consortiaDomainPlayerVo.repairBuildId];
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("consortiadomain.leaveRepairBuildAlert",_loc1_),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
         _loc2_.addEventListener("response",onUnRepairAlert);
      }
      
      private function onUnRepairAlert(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",onUnRepairAlert);
         switch(int(param1.responseCode))
         {
            default:
            default:
            case 2:
            case 3:
               if(consortiaDomainPlayerVo.repairBuildId > 0)
               {
                  SocketManager.Instance.out.sendConsortiaDomainRepair(0);
                  _walkTarget = null;
                  break;
               }
            default:
               if(consortiaDomainPlayerVo.repairBuildId > 0)
               {
                  SocketManager.Instance.out.sendConsortiaDomainRepair(0);
                  _walkTarget = null;
                  break;
               }
         }
         _loc2_.dispose();
      }
      
      public function get consortiaDomainPlayerVo() : ConsortiaDomainPlayerVo
      {
         return playerVO as ConsortiaDomainPlayerVo;
      }
      
      public function get walkTarget() : DisplayObject
      {
         return _walkTarget;
      }
      
      public function set walkTarget(param1:DisplayObject) : void
      {
         _walkTarget = param1;
      }
      
      private function onGetConsortiaInfoRes(param1:Event) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = consortiaDomainPlayerVo.repairBuildId;
         if(_loc3_ > 0)
         {
            _loc2_ = ConsortiaDomainManager.instance.model.allBuildInfo[_loc3_];
            if(_loc2_.Repair == 0)
            {
               consortiaDomainPlayerVo.repairBuildId = 0;
               checkShowRepair();
            }
         }
      }
      
      override protected function updatePetsFollow() : void
      {
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ChatManager.Instance.removeEventListener("addFace",__getFace);
         ChatManager.Instance.model.removeEventListener("addChat",__getChat);
         ConsortiaDomainManager.instance.removeEventListener("event_get_consortia_info_res",onGetConsortiaInfoRes);
         ObjectUtils.disposeObject(_face);
         _face = null;
         StarlingObjectUtils.disposeObject(_fight);
         _fight = null;
         StarlingObjectUtils.disposeObject(_repairAni);
         _repairAni = null;
         ObjectUtils.disposeObject(_chatBallView);
         _playerView = null;
         _chatBallView = null;
         _walkTarget = null;
      }
   }
}
