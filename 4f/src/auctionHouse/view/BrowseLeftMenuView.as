package auctionHouse.view
{
   import auctionHouse.event.AuctionHouseEvent;
   import auctionHouse.model.AuctionHouseModel;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SimpleDropListTarget;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.CateCoryInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class BrowseLeftMenuView extends Sprite implements Disposeable
   {
      
      private static const ALL:int = -1;
      
      private static const WEAPON:int = 25;
      
      private static const SUB_WEAPON:int = 7;
      
      private static const OFFHAND:int = 17;
      
      private static const CLOTH:int = 21;
      
      private static const HAT:int = 1;
      
      private static const GLASS:int = 2;
      
      private static const SUB_CLOTH:int = 5;
      
      private static const JEWELRY:int = 24;
      
      private static const BEAUTY:int = 22;
      
      private static const HAIR:int = 3;
      
      private static const ORNAMENT:int = 4;
      
      private static const EYES:int = 6;
      
      private static const SUITS:int = 13;
      
      private static const WINGS:int = 15;
      
      private static const STRENTH:int = 1100;
      
      private static const STRENTH_1:int = 11025;
      
      private static const STRENTH_2:int = 1102;
      
      private static const STRENTH_3:int = 1103;
      
      private static const STRENTH_4:int = 1104;
      
      private static const STRENTH_5:int = 1110;
      
      private static const COMPOSE:int = 1105;
      
      private static const ZHUQUE:int = 1106;
      
      private static const XUANWU:int = 1107;
      
      private static const QINGLONG:int = 1108;
      
      private static const BAIHU:int = 1109;
      
      private static const SPHERE:int = 26;
      
      private static const TRIANGLE:int = 27;
      
      private static const ROUND:int = 28;
      
      private static const SQUERE:int = 29;
      
      private static const WISHBEAD:int = 35;
      
      private static const Drill:int = 1115;
      
      private static const DrillLv1:int = 1116;
      
      private static const DrillLv2:int = 1117;
      
      private static const DrillLv3:int = 1118;
      
      private static const DrillLv4:int = 1119;
      
      private static const DrillLv5:int = 1120;
      
      private static const PATCH:int = 30;
      
      private static const WUQISP:int = 1111;
      
      private static const FUWUQISP:int = 1112;
      
      private static const XIANGLIANSP:int = 1121;
      
      private static const CARDS:int = 31;
      
      private static const FREAKCARD:int = 1113;
      
      private static const EQUIPCARD:int = 1114;
      
      private static const PROP:int = 23;
      
      private static const UNFIGHT_PROP:int = 11;
      
      private static const PAOPAO:int = 16;
      
      private static const PET:int = 36;
      
      private static const UNBINDPET:int = 37;
      
      private static const PETEQUIP:int = 38;
      
      private static const PETSTONE:int = 39;
       
      
      private var menu:VerticalMenu;
      
      private var list:ScrollPanel;
      
      private var _name:SimpleDropListTarget;
      
      private var searchStatus:Boolean;
      
      private var _searchBtn:TextButton;
      
      private var _WuqiFont:ScaleFrameImage;
      
      private var _searchValue:String;
      
      private var _glowState:Boolean;
      
      private var _isForAll:Boolean = true;
      
      private var _isFindAll:Boolean = false;
      
      public function BrowseLeftMenuView(){super();}
      
      private function initView() : void{}
      
      private function menuRefrash(param1:Event) : void{}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function _clickName(param1:MouseEvent) : void{}
      
      private function setFocus(param1:Event) : void{}
      
      public function setFocusName() : void{}
      
      function getInfo() : CateCoryInfo{return null;}
      
      function setSelectType(param1:CateCoryInfo) : void{}
      
      function getType() : int{return 0;}
      
      function setCategory(param1:Vector.<CateCoryInfo>) : void{}
      
      private function getMainCateInfo(param1:int, param2:String) : CateCoryInfo{return null;}
      
      private function _nameKeyUp(param1:KeyboardEvent) : void{}
      
      private function _nameChange(param1:Event) : void{}
      
      public function get searchText() : String{return null;}
      
      public function set setSearchStatus(param1:Boolean) : void{}
      
      public function set searchText(param1:String) : void{}
      
      private function __searchCondition(param1:MouseEvent) : void{}
      
      private function __searchGoods(param1:Boolean = false) : void{}
      
      private function __searchGoodsII(param1:Boolean = false) : void{}
      
      private function _trim(param1:String) : String{return null;}
      
      private function menuItemClick(param1:Event) : void{}
      
      public function dispose() : void{}
   }
}
