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
      
      public function ExplorerPageDirectoryView(chapterID:int, model:ExplorerManualInfo, ctrl:ExplorerManualController)
      {
         super(chapterID,model,ctrl);
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
      
      override protected function __modelUpdateHandler(evt:Event) : void
      {
      }
      
      override public function set pageInfo(info:ManualPageItemInfo) : void
      {
         _pageInfo = info;
      }
      
      public function parentView(view:ExplorerPageView) : void
      {
      }
      
      public function initDirectory(chapter:Array) : void
      {
         _curAllPage = chapter;
         clearVBox();
         createDic();
      }
      
      private function clearVBox() : void
      {
         var temItem:* = null;
         if(_itemVbox)
         {
            while(_itemVbox.numChildren > 0)
            {
               temItem = _itemVbox.getChildAt(0) as ExplorerPageDirectorItemView;
               temItem.removeEventListener("directorItemClick",itemClick_Handler);
               ObjectUtils.disposeObject(_itemVbox.getChildAt(0));
            }
         }
      }
      
      private function itemLinkClick_Handler(evt:TextEvent) : void
      {
      }
      
      private function createDic() : void
      {
         var info:* = null;
         var _itemView:* = null;
         var item:int = 0;
         if(_curAllPage == null || _curAllPage.length <= 0)
         {
            return;
         }
         var itemCount:int = _curAllPage.length;
         for(item = 0; item < itemCount; )
         {
            info = _curAllPage[item];
            if(info.Sort != 0)
            {
               _itemView = new ExplorerPageDirectorItemView(item,_model);
               _itemView.info = _curAllPage[item];
               _itemView.addEventListener("directorItemClick",itemClick_Handler);
               _itemVbox.addChild(_itemView);
            }
            item++;
         }
      }
      
      private function itemClick_Handler(evt:CEvent) : void
      {
         this.dispatchEvent(new CEvent("directionryTurn",evt.data));
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
