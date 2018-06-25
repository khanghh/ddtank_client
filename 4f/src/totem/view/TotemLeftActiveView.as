package totem.view{   import ddt.events.CEvent;   import ddt.manager.PlayerManager;   import ddt.utils.PositionUtils;   import totem.TotemManager;   import totem.data.TotemDataVo;   import totem.mornUI.TotemLeftActiveViewUI;      public class TotemLeftActiveView extends TotemLeftActiveViewUI   {                   private var _windowView:TotemLeftWindowActiveView;            private var _tabIndex:int = -1;            private var _chapterIcon:TotemItemTabView;            public function TotemLeftActiveView() { super(); }
            override protected function createChildren() : void { }
            override protected function initialize() : void { }
            protected function __changeChapterHandler(evt:CEvent) : void { }
            protected function initData() : void { }
            protected function showPage(index:int) : void { }
            public function refreshView(isSuccess:Boolean) : void { }
            private function openSuccessAutoNextPage() : void { }
            override public function dispose() : void { }
   }}