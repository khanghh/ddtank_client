package AvatarCollection.view{   import AvatarCollection.AvatarCollectionManager;   import AvatarCollection.data.AvatarCollectionUnitVo;   import com.pickgliss.events.ListItemEvent;   import com.pickgliss.geom.IntPoint;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ListPanel;   import com.pickgliss.ui.controls.SelectedButton;   import com.pickgliss.ui.controls.list.IListModel;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SoundManager;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;      public class AvatarCollectionUnitView extends Sprite implements Disposeable   {            public static const SELECTED_CHANGE:String = "avatarCollectionUnitView_selected_change";                   protected var _index:int;            protected var _rightView:AvatarCollectionRightView;            protected var _selectedBtn:SelectedButton;            protected var _bg:DisplayObject;            protected var _list:ListPanel;            private var _dataList:Array;            private var _selectedValue:AvatarCollectionUnitVo;            private var _isFilter:Boolean = false;            private var _isBuyFilter:Boolean = false;            public function AvatarCollectionUnitView(index:int, rightView:AvatarCollectionRightView) { super(); }
            public function set isBuyFilter(value:Boolean) : void { }
            public function set isFilter(value:Boolean) : void { }
            private function initStatus() : void { }
            protected function initView() : void { }
            private function initEvent() : void { }
            private function initData() : void { }
            private function toDoRefresh(event:Event) : void { }
            private function __itemClick(event:ListItemEvent) : void { }
            private function clickHandler(event:MouseEvent) : void { }
            public function extendSelecteTheFirst() : void { }
            private function extendHandler() : void { }
            private function autoSelect() : void { }
            public function unextendHandler() : void { }
            private function refreshList() : void { }
            private function getDataList() : Array { return null; }
            private function getSelectedBtn() : SelectedButton { return null; }
            override public function get height() : Number { return 0; }
            private function removeEvent() : void { }
            public function dispose() : void { }
            public function get list() : ListPanel { return null; }
   }}