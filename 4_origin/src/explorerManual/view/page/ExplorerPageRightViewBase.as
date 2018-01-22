package explorerManual.view.page
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import explorerManual.ExplorerManualController;
   import explorerManual.data.ExplorerManualInfo;
   import explorerManual.data.model.ManualPageItemInfo;
   import explorerManual.view.shop.ExplorerManualShop;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ExplorerPageRightViewBase extends Sprite implements Disposeable
   {
       
      
      protected var _hasPieces:Bitmap;
      
      protected var _piecesPregress:FilterFrameText;
      
      protected var _associationBtn:BaseButton;
      
      protected var _model:ExplorerManualInfo;
      
      protected var _ctrl:ExplorerManualController;
      
      protected var _chapterID:int;
      
      protected var _pageInfo:ManualPageItemInfo;
      
      private var _shopFrame:ExplorerManualShop;
      
      public function ExplorerPageRightViewBase(param1:int, param2:ExplorerManualInfo, param3:ExplorerManualController)
      {
         super();
         _model = param2;
         _ctrl = param3;
         _chapterID = param1;
         initView();
         initEvent();
      }
      
      protected function initView() : void
      {
         _hasPieces = ComponentFactory.Instance.creat("asset.explorerManual.pageRightView.hasPiecesTxtIcon");
         addChild(_hasPieces);
         _piecesPregress = ComponentFactory.Instance.creatComponentByStylename("explorerManual.haspiecesPregressTxt");
         addChild(_piecesPregress);
         _associationBtn = ComponentFactory.Instance.creatComponentByStylename("explorerManual.pageRight.associationBtn");
         addChild(_associationBtn);
      }
      
      protected function initEvent() : void
      {
         if(_model)
         {
            _model.addEventListener("manualModelUpdate",__modelUpdateHandler);
         }
         if(_associationBtn)
         {
            _associationBtn.addEventListener("click",__associationClickHandler);
         }
      }
      
      protected function removeEvent() : void
      {
         if(_model)
         {
            _model.removeEventListener("manualModelUpdate",__modelUpdateHandler);
         }
         if(_associationBtn)
         {
            _associationBtn.removeEventListener("click",__associationClickHandler);
         }
      }
      
      private function __associationClickHandler(param1:MouseEvent) : void
      {
         _shopFrame = ComponentFactory.Instance.creat("explorerManual.ExplorerManualShop.Frame",[_ctrl]);
         _shopFrame.show();
      }
      
      protected function __modelUpdateHandler(param1:Event) : void
      {
         updateShowView();
      }
      
      private function getPregressValue(param1:int, param2:int) : String
      {
         var _loc3_:* = null;
         _loc3_ = "<FONT FACE=\'Arial\' SIZE=\'14\' COLOR=\'#FF0000\' ><B>" + param1 + "</B></FONT>" + "/" + param2;
         return _loc3_;
      }
      
      public function set pageInfo(param1:ManualPageItemInfo) : void
      {
         _pageInfo = param1;
         updateShowView();
      }
      
      protected function updateShowView() : void
      {
         piecesPregress();
      }
      
      private function piecesPregress() : void
      {
         var _loc1_:Array = _model.debrisInfo.getHaveDebrisByPageID(_pageInfo.ID);
         _piecesPregress.htmlText = getPregressValue(_loc1_.length,_pageInfo.DebrisCount);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_piecesPregress);
         _piecesPregress = null;
         ObjectUtils.disposeObject(_hasPieces);
         _hasPieces = null;
         ObjectUtils.disposeObject(_associationBtn);
         _associationBtn = null;
         _shopFrame = null;
         _model = null;
         _ctrl = null;
         _pageInfo = null;
      }
   }
}
