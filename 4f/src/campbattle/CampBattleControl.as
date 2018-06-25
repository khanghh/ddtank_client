package campbattle{   import campbattle.data.CampModel;   import campbattle.data.RoleData;   import campbattle.event.MapEvent;   import campbattle.view.rank.CampRankView;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import consortion.rank.RankData;   import ddt.events.CEvent;   import ddt.events.PkgEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.StateManager;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import flash.geom.Point;   import gameCommon.model.SmallEnemy;   import road7th.comm.PackageIn;      public class CampBattleControl extends EventDispatcher   {            public static const resClassUrl:String = "tank.campBattle.Map-1";            public static const resClassUrl2:String = "tank.campBattle.Map-2";            public static const PVE_MAPRESOURCEURL:String = PathManager.SITE_MAIN + "image/camp/map/campBattlePassage.swf";            public static const PVP_MAPRESOURCEURL:String = PathManager.SITE_MAIN + "image/camp/map/campBattleMap.swf";            private static var _instance:CampBattleControl;                   private var _model:CampModel;            public function CampBattleControl(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : CampBattleControl { return null; }
            public function setup() : void { }
            private function initEvent() : void { }
            protected function __onPlayerStateChange(event:PkgEvent) : void { }
            protected function __onInitScene(event:CEvent) : void { }
            private function __onAddRoleList(event:PkgEvent) : void { }
            private function __onOutBattleHander(event:PkgEvent) : void { }
            private function __onPerScoreRankHander(event:PkgEvent) : void { }
            private function __onRemoveRoleChange(evt:PkgEvent) : void { }
            private function __onWinCountHander(event:PkgEvent) : void { }
            public function rankFrame() : void { }
            private function __onCampScoreRankHander(event:PkgEvent) : void { }
            private function __onUpdateScoreHander(event:PkgEvent) : void { }
            private function getRoleData(zoneID:int, userID:int) : RoleData { return null; }
            private function removeEvent() : void { }
            public function get model() : CampModel { return null; }
            private function get clothPath() : String { return null; }
   }}