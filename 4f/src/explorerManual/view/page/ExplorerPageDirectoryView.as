package explorerManual.view.page{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.UICreatShortcut;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.CEvent;   import ddt.manager.LanguageMgr;   import explorerManual.ExplorerManualController;   import explorerManual.data.ExplorerManualInfo;   import explorerManual.data.model.ManualPageItemInfo;   import flash.events.Event;   import flash.events.TextEvent;      public class ExplorerPageDirectoryView extends ExplorerPageRightViewBase   {            public static const DIRECTIONRY_TURN:String = "directionryTurn";                   private var _curAllPage:Array;            private var _itemVbox:VBox;            private var _dirTitleTxt:FilterFrameText;            public function ExplorerPageDirectoryView(chapterID:int, model:ExplorerManualInfo, ctrl:ExplorerManualController) { super(null,null,null); }
            override protected function initView() : void { }
            override protected function __modelUpdateHandler(evt:Event) : void { }
            override public function set pageInfo(info:ManualPageItemInfo) : void { }
            public function parentView(view:ExplorerPageView) : void { }
            public function initDirectory(chapter:Array) : void { }
            private function clearVBox() : void { }
            private function itemLinkClick_Handler(evt:TextEvent) : void { }
            private function createDic() : void { }
            private function itemClick_Handler(evt:CEvent) : void { }
            override public function dispose() : void { }
   }}