package explorerManual.view.page
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import ddt.manager.LanguageMgr;
   import explorerManual.ExplorerManualController;
   import explorerManual.data.ExplorerManualInfo;
   import explorerManual.data.model.ManualPageItemInfo;
   import flash.events.Event;
   import flash.events.TextEvent;
   
   public class ExplorerPageDirectoryView extends ExplorerPageRightViewBase
   {
      
      public static const DIRECTIONRY_TURN:String = "directionryTurn";
       
      
      private var _curAllPage:Array;
      
      private var _itemVbox:VBox;
      
      private var _dirTitleTxt:FilterFrameText;
      
      public function ExplorerPageDirectoryView(param1:int, param2:ExplorerManualInfo, param3:ExplorerManualController){super(null,null,null);}
      
      override protected function initView() : void{}
      
      override protected function __modelUpdateHandler(param1:Event) : void{}
      
      override public function set pageInfo(param1:ManualPageItemInfo) : void{}
      
      public function parentView(param1:ExplorerPageView) : void{}
      
      public function initDirectory(param1:Array) : void{}
      
      private function clearVBox() : void{}
      
      private function itemLinkClick_Handler(param1:TextEvent) : void{}
      
      private function createDic() : void{}
      
      private function itemClick_Handler(param1:CEvent) : void{}
      
      override public function dispose() : void{}
   }
}
