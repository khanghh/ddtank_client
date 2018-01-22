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
      
      public function ExplorerPageDirectoryView(param1:int, param2:ExplorerManualInfo, param3:ExplorerManualController)
      {
         super(param1,param2,param3);
      }
      
      override protected function initView() : void
      {
         super.initView();
         UICreatShortcut.creatAndAdd("asset.explorerManual.pageDirectory.titleIcon",this);
         _dirTitleTxt = UICreatShortcut.creatTextAndAdd("explorerManual.pageDicView.chapteTitleTxt",LanguageMgr.GetTranslation("explorerManual.directionyTitle.txt"),this);
         _itemVbox = ComponentFactory.Instance.creatComponentByStylename("explorerManual.pageDirectoryView.itemVBox");
         addChild(_itemVbox);
         _hasPieces.visible = false;
         _piecesPregress.visible = false;
      }
      
      override protected function __modelUpdateHandler(param1:Event) : void
      {
      }
      
      override public function set pageInfo(param1:ManualPageItemInfo) : void
      {
         _pageInfo = param1;
      }
      
      public function parentView(param1:ExplorerPageView) : void
      {
      }
      
      public function initDirectory(param1:Array) : void
      {
         _curAllPage = param1;
         clearVBox();
         createDic();
      }
      
      private function clearVBox() : void
      {
         var _loc1_:* = null;
         if(_itemVbox)
         {
            while(_itemVbox.numChildren > 0)
            {
               _loc1_ = _itemVbox.getChildAt(0) as ExplorerPageDirectorItemView;
               _loc1_.removeEventListener("directorItemClick",itemClick_Handler);
               ObjectUtils.disposeObject(_itemVbox.getChildAt(0));
            }
         }
      }
      
      private function itemLinkClick_Handler(param1:TextEvent) : void
      {
      }
      
      private function createDic() : void
      {
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc1_:int = 0;
         if(_curAllPage == null || _curAllPage.length <= 0)
         {
            return;
         }
         var _loc3_:int = _curAllPage.length;
         _loc1_ = 0;
         while(_loc1_ < _loc3_)
         {
            _loc4_ = _curAllPage[_loc1_];
            if(_loc4_.Sort != 0)
            {
               _loc2_ = new ExplorerPageDirectorItemView(_loc1_,_model);
               _loc2_.info = _curAllPage[_loc1_];
               _loc2_.addEventListener("directorItemClick",itemClick_Handler);
               _itemVbox.addChild(_loc2_);
            }
            _loc1_++;
         }
      }
      
      private function itemClick_Handler(param1:CEvent) : void
      {
         this.dispatchEvent(new CEvent("directionryTurn",param1.data));
      }
      
      override public function dispose() : void
      {
         super.dispose();
         clearVBox();
         _curAllPage = null;
         ObjectUtils.disposeObject(_dirTitleTxt);
         _dirTitleTxt = null;
      }
   }
}
