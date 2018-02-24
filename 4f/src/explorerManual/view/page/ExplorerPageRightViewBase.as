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
      
      public function ExplorerPageRightViewBase(param1:int, param2:ExplorerManualInfo, param3:ExplorerManualController){super();}
      
      protected function initView() : void{}
      
      protected function initEvent() : void{}
      
      protected function removeEvent() : void{}
      
      private function __associationClickHandler(param1:MouseEvent) : void{}
      
      protected function __modelUpdateHandler(param1:Event) : void{}
      
      private function getPregressValue(param1:int, param2:int) : String{return null;}
      
      public function set pageInfo(param1:ManualPageItemInfo) : void{}
      
      protected function updateShowView() : void{}
      
      private function piecesPregress() : void{}
      
      public function dispose() : void{}
   }
}
