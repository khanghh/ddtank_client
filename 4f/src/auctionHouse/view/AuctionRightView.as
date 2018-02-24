package auctionHouse.view
{
   import auctionHouse.event.AuctionHouseEvent;
   import auctionHouse.model.AuctionHouseModel;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.auctionHouse.AuctionGoodsInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class AuctionRightView extends Sprite implements Disposeable
   {
       
      
      private var _prePage_btn:BaseButton;
      
      private var _nextPage_btn:BaseButton;
      
      private var _first_btn:BaseButton;
      
      private var _end_btn:BaseButton;
      
      public var page_txt:FilterFrameText;
      
      private var _sorttxtItems:Vector.<FilterFrameText>;
      
      private var _sortBtItems:Vector.<Sprite>;
      
      private var _sortArrowItems:Vector.<ScaleFrameImage>;
      
      private var _stripList:ListPanel;
      
      private var _state:String;
      
      private var _currentButtonIndex:uint = 0;
      
      private var _currentIsdown:Boolean = true;
      
      private var _selectStrip:StripView;
      
      private var _selectInfo:AuctionGoodsInfo;
      
      private var help_mc:Bitmap;
      
      private var help_BG:Bitmap;
      
      private var _nameTxt:FilterFrameText;
      
      private var _bidNumberTxt:FilterFrameText;
      
      private var _RemainingTimeTxt:FilterFrameText;
      
      private var _SellPersonTxt:FilterFrameText;
      
      private var _bidpriceTxt:FilterFrameText;
      
      private var _BidPersonTxt:FilterFrameText;
      
      private var _tableline:Bitmap;
      
      private var _tableline1:Bitmap;
      
      private var _tableline2:Bitmap;
      
      private var _tableline3:Bitmap;
      
      private var _tableline4:Bitmap;
      
      private var GoodsName_btn:Sprite;
      
      private var RemainingTime_btn:Sprite;
      
      private var SellPerson_btn:Sprite;
      
      private var BidPrice_btn:Sprite;
      
      private var BidPerson_btn:Sprite;
      
      private var _startNum:int = 0;
      
      private var _endNum:int = 0;
      
      private var _totalCount:int = 0;
      
      public function AuctionRightView(){super();}
      
      public function setup(param1:String = "") : void{}
      
      private function initView() : void{}
      
      private function addEvent() : void{}
      
      public function addStageInit() : void{}
      
      public function hideReady() : void{}
      
      public function addAuction(param1:AuctionGoodsInfo) : void{}
      
      public function updateAuction(param1:AuctionGoodsInfo) : void{}
      
      function getStripCount() : int{return 0;}
      
      function setPage(param1:int, param2:int) : void{}
      
      private function upPageTxt() : void{}
      
      private function buttonStatus(param1:int, param2:int, param3:int) : void{}
      
      function clearList() : void{}
      
      private function _clearItems() : void{}
      
      private function invalidatePanel() : void{}
      
      function getSelectInfo() : AuctionGoodsInfo{return null;}
      
      function deleteItem() : void{}
      
      function clearSelectStrip() : void{}
      
      function setSelectEmpty() : void{}
      
      function get sortCondition() : int{return 0;}
      
      function get sortBy() : Boolean{return false;}
      
      private function __itemClick(param1:ListItemEvent) : void{}
      
      private function removeEvent() : void{}
      
      private function sortHandler(param1:MouseEvent) : void{}
      
      private function _showOneArrow(param1:uint) : void{}
      
      private function _hideArrow() : void{}
      
      private function changeArrow(param1:uint, param2:Boolean) : void{}
      
      public function get prePage_btn() : BaseButton{return null;}
      
      public function get nextPage_btn() : BaseButton{return null;}
      
      public function dispose() : void{}
   }
}
