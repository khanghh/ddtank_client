package starling.scene.consortiaDomain{   import bones.BoneMovieFactory;   import bones.display.BoneMovieFastStarling;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.SpriteLayer;   import com.pickgliss.utils.ObjectUtils;   import com.pickgliss.utils.StarlingObjectUtils;   import consortiaDomain.ConsortiaDomainManager;   import consortiaDomain.ConsortiaDomainPlayerVo;   import consortiaDomain.EachBuildInfo;   import ddt.manager.ChatManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.Helpers;   import ddt.view.FaceContainer;   import ddt.view.chat.ChatData;   import ddt.view.chat.ChatEvent;   import ddt.view.chat.chatBall.ChatBallPlayer;   import flash.events.Event;   import hall.player.vo.PlayerVO;   import road7th.StarlingMain;   import starling.display.DisplayObject;   import starling.scene.consortiaDomain.buildView.BuildView;   import starling.scene.consortiaDomain.buildView.RepairAni;   import starling.scene.hall.player.HallPlayer;      public class ConsortiaDomainHallPlayer extends HallPlayer   {                   private var _face:FaceContainer;            private var _fight:BoneMovieFastStarling;            private var _repairAni:RepairAni;            private var _playerView:PlayerView;            private var _chatBallView:ChatBallPlayer;            private var _walkTarget:DisplayObject;            public function ConsortiaDomainHallPlayer(playerVO:PlayerVO) { super(null); }
            private function __getFace(evt:ChatEvent) : void { }
            public function showFightState() : void { }
            public function checkShowRepair() : void { }
            override public function updatePlayer() : void { }
            private function onPlayerViewPosUpdate() : void { }
            private function __getChat(evt:ChatEvent) : void { }
            public function checkAndFightWithMonster() : void { }
            public function checkAndRepairBuild() : void { }
            public function alertUnRepairBuild() : void { }
            private function onUnRepairAlert(e:FrameEvent) : void { }
            public function get consortiaDomainPlayerVo() : ConsortiaDomainPlayerVo { return null; }
            public function get walkTarget() : DisplayObject { return null; }
            public function set walkTarget(value:DisplayObject) : void { }
            private function onGetConsortiaInfoRes(evt:Event) : void { }
            override protected function updatePetsFollow() : void { }
            override public function dispose() : void { }
   }}