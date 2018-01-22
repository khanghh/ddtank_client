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
      
      public function CampBattleControl(param1:IEventDispatcher = null)
      {
         super(param1);
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
      
      protected function __onPlayerStateChange(param1:PkgEvent) : void
      {
         var _loc7_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc4_:PackageIn = param1.pkg;
         if(!_model.isFighting)
         {
            _loc7_ = _loc4_.readInt();
            _loc2_ = _loc4_.readInt();
            _loc6_ = _loc4_.readInt();
            _loc5_ = _loc4_.readInt();
            _loc3_ = getRoleData(_loc7_,_loc2_);
            if(_loc3_)
            {
               if(_loc5_ > 0)
               {
                  _loc6_ = 4;
                  _loc3_.stateType = 4;
                  _loc3_.isDead = true;
               }
               else
               {
                  _loc3_.stateType = _loc6_;
               }
            }
            dispatchEvent(new MapEvent("player_state_change",[_loc7_,_loc2_,_loc6_]));
         }
      }
      
      protected function __onInitScene(param1:CEvent) : void
      {
         var _loc9_:int = 0;
         var _loc11_:* = null;
         var _loc7_:int = 0;
         var _loc10_:int = 0;
         var _loc8_:* = null;
         var _loc13_:* = null;
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc14_:int = _loc6_.readInt();
         _model.monsterCount = _loc6_.readInt();
         _model.isCapture = _loc6_.readBoolean();
         if(_model.isCapture)
         {
            _model.captureZoneID = _loc6_.readInt();
            _model.captureUserID = _loc6_.readInt();
         }
         else
         {
            _model.captureName = LanguageMgr.GetTranslation("ddt.campBattle.NOcapture");
            _model.captureZoneID = 0;
            _model.captureUserID = 0;
         }
         var _loc5_:int = _loc6_.readInt();
         _model.playerModel.clear();
         _loc9_ = 0;
         while(_loc9_ < _loc5_)
         {
            _loc11_ = new RoleData();
            _loc11_.ID = _loc6_.readInt();
            _loc11_.zoneID = _loc6_.readInt();
            _loc11_.Sex = _loc6_.readBoolean();
            _loc11_.name = _loc6_.readUTF();
            _loc11_.team = _loc6_.readInt();
            _loc11_.posX = _loc6_.readInt();
            _loc11_.posY = _loc6_.readInt();
            _loc11_.stateType = _loc6_.readInt();
            _loc11_.timerCount = _loc6_.readInt();
            _loc11_.baseURl = PathManager.SITE_MAIN + "image/camp/";
            _loc11_.isVip = _loc6_.readBoolean();
            _loc11_.vipLev = _loc6_.readInt();
            _loc11_.MountsType = _loc6_.readInt();
            if(_model.captureZoneID == _loc11_.zoneID && _model.captureUserID == _loc11_.ID)
            {
               _loc11_.isCapture = true;
               _model.captureName = _loc11_.name;
               _model.captureTeam = _loc11_.team;
               if(_model.captureName.length > 50)
               {
                  _model.captureName = _model.captureName.replace(10,"......");
               }
            }
            if(_loc11_.timerCount > 0)
            {
               _loc11_.stateType = 4;
               _model.liveTime = _loc11_.timerCount / 1000;
               _loc11_.isDead = true;
            }
            if(PlayerManager.Instance.Self.ZoneID == _loc11_.zoneID && PlayerManager.Instance.Self.ID == _loc11_.ID)
            {
               _model.myTeam = _loc11_.team;
               _model.myOutPos = new Point(_loc11_.posX,_loc11_.posY);
               if(_loc11_.timerCount > 0)
               {
                  _model.isShowResurrectView = true;
               }
               _loc11_.type = 1;
            }
            else
            {
               _loc11_.type = 2;
            }
            _model.playerModel.add(_loc11_.zoneID + "_" + _loc11_.ID,_loc11_);
            _loc9_++;
         }
         var _loc12_:int = _loc6_.readInt();
         var _loc4_:int = 0;
         _model.monsterList.clear();
         _loc7_ = 0;
         while(_loc7_ < _loc12_)
         {
            _loc10_ = _loc6_.readInt();
            _loc8_ = new SmallEnemy(_loc10_,2,1000);
            _loc8_.typeLiving = 2;
            _loc8_.actionMovieName = _loc6_.readUTF();
            _loc13_ = _loc6_.readUTF();
            _loc8_.direction = 1;
            _loc3_ = new Point(_loc6_.readInt(),_loc6_.readInt());
            _loc8_.name = LanguageMgr.GetTranslation("ddt.campleBattle.insectText");
            _loc8_.stateType = _loc6_.readInt();
            _loc2_ = _loc6_.readInt();
            if(_loc8_.stateType != 4)
            {
               _model.monsterList.add(_loc8_.LivingID,_loc8_);
               if(_model.monsterCount == 10)
               {
                  _loc8_.pos = new Point(_model.monsterPosList[_loc4_][0],_model.monsterPosList[_loc4_][1]);
               }
               else if(_loc2_ > 0)
               {
                  _loc8_.pos = _loc3_;
               }
               else
               {
                  _loc8_.pos = new Point(_model.monsterPosList[_loc4_][0],_model.monsterPosList[_loc4_][1]);
               }
               _loc4_++;
            }
            _loc7_++;
         }
         _model.myScore = _loc6_.readInt();
         _model.doorIsOpen = _loc6_.readBoolean();
         StateManager.setState("campBattleScene",_loc14_,_loc14_);
         initEvent();
      }
      
      private function __onAddRoleList(param1:PkgEvent) : void
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc4_:PackageIn = param1.pkg;
         if(!_model.isFighting)
         {
            _loc3_ = _loc4_.readInt();
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc2_ = new RoleData();
               _loc2_.ID = _loc4_.readInt();
               _loc2_.zoneID = _loc4_.readInt();
               _loc2_.Sex = _loc4_.readBoolean();
               _loc2_.name = _loc4_.readUTF();
               _loc2_.team = _loc4_.readInt();
               _loc2_.posX = _loc4_.readInt();
               _loc2_.posY = _loc4_.readInt();
               _loc2_.stateType = _loc4_.readInt();
               _loc2_.timerCount = _loc4_.readInt();
               _loc2_.isVip = _loc4_.readBoolean();
               _loc2_.vipLev = _loc4_.readInt();
               _loc2_.MountsType = _loc4_.readInt();
               if(_loc2_.timerCount > 0)
               {
                  _loc2_.stateType = 4;
               }
               if(_loc2_.ID == PlayerManager.Instance.Self.ID && PlayerManager.Instance.Self.ZoneID == _loc2_.zoneID)
               {
                  _loc2_.type = 1;
               }
               else
               {
                  _loc2_.type = 2;
               }
               _loc2_.baseURl = clothPath;
               if(_model.playerModel)
               {
                  _model.playerModel.add(_loc2_.zoneID + "_" + _loc2_.ID,_loc2_);
                  dispatchEvent(new MapEvent("add_role",[_loc2_.zoneID + "_" + _loc2_.ID,_loc2_]));
               }
               _loc5_++;
            }
         }
      }
      
      private function __onOutBattleHander(param1:PkgEvent) : void
      {
         CampBattleManager.instance.campViewFlag = false;
         StateManager.setState("main");
         removeEvent();
      }
      
      private function __onPerScoreRankHander(param1:PkgEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:PackageIn = param1.pkg;
         _model.perScoreRankList = [];
         var _loc2_:int = _loc3_.readInt();
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc4_ = new RankData();
            _loc4_.ZoneID = _loc3_.readInt();
            _loc4_.UserID = _loc3_.readInt();
            _loc4_.ZoneName = _loc3_.readUTF();
            _loc4_.Name = _loc3_.readUTF();
            _loc4_.Score = _loc3_.readInt();
            _loc4_.Rank = _loc5_ + 1;
            _model.perScoreRankList.push(_loc4_);
            _loc5_++;
         }
         rankFrame();
         dispatchEvent(new MapEvent("per_score_rank",_model.perScoreRankList));
      }
      
      private function __onRemoveRoleChange(param1:PkgEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:* = null;
         var _loc3_:PackageIn = param1.pkg;
         if(!_model.isFighting)
         {
            _loc4_ = _loc3_.readInt();
            _loc2_ = _loc3_.readInt();
            _loc5_ = _loc4_ + "_" + _loc2_;
            if(_model.playerModel)
            {
               _model.playerModel.remove(_loc5_);
               dispatchEvent(new MapEvent("remove_role",_loc5_));
            }
         }
      }
      
      private function __onWinCountHander(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         var _loc3_:int = _loc2_.readInt();
         _model.winCount = _loc3_;
         dispatchEvent(new MapEvent("win_count_pvp"));
      }
      
      public function rankFrame() : void
      {
         var _loc1_:CampRankView = ComponentFactory.Instance.creatComponentByStylename("campBattle.views.CampRankView");
         _loc1_.setList(_model.perScoreRankList);
         LayerManager.Instance.addToLayer(_loc1_,3,true,1);
      }
      
      private function __onCampScoreRankHander(param1:PkgEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:PackageIn = param1.pkg;
         _model.scoreList = [];
         var _loc2_:int = _loc3_.readInt();
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc4_ = {};
            _loc4_.team = _loc3_.readInt();
            _loc4_.score = _loc3_.readInt();
            _loc4_.roles = _loc3_.readInt();
            _model.scoreList.push(_loc4_);
            _loc5_++;
         }
         dispatchEvent(new MapEvent("camp_score_rank",_model.scoreList));
      }
      
      private function __onUpdateScoreHander(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         _model.myScore = _loc2_;
         dispatchEvent(new MapEvent("update_score"));
      }
      
      private function getRoleData(param1:int, param2:int) : RoleData
      {
         var _loc4_:String = param1 + "_" + param2;
         var _loc3_:RoleData = null;
         if(_model.playerModel)
         {
            _loc3_ = _model.playerModel[_loc4_];
         }
         return _loc3_;
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
