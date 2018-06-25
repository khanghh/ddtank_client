package quest{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.quest.QuestCategory;   import ddt.events.TaskEvent;   import ddt.manager.SoundManager;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;      public class QuestCateView extends Sprite implements Disposeable   {            public static var TITLECLICKED:String = "titleClicked";            public static var EXPANDED:String = "expanded";            public static var COLLAPSED:String = "collapsed";            public static const ENABLE_CHANGE:String = "enableChange";                   private const ITEM_HEIGHT:int = 38;            private const LIST_SPACE:int = 0;            private const LIST_PADDING:int = 10;            private var _data:QuestCategory;            private var _titleView:QuestCateTitleView;            private var _listView:ScrollPanel;            private var _itemList:VBox;            private var _itemArr:Array;            private var _scrollPanel:ScrollPanel;            private var _isExpanded:Boolean;            public var questType:int;            public function QuestCateView(cateID:int = -1, scrollPanel:ScrollPanel = null) { super(); }
            override public function get height() : Number { return 0; }
            public function get contentHeight() : int { return 0; }
            public function get length() : int { return 0; }
            public function get data() : QuestCategory { return null; }
            private function initView() : void { }
            public function set taskStyle(style:int) : void { }
            override public function set y(value:Number) : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            public function initData() : void { }
            public function active() : Boolean { return false; }
            private function __onQuestData(e:TaskEvent) : void { }
            private function __onTitleClicked(e:MouseEvent) : void { }
            private function __onListChange(e:Event) : void { }
            public function set dataProvider(value:Array) : void { }
            private function updateView() : void { }
            public function get isExpanded() : Boolean { return false; }
            public function collapse() : void { }
            public function expand() : void { }
            private function set enable(value:Boolean) : void { }
            private function updateData() : void { }
            private function __onItemActived(e:TaskEvent) : void { }
            private function updateTitleView() : void { }
            public function dispose() : void { }
            public function get itemArr() : Array { return null; }
   }}