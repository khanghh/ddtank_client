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
      
      public function AuctionBuyRightView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("asset.auctionHouse.BuyBG");
         addChild(_loc1_);
         var _loc2_:MovieImage = ComponentFactory.Instance.creatComponentByStylename("ddtauction.sellItemBG5");
         addChild(_loc2_);
         _talbeline6 = ComponentFactory.Instance.creatBitmap("asset.ddtcore.TwotableLine");
         PositionUtils.setPos(_talbeline6,"asset.ddtauction.TwotableLine.pos");
         addChild(_talbeline6);
         _talbeline6.width = 938;
         _nameTxt = ComponentFactory.Instance.creat("ddtauction.nameTxt");
         _nameTxt.text = LanguageMgr.GetTranslation("tank.ddtauctionHouse.text.name");
         addChild(_nameTxt);
         _bidNumberTxt = ComponentFactory.Instance.creat("ddtauction.bidNumerTxt");
         _bidNumberTxt.text = LanguageMgr.GetTranslation("tank.ddtauctionHouse.text.number");
         addChild(_bidNumberTxt);
         _bidNumberTxt.x = 275;
         _RemainingTimeTxt = ComponentFactory.Instance.creat("ddtauction.remainingTimeTxt");
         _RemainingTimeTxt.text = LanguageMgr.GetTranslation("tank.ddtauctionHouse.text.timer");
         addChild(_RemainingTimeTxt);
         _RemainingTimeTxt.x = 384;
         _bidpriceTxt = ComponentFactory.Instance.creat("ddtauction.BidPriceTxt");
         _bidpriceTxt.text = LanguageMgr.GetTranslation("tank.ddtauctionHouse.text.price");
         addChild(_bidpriceTxt);
         _bidpriceTxt.x = 807;
         _statusTxt = ComponentFactory.Instance.creat("ddtauction.statusTxt");
         _statusTxt.text = LanguageMgr.GetTranslation("tank.ddtauctionHouse.text.status");
         addChild(_statusTxt);
         _statusTxt.x = 622;
         _mouthfulTxt = ComponentFactory.Instance.creat("ddtauction.mouthfulTxt");
         _mouthfulTxt.text = LanguageMgr.GetTranslation("tank.ddtauctionHouse.view.mouthful");
         addChild(_mouthfulTxt);
         _mouthfulTxt.x = 522;
         _tableline = ComponentFactory.Instance.creatBitmap("asset.ddtauction.tableLine");
         addChild(_tableline);
         _tableline.x = 279;
         _tableline1 = ComponentFactory.Instance.creatBitmap("asset.ddtauction.tableLine");
         addChild(_tableline1);
         _tableline1.x = 339;
         _tableline2 = ComponentFactory.Instance.creatBitmap("asset.ddtauction.tableLine");
         addChild(_tableline2);
         _tableline2.x = 501;
         _tableline3 = ComponentFactory.Instance.creatBitmap("asset.ddtauction.tableLine");
         addChild(_tableline3);
         _tableline3.x = 606;
         _tableline4 = ComponentFactory.Instance.creatBitmap("asset.ddtauction.tableLine");
         addChild(_tableline4);
         _tableline4.x = 739;
         _list = new VBox();
         _strips = new Vector.<AuctionBuyStripView>();
         panel = ComponentFactory.Instance.creat("auctionHouse.BrowseBuyScrollpanel");
         panel.hScrollProxy = 2;
         panel.setView(_list);
         addChild(panel);
         invalidatePanel();
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      function addAuction(param1:AuctionGoodsInfo) : void
      {
         var _loc2_:AuctionBuyStripView = new AuctionBuyStripView();
         _loc2_.info = param1;
         _loc2_.addEventListener("selectStrip",__selectStrip);
         _strips.push(_loc2_);
         _list.addChild(_loc2_);
         invalidatePanel();
      }
      
      private function invalidatePanel() : void
      {
         panel.vScrollProxy = _list.height > panel.height?0:2;
         panel.invalidateViewport();
      }
      
      function clearList() : void
      {
         _clearItems();
         _selectStrip = null;
         _strips = new Vector.<AuctionBuyStripView>();
      }
      
      private function _clearItems() : void
      {
         _strips.splice(0,_strips.length);
         _list.disposeAllChildren();
         _list.height = 0;
         invalidatePanel();
      }
      
      function getSelectInfo() : AuctionGoodsInfo
      {
         if(_selectStrip)
         {
            return _selectStrip.info;
         }
         return null;
      }
      
      function deleteItem() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _strips.length)
         {
            if(_selectStrip == _strips[_loc1_])
            {
               _selectStrip.removeEventListener("selectStrip",__selectStrip);
               _selectStrip.dispose();
               _strips.splice(_loc1_,1);
               _selectStrip = null;
               break;
            }
            _loc1_++;
         }
      }
      
      function clearSelectStrip() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _strips;
         for each(var _loc1_ in _strips)
         {
            if(_selectStrip == _loc1_)
            {
               _selectStrip.removeEventListener("selectStrip",__selectStrip);
               _selectStrip.clearSelectStrip();
               _selectStrip = null;
               break;
            }
         }
      }
      
      function updateAuction(param1:AuctionGoodsInfo) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _strips;
         for each(var _loc2_ in _strips)
         {
            if(_loc2_.info.AuctionID == param1.AuctionID)
            {
               param1.BagItemInfo = _loc2_.info.BagItemInfo;
               _loc2_.info = param1;
               break;
            }
         }
      }
      
      private function __selectStrip(param1:AuctionHouseEvent) : void
      {
         if(_selectStrip)
         {
            _selectStrip.isSelect = false;
         }
         var _loc2_:AuctionBuyStripView = param1.target as AuctionBuyStripView;
         _loc2_.isSelect = true;
         _selectStrip = _loc2_;
         dispatchEvent(new AuctionHouseEvent("selectStrip"));
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(panel)
         {
            ObjectUtils.disposeObject(panel);
         }
         panel = null;
         if(_selectStrip)
         {
            ObjectUtils.disposeObject(_selectStrip);
         }
         _selectStrip = null;
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
         }
         _list = null;
         var _loc3_:int = 0;
         var _loc2_:* = _strips;
         for each(var _loc1_ in _strips)
         {
            if(_loc1_)
            {
               ObjectUtils.disposeObject(_loc1_);
            }
            _loc1_ = null;
         }
         _strips = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
