package auctionHouse.view
{
   import auctionHouse.event.AuctionHouseEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.auctionHouse.AuctionGoodsInfo;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class AuctionBuyRightView extends Sprite implements Disposeable
   {
       
      
      private var panel:ScrollPanel;
      
      private var _strips:Vector.<AuctionBuyStripView>;
      
      private var _selectStrip:AuctionBuyStripView;
      
      private var _list:VBox;
      
      private var _nameTxt:FilterFrameText;
      
      private var _bidNumberTxt:FilterFrameText;
      
      private var _RemainingTimeTxt:FilterFrameText;
      
      private var _bidpriceTxt:FilterFrameText;
      
      private var _statusTxt:FilterFrameText;
      
      private var _mouthfulTxt:FilterFrameText;
      
      private var _tableline:Bitmap;
      
      private var _tableline1:Bitmap;
      
      private var _tableline2:Bitmap;
      
      private var _tableline3:Bitmap;
      
      private var _tableline4:Bitmap;
      
      private var _tableline5:Bitmap;
      
      private var _talbeline6:Bitmap;
      
      public function AuctionBuyRightView(){super();}
      
      private function initView() : void{}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      function addAuction(param1:AuctionGoodsInfo) : void{}
      
      private function invalidatePanel() : void{}
      
      function clearList() : void{}
      
      private function _clearItems() : void{}
      
      function getSelectInfo() : AuctionGoodsInfo{return null;}
      
      function deleteItem() : void{}
      
      function clearSelectStrip() : void{}
      
      function updateAuction(param1:AuctionGoodsInfo) : void{}
      
      private function __selectStrip(param1:AuctionHouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
