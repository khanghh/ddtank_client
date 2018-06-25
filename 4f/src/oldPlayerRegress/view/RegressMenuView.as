package oldPlayerRegress.view{   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.UIModuleLoader;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import ddt.data.quest.QuestCategory;   import ddt.events.PkgEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.PathManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import ddt.view.UIModuleSmallLoading;   import flash.display.DisplayObject;   import flash.events.Event;   import flash.events.MouseEvent;   import oldPlayerRegress.view.itemView.AreaView;   import oldPlayerRegress.view.itemView.TaskItemView;   import oldPlayerRegress.view.itemView.WelcomeView;   import oldPlayerRegress.view.itemView.call.CallView;   import oldPlayerRegress.view.itemView.packs.PacksView;   import oldPlayerRegress.view.itemView.task.RegressTaskView;   import quest.QuestInfoPanelView;   import quest.TaskManager;      public class RegressMenuView extends Frame   {            public static var loadComplete:Boolean = false;            public static var useFirst:Boolean = true;                   private const LIST_SPACE:int = -5;            private const TASK_TYPE:int = 4;            private var _bgArray:Array;            private var _menuItemBgSelect:ScaleFrameImage;            private var _textArray:Array;            private var _textNameArray:Array;            private var _btnArray:Array;            private var _viewArray:Array;            private var _taskInfoView:QuestInfoPanelView;            private var _itemList:VBox;            private var _listView:ScrollPanel;            private var _taskData:QuestCategory;            private var _expandBg:DisplayObject;            private var _taskMenuItem:Vector.<TaskItemView>;            private var _ind:int;            public function RegressMenuView() { super(); }
            private function loadTaskUI() : void { }
            private function __onTaskLoadProgress(event:UIModuleEvent) : void { }
            protected function __onClose(event:Event) : void { }
            private function __onTaskLoadComplete(event:UIModuleEvent) : void { }
            private function _init() : void { }
            private function initData() : void { }
            private function initView() : void { }
            private function addTaskListView() : void { }
            private function addListItem() : void { }
            protected function __onUpdateTaskMenuItem(event:Event) : void { }
            private function taskMenuItemClick(clickID:int) : void { }
            private function setTaskMenuBgFrame() : void { }
            private function setItemView(array:Array, styleName:String) : void { }
            private function initEvent() : void { }
            private function __onMenuItemClick(event:MouseEvent) : void { }
            private function menuItemClick(id:int) : void { }
            private function setViewVisible() : void { }
            private function removeEvent() : void { }
            private function removeArray(array:Array) : void { }
            override public function dispose() : void { }
   }}