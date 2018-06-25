package campbattle
{
   import campbattle.data.CampModel;
   import campbattle.data.RoleData;
   import campbattle.event.MapEvent;
   import campbattle.view.rank.CampRankView;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import consortion.rank.RankData;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import gameCommon.model.SmallEnemy;
   import road7th.comm.PackageIn;
   
   public class CampBattleControl extends EventDispatcher
   {
      
      public static const resClassUrl:String = "tank.campBattle.Map-1";
      
      public static const resClassUrl2:String = "tank.campBattle.Map-2";
      
      public static const PVE_MAPRESOURCEURL:String = PathManager.SITE_MAIN + "image/camp/map/campBattlePassage.swf";
      
      public static const PVP_MAPRESOURCEURL:String = PathManager.SITE_MAIN + "image/camp/map/campBattleMap.swf";
      
      private static var _instance:CampBattleControl;
       
      
      private var _model:CampModel;
      
      public function CampBattleControl(target:IEventDispatcher = null)
      {
         super(target);
         _model = new CampModel();
      }
      
      public static function get instance() : CampBattleControl
      {
         if(!_instance)
         {
            _instance = new CampBattleControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         CampBattleManager.instance.addEventListener("campbattle_initscene",__onInitScene);
      }
      
      private function initEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(146,1),__onAddRoleList);
         SocketManager.Instance.addEventListener(PkgEvent.format(146,25),__onOutBattleHander);
         SocketManager.Instance.addEventListener(PkgEvent.format(146,20),__onCampScoreRankHander);
         SocketManager.Instance.addEventListener(PkgEvent.format(146,21),__onPerScoreRankHander);
         SocketManager.Instance.addEventListener(PkgEvent.format(146,3),__onRemoveRoleChange);
         SocketManager.Instance.addEventListener(PkgEvent.format(146,19),__onWinCountHander);
         SocketManager.Instance.addEventListener(PkgEvent.format(146,8),__onPlayerStateChange);
         SocketManager.Instance.addEventListener(PkgEvent.format(146,22),__onUpdateScoreHander);
      }
      
      protected function __onPlayerStateChange(event:PkgEvent) : void
      {
         var zoneID:int = 0;
         var userID:int = 0;
         var type:int = 0;
         var timeCount:int = 0;
         var role:* = null;
         var pkg:PackageIn = event.pkg;
         if(!_model.isFighting)
         {
            zoneID = pkg.readInt();
            userID = pkg.readInt();
            type = pkg.readInt();
            timeCount = pkg.readInt();
            role = getRoleData(zoneID,userID);
            if(role)
            {
               if(timeCount > 0)
               {
                  type = 4;
                  role.stateType = 4;
                  role.isDead = true;
               }
               else
               {
                  role.stateType = type;
               }
            }
            dispatchEvent(new MapEvent("player_state_change",[zoneID,userID,type]));
         }
      }
      
      protected function __onInitScene(event:CEvent) : void
      {
         var i:int = 0;
         var roleData:* = null;
         var j:int = 0;
         var id:int = 0;
         var living:* = null;
         var str:* = null;
         var outPos:* = null;
         var npcid:int = 0;
         var pkg:PackageIn = event.data as PackageIn;
         var mapIndex:int = pkg.readInt();
         _model.monsterCount = pkg.readInt();
         _model.isCapture = pkg.readBoolean();
         if(_model.isCapture)
         {
            _model.captureZoneID = pkg.readInt();
            _model.captureUserID = pkg.readInt();
         }
         else
         {
            _model.captureName = LanguageMgr.GetTranslation("ddt.campBattle.NOcapture");
            _model.captureZoneID = 0;
            _model.captureUserID = 0;
         }
         var count:int = pkg.readInt();
         _model.playerModel.clear();
         for(i = 0; i < count; )
         {
            roleData = new RoleData();
            roleData.ID = pkg.readInt();
            roleData.zoneID = pkg.readInt();
            roleData.Sex = pkg.readBoolean();
            roleData.name = pkg.readUTF();
            roleData.team = pkg.readInt();
            roleData.posX = pkg.readInt();
            roleData.posY = pkg.readInt();
            roleData.stateType = pkg.readInt();
            roleData.timerCount = pkg.readInt();
            roleData.baseURl = PathManager.SITE_MAIN + "image/camp/";
            roleData.isVip = pkg.readBoolean();
            roleData.vipLev = pkg.readInt();
            roleData.MountsType = pkg.readInt();
            if(_model.captureZoneID == roleData.zoneID && _model.captureUserID == roleData.ID)
            {
               roleData.isCapture = true;
               _model.captureName = roleData.name;
               _model.captureTeam = roleData.team;
               if(_model.captureName.length > 50)
               {
                  _model.captureName = _model.captureName.replace(10,"......");
               }
            }
            if(roleData.timerCount > 0)
            {
               roleData.stateType = 4;
               _model.liveTime = roleData.timerCount / 1000;
               roleData.isDead = true;
            }
            if(PlayerManager.Instance.Self.ZoneID == roleData.zoneID && PlayerManager.Instance.Self.ID == roleData.ID)
            {
               _model.myTeam = roleData.team;
               _model.myOutPos = new Point(roleData.posX,roleData.posY);
               if(roleData.timerCount > 0)
               {
                  _model.isShowResurrectView = true;
               }
               roleData.type = 1;
            }
            else
            {
               roleData.type = 2;
            }
            _model.playerModel.add(roleData.zoneID + "_" + roleData.ID,roleData);
            i++;
         }
         var mCount:int = pkg.readInt();
         var index:int = 0;
         _model.monsterList.clear();
         for(j = 0; j < mCount; )
         {
            id = pkg.readInt();
            living = new SmallEnemy(id,2,1000);
            living.typeLiving = 2;
            living.actionMovieName = pkg.readUTF();
            str = pkg.readUTF();
            living.direction = 1;
            outPos = new Point(pkg.readInt(),pkg.readInt());
            living.name = LanguageMgr.GetTranslation("ddt.campleBattle.insectText");
            living.stateType = pkg.readInt();
            npcid = pkg.readInt();
            if(living.stateType != 4)
            {
               _model.monsterList.add(living.LivingID,living);
               if(_model.monsterCount == 10)
               {
                  living.pos = new Point(_model.monsterPosList[index][0],_model.monsterPosList[index][1]);
               }
               else if(npcid > 0)
               {
                  living.pos = outPos;
               }
               else
               {
                  living.pos = new Point(_model.monsterPosList[index][0],_model.monsterPosList[index][1]);
               }
               index++;
            }
            j++;
         }
         _model.myScore = pkg.readInt();
         _model.doorIsOpen = pkg.readBoolean();
         StateManager.setState("campBattleScene",mapIndex,mapIndex);
         initEvent();
      }
      
      private function __onAddRoleList(event:PkgEvent) : void
      {
         var count:int = 0;
         var i:int = 0;
         var roleData:* = null;
         var pkg:PackageIn = event.pkg;
         if(!_model.isFighting)
         {
            count = pkg.readInt();
            for(i = 0; i < count; )
            {
               roleData = new RoleData();
               roleData.ID = pkg.readInt();
               roleData.zoneID = pkg.readInt();
               roleData.Sex = pkg.readBoolean();
               roleData.name = pkg.readUTF();
               roleData.team = pkg.readInt();
               roleData.posX = pkg.readInt();
               roleData.posY = pkg.readInt();
               roleData.stateType = pkg.readInt();
               roleData.timerCount = pkg.readInt();
               roleData.isVip = pkg.readBoolean();
               roleData.vipLev = pkg.readInt();
               roleData.MountsType = pkg.readInt();
               if(roleData.timerCount > 0)
               {
                  roleData.stateType = 4;
               }
               if(roleData.ID == PlayerManager.Instance.Self.ID && PlayerManager.Instance.Self.ZoneID == roleData.zoneID)
               {
                  roleData.type = 1;
               }
               else
               {
                  roleData.type = 2;
               }
               roleData.baseURl = clothPath;
               if(_model.playerModel)
               {
                  _model.playerModel.add(roleData.zoneID + "_" + roleData.ID,roleData);
                  dispatchEvent(new MapEvent("add_role",[roleData.zoneID + "_" + roleData.ID,roleData]));
               }
               i++;
            }
         }
      }
      
      private function __onOutBattleHander(event:PkgEvent) : void
      {
         CampBattleManager.instance.campViewFlag = false;
         StateManager.setState("main");
         removeEvent();
      }
      
      private function __onPerScoreRankHander(event:PkgEvent) : void
      {
         var i:int = 0;
         var obj:* = null;
         var pkg:PackageIn = event.pkg;
         _model.perScoreRankList = [];
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            obj = new RankData();
            obj.ZoneID = pkg.readInt();
            obj.UserID = pkg.readInt();
            obj.ZoneName = pkg.readUTF();
            obj.Name = pkg.readUTF();
            obj.Score = pkg.readInt();
            obj.Rank = i + 1;
            _model.perScoreRankList.push(obj);
            i++;
         }
         rankFrame();
         dispatchEvent(new MapEvent("per_score_rank",_model.perScoreRankList));
      }
      
      private function __onRemoveRoleChange(evt:PkgEvent) : void
      {
         var zoneID:int = 0;
         var userID:int = 0;
         var key:* = null;
         var pkg:PackageIn = evt.pkg;
         if(!_model.isFighting)
         {
            zoneID = pkg.readInt();
            userID = pkg.readInt();
            key = zoneID + "_" + userID;
            if(_model.playerModel)
            {
               _model.playerModel.remove(key);
               dispatchEvent(new MapEvent("remove_role",key));
            }
         }
      }
      
      private function __onWinCountHander(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var winCount:int = pkg.readInt();
         _model.winCount = winCount;
         dispatchEvent(new MapEvent("win_count_pvp"));
      }
      
      public function rankFrame() : void
      {
         var frame:CampRankView = ComponentFactory.Instance.creatComponentByStylename("campBattle.views.CampRankView");
         frame.setList(_model.perScoreRankList);
         LayerManager.Instance.addToLayer(frame,3,true,1);
      }
      
      private function __onCampScoreRankHander(event:PkgEvent) : void
      {
         var i:int = 0;
         var obj:* = null;
         var pkg:PackageIn = event.pkg;
         _model.scoreList = [];
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            obj = {};
            obj.team = pkg.readInt();
            obj.score = pkg.readInt();
            obj.roles = pkg.readInt();
            _model.scoreList.push(obj);
            i++;
         }
         dispatchEvent(new MapEvent("camp_score_rank",_model.scoreList));
      }
      
      private function __onUpdateScoreHander(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var score:int = pkg.readInt();
         _model.myScore = score;
         dispatchEvent(new MapEvent("update_score"));
      }
      
      private function getRoleData(zoneID:int, userID:int) : RoleData
      {
         var key:String = zoneID + "_" + userID;
         var data:RoleData = null;
         if(_model.playerModel)
         {
            data = _model.playerModel[key];
         }
         return data;
      }
      
      private function removeEvent() : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(146,1),__onAddRoleList);
         SocketManager.Instance.removeEventListener(PkgEvent.format(146,25),__onOutBattleHander);
         SocketManager.Instance.removeEventListener(PkgEvent.format(146,20),__onCampScoreRankHander);
         SocketManager.Instance.removeEventListener(PkgEvent.format(146,21),__onPerScoreRankHander);
         SocketManager.Instance.removeEventListener(PkgEvent.format(146,3),__onRemoveRoleChange);
         SocketManager.Instance.removeEventListener(PkgEvent.format(146,19),__onWinCountHander);
         SocketManager.Instance.removeEventListener(PkgEvent.format(146,8),__onPlayerStateChange);
         SocketManager.Instance.removeEventListener(PkgEvent.format(146,22),__onUpdateScoreHander);
      }
      
      public function get model() : CampModel
      {
         return _model;
      }
      
      private function get clothPath() : String
      {
         return PathManager.SITE_MAIN + "image/camp/";
      }
   }
}
