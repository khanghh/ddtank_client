package im{   import com.pickgliss.events.ListItemEvent;   import com.pickgliss.geom.IntPoint;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ListPanel;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.MD5;   import ddt.data.player.FriendListPlayer;   import ddt.data.player.PlayerState;   import ddt.events.CEvent;   import ddt.events.PkgEvent;   import ddt.manager.DragManager;   import ddt.manager.IMManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.TimerEvent;   import flash.geom.Matrix;   import flash.geom.Point;   import flash.net.URLLoader;   import flash.net.URLRequest;   import flash.net.URLVariables;   import flash.utils.Timer;   import road7th.comm.PackageIn;   import road7th.data.DictionaryData;   import road7th.data.DictionaryEvent;      public class IMListView extends Sprite implements Disposeable   {                   private var _listPanel:ListPanel;            private var _playerArray:Array;            private var _titleList:Vector.<FriendListPlayer>;            private var _currentItemInfo:FriendListPlayer;            private var _currentTitleInfo:FriendListPlayer;            private var _pos:int;            private var _timer:Timer;            private var _responseR:Sprite;            private var _currentItem:IMListItemView;            public function IMListView() { super(); }
            public function get playerArray() : Array { return null; }
            private function init() : void { }
            private function initEvent() : void { }
            protected function onMarkClick(e:CEvent) : void { }
            protected function __deleteGroup(event:Event) : void { }
            protected function __updaetGroup(event:Event) : void { }
            protected function __addNewGroup(event:Event) : void { }
            private function removeEvent() : void { }
            protected function __addToStage(event:Event) : void { }
            protected function __listItemOutHandler(event:ListItemEvent) : void { }
            protected function __listItemUpHandler(event:ListItemEvent) : void { }
            protected function __listItemDownHandler(event:ListItemEvent) : void { }
            protected function __onRegressCallApply(event:PkgEvent) : void { }
            protected function __onComplete(event:Event) : void { }
            protected function __topRangeHandler(event:Event) : void { }
            protected function __buttomRangeHandler(event:Event) : void { }
            protected function __timerHandler(event:TimerEvent) : void { }
            private function createImg() : DisplayObject { return null; }
            private function initTitle() : void { }
            private function __addBlackItem(event:DictionaryEvent) : void { }
            private function __updateItem(event:DictionaryEvent) : void { }
            private function __addItem(event:DictionaryEvent) : void { }
            private function __removeItem(event:DictionaryEvent) : void { }
            private function getInsertIndex(info:FriendListPlayer) : int { return 0; }
            private function __removeRecentContact(event:DictionaryEvent) : void { }
            private function updateTitle() : void { }
            private function __itemClick(event:ListItemEvent) : void { }
            private function updateList() : void { }
            private function showTitle() : void { }
            private function updateFriendList(relation:int = 0) : void { }
            private function updateBlackList() : void { }
            private function updateRecentContactList() : void { }
            private function sort(arr:Array) : Array { return null; }
            public function dispose() : void { }
            public function get currentItem() : IMListItemView { return null; }
            public function set currentItem(value:IMListItemView) : void { }
   }}