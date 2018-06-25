package trainer.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.player.SelfInfo;   import ddt.manager.PlayerManager;   import ddt.view.character.CharactoryFactory;   import ddt.view.character.ShowCharacter;   import flash.display.Bitmap;   import flash.geom.Point;   import quest.TaskManager;   import trainer.controller.WeakGuildManager;      public class LevelRewardFrame extends BaseAlerFrame   {                   private var _bg:MutipleImage;            private var _playerView:ShowCharacter;            private var _up:MutipleImage;            private var _item1:LevelRewardItem;            public function LevelRewardFrame() { super(); }
            private function initView() : void { }
            private function showLv(lv:int) : void { }
            public function show($level:int) : void { }
            public function hide() : void { }
            public function set level(value:int) : void { }
            override public function dispose() : void { }
   }}