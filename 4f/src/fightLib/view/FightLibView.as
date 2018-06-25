package fightLib.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.player.PlayerInfo;   import ddt.manager.PlayerManager;   import flash.display.Bitmap;   import flash.display.Sprite;      public class FightLibView extends Sprite implements Disposeable   {                   private var _bg:Sprite;            private var _title:Bitmap;            private var _playerInfoView:FightLibPlayerInfoView;            private var _lessonsView:LessonsView;            public function FightLibView() { super(); }
            public function dispose() : void { }
            public function startup() : void { }
            public function hideGuide() : void { }
            public function showGuild(count:int) : void { }
            private function configUI() : void { }
   }}