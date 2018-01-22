package gypsyShop.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import gypsyShop.ctrl.GypsyShopManager;
   import gypsyShop.model.GypsyShopModel;
   import gypsyShop.ui.GypsyItemCell;
   
   public class GypsyShopMainFrame extends Frame implements Disposeable
   {
       
      
      private var _model:GypsyShopModel;
      
      private var _bg:Bitmap;
      
      private var _rareTitle:Bitmap;
      
      private var _coolShiningMCList:Vector.<MovieClip>;
      
      private var _rareList:Vector.<BagCell>;
      
      private var _itemList:Vector.<GypsyItemCell>;
      
      private var _rmbTicketsIcon:Bitmap;
      
      private var _honourIcon:Bitmap;
      
      private var _ticketsBG:Bitmap;
      
      private var _honourBG:Bitmap;
      
      private var _rmbTicketsText:FilterFrameText;
      
      private var _honourText:FilterFrameText;
      
      private var _refreshTimeDetails:FilterFrameText;
      
      private var _refreshBtn:BaseButton;
      
      private var _helpBtn:SimpleBitmapButton;
      
      public function GypsyShopMainFrame(){super();}
      
      public function setModel(param1:GypsyShopModel) : void{}
      
      override protected function init() : void{}
      
      private function frameEvent(param1:FrameEvent) : void{}
      
      public function updateNewItemList() : void{}
      
      public function updateBuyResult() : void{}
      
      public function updateRareItemsList() : void{}
      
      private function updateWealth() : void{}
      
      private function _response(param1:FrameEvent) : void{}
      
      private function close() : void{}
      
      protected function onClick(param1:MouseEvent) : void{}
      
      protected function onHelp(param1:MouseEvent) : void{}
      
      override public function dispose() : void{}
   }
}
