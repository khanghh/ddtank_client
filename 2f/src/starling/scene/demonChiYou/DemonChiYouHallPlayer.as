package starling.scene.demonChiYou{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.core.SpriteLayer;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.ChatManager;   import ddt.utils.Helpers;   import ddt.view.FaceContainer;   import ddt.view.chat.ChatData;   import ddt.view.chat.ChatEvent;   import ddt.view.chat.chatBall.ChatBallPlayer;   import flash.display.MovieClip;   import hall.player.vo.PlayerVO;   import road7th.StarlingMain;   import starling.scene.hall.player.HallPlayer;      public class DemonChiYouHallPlayer extends HallPlayer   {                   private var _face:FaceContainer;            private var _fight:MovieClip;            private var _playerView:PlayerView;            private var _chatBallView:ChatBallPlayer;            public function DemonChiYouHallPlayer(playerVO:PlayerVO) { super(null); }
            private function __getFace(evt:ChatEvent) : void { }
            public function showFightState(isFight:Boolean) : void { }
            override public function updatePlayer() : void { }
            private function onPlayerViewPosUpdate() : void { }
            private function __getChat(evt:ChatEvent) : void { }
            override public function dispose() : void { }
   }}