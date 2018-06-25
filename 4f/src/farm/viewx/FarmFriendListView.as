package farm.viewx{   import com.greensock.TweenLite;   import com.greensock.easing.Sine;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ListPanel;   import com.pickgliss.ui.controls.SelectedButtonGroup;   import com.pickgliss.ui.controls.SelectedTextButton;   import com.pickgliss.ui.controls.container.HBox;   import com.pickgliss.ui.controls.list.VectorListModel;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.player.FriendListPlayer;   import ddt.data.player.PlayerInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import farm.FarmEvent;   import farm.FarmModelController;   import farm.modelx.FramFriendStateInfo;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import petsBag.PetsBagManager;   import road7th.data.DictionaryEvent;      public class FarmFriendListView extends Sprite implements Disposeable   {                   private var _list:ListPanel;            private var _switchAsset:ScaleFrameImage;            private var isOpen:Boolean = true;            private var _listBG:Scale9CornerImage;            private var _listBound:ScaleBitmapImage;            private var _hBox:HBox;            private var _poultryBtn:SelectedTextButton;            private var _stealBtn:SelectedTextButton;            private var _selectedButtonGroup:SelectedButtonGroup;            private var _tabBitmap:Bitmap;            private var _switchTween:TweenLite;            public function FarmFriendListView() { super(); }
            private function init() : void { }
            private function initEvent() : void { }
            protected function __onBtnGroupChange(event:Event) : void { }
            protected function __playerRemove(event:DictionaryEvent) : void { }
            protected function __outHandler(event:MouseEvent) : void { }
            protected function __overHandler(event:MouseEvent) : void { }
            protected function __friendlistHandler(event:Event) : void { }
            protected function __infoReady(event:FarmEvent) : void { }
            protected function __updateFriendListStolen(event:FarmEvent) : void { }
            private function __onClick(e:MouseEvent) : void { }
            private function switchView() : void { }
            private function update() : void { }
            private function getInsertIndex(info:PlayerInfo) : int { return 0; }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}