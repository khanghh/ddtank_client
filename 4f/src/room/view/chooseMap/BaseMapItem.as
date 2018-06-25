package room.view.chooseMap{   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.DisplayLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.map.DungeonInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.MapManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import room.RoomManager;   import room.model.RoomInfo;   import room.model.RoomPlayer;      public class BaseMapItem extends Sprite implements Disposeable   {                   protected var _mapId:int = -1;            protected var _selected:Boolean;            protected var _bg:Bitmap;            protected var _mapIconContaioner:Sprite;            protected var _limitLevel:Sprite;            protected var _limitBg:Bitmap;            protected var _limitLevelText:FilterFrameText;            protected var _selectedBg:Bitmap;            protected var _loader:DisplayLoader;            public function BaseMapItem() { super(); }
            override public function get height() : Number { return 0; }
            override public function get width() : Number { return 0; }
            protected function initView() : void { }
            private function createLitmitSprite() : void { }
            public function setLimitLevel(min:int, max:int) : void { }
            protected function initEvents() : void { }
            protected function removeEvents() : void { }
            protected function updateMapIcon() : void { }
            protected function solvePath() : String { return null; }
            protected function __onComplete(evt:LoaderEvent) : void { }
            protected function updateSelectState() : void { }
            private function __onClick(evt:MouseEvent) : void { }
            public function dispose() : void { }
            public function get selected() : Boolean { return false; }
            public function set selected(value:Boolean) : void { }
            public function get mapId() : int { return 0; }
            public function set mapId(value:int) : void { }
   }}