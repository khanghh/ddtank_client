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
      
      public function ConsortiaDomainHallPlayer(playerVO:PlayerVO)
      {
         super(playerVO);
         _playerView = ConsortiaDomainScene(StarlingMain.instance.currentScene).playerView;
         ChatManager.Instance.addEventListener("addFace",__getFace);
         ChatManager.Instance.model.addEventListener("addChat",__getChat);
         ConsortiaDomainManager.instance.addEventListener("event_get_consortia_info_res",onGetConsortiaInfoRes);
      }
      
      private function __getFace(evt:ChatEvent) : void
      {
         var senceLayer:* = null;
         var data:Object = evt.data;
         if(data["playerid"] == playerVO.playerInfo.ID)
         {
            senceLayer = LayerManager.Instance.getLayerByType(5);
            if(!_face)
            {
               _face = new FaceContainer(true);
            }
            senceLayer.addChild(_face);
            _face.setFace(data["faceid"]);
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
      
      private function __getChat(evt:ChatEvent) : void
      {
         var senceLayer:* = null;
         if(!evt.data)
         {
            return;
         }
         var data:ChatData = ChatData(evt.data).clone();
         if(!data)
         {
            return;
         }
         data.msg = Helpers.deCodeString(data.msg);
         if(data.channel == 2 || data.channel == 3)
         {
            return;
         }
         if(data && playerVO.playerInfo && data.senderID == playerVO.playerInfo.ID)
         {
            if(!_chatBallView)
            {
               _chatBallView = new ChatBallPlayer();
            }
            senceLayer = LayerManager.Instance.getLayerByType(5);
            senceLayer.addChild(_chatBallView);
            _chatBallView.setText(data.msg,playerVO.playerInfo.paopaoType);
         }
         onPlayerViewPosUpdate();
      }
      
      public function checkAndFightWithMonster() : void
      {
         var target:MonsterBone = _walkTarget as MonsterBone;
         if(target.moveEntityState == 1 || target.moveEntityState == 3 || target.moveEntityState == 4)
         {
            if(target.eachMonsterInfo.FightID <= 0)
            {
               SocketManager.Instance.out.sendConsortiaDomainFight(target.eachMonsterInfo.LivingID);
            }
         }
      }
      
      public function checkAndRepairBuild() : void
      {
         var eachBuildInfo:* = null;
         var target:BuildView = _walkTarget as BuildView;
         var activeState:int = ConsortiaDomainManager.instance.activeState;
         if(this.consortiaDomainPlayerVo.repairBuildId <= 0 && (activeState == 0 || activeState == 100) && (target.state == 4 || target.state == 3))
         {
            eachBuildInfo = ConsortiaDomainManager.instance.model.allBuildInfo[target.buildId];
            if(eachBuildInfo && eachBuildInfo.Repair > 0)
            {
               if(eachBuildInfo.repairPlayerNum >= ConsortiaDomainManager.instance.consortiaLandRepairCount)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("consortiadomain.buildRepair.fullPlayer",ConsortiaDomainManager.instance.buildNameArr[target.buildId],ConsortiaDomainManager.instance.consortiaLandRepairCount,ConsortiaDomainManager.instance.consortiaLandRepairCount));
               }
               else
               {
                  SocketManager.Instance.out.sendConsortiaDomainRepair(target.buildId);
               }
            }
         }
      }
      
      public function alertUnRepairBuild() : void
      {
         var buildNameArr:Array = ConsortiaDomainManager.instance.buildNameArr;
         var buildName:String = buildNameArr[consortiaDomainPlayerVo.repairBuildId];
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("consortiadomain.leaveRepairBuildAlert",buildName),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
         alert.addEventListener("response",onUnRepairAlert);
      }
      
      private function onUnRepairAlert(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",onUnRepairAlert);
         switch(int(e.responseCode))
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
         alert.dispose();
      }
      
      public function get consortiaDomainPlayerVo() : ConsortiaDomainPlayerVo
      {
         return playerVO as ConsortiaDomainPlayerVo;
      }
      
      public function get walkTarget() : DisplayObject
      {
         return _walkTarget;
      }
      
      public function set walkTarget(value:DisplayObject) : void
      {
         _walkTarget = value;
      }
      
      private function onGetConsortiaInfoRes(evt:Event) : void
      {
         var eachBuildInfo:* = null;
         var buildId:int = consortiaDomainPlayerVo.repairBuildId;
         if(buildId > 0)
         {
            eachBuildInfo = ConsortiaDomainManager.instance.model.allBuildInfo[buildId];
            if(eachBuildInfo.Repair == 0)
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
