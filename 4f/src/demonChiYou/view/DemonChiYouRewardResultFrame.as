package demonChiYou.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import demonChiYou.DemonChiYouController;
   import demonChiYou.DemonChiYouManager;
   import demonChiYou.DemonChiYouModel;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class DemonChiYouRewardResultFrame extends Frame
   {
       
      
      private var _btnHelp:BaseButton;
      
      private var _resultItemArr:Array;
      
      private var _myGetBagCellHBox:HBox;
      
      private var _buyBtn:BaseButton;
      
      public function DemonChiYouRewardResultFrame(){super();}
      
      private function initView() : void{}
      
      private function updateView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function onClick(param1:MouseEvent) : void{}
      
      private function onBuyItemBack(param1:Event) : void{}
      
      private function onShopInfoBack(param1:Event) : void{}
      
      private function responseHandler(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}
