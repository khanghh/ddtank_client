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
      
      public function BrowseLeftMenuView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:MutipleImage = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.LeftBG1");
         addChild(_loc2_);
         var _loc1_:Scale9CornerImage = ComponentFactory.Instance.creatComponentByStylename("asset.auctionHouse.Browse.baiduBG");
         addChild(_loc1_);
         _searchBtn = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.baidu_btn");
         _searchBtn.text = LanguageMgr.GetTranslation("shop.ShopRankingView.SearchBtnText");
         addChild(_searchBtn);
         _name = ComponentFactory.Instance.creat("auctionHouse.baiduText");
         _searchValue = "";
         _name.maxChars = 20;
         addChild(_name);
         list = ComponentFactory.Instance.creat("auctionHouse.BrowseLeftScrollpanel");
         addChild(list);
         list.hScrollProxy = 2;
         list.vScrollProxy = 0;
         menu = new VerticalMenu(11,45,33);
         list.setView(menu);
      }
      
      private function menuRefrash(param1:Event) : void
      {
         _isFindAll = ((param1.currentTarget as VerticalMenu).currentItem as BrowseLeftMenuItem).isOpen;
         list.invalidateViewport();
      }
      
      private function addEvent() : void
      {
         _name.addEventListener("mouseDown",_clickName);
         _name.addEventListener("change",_nameChange);
         _name.addEventListener("keyUp",_nameKeyUp);
         _name.addEventListener("addedToStage",setFocus);
         _searchBtn.addEventListener("click",__searchCondition);
         menu.addEventListener("menuClicked",menuItemClick);
         menu.addEventListener("menuRefresh",menuRefrash);
      }
      
      private function removeEvent() : void
      {
         _name.removeEventListener("mouseDown",_clickName);
         _name.removeEventListener("change",_nameChange);
         _name.removeEventListener("keyUp",_nameKeyUp);
         _name.removeEventListener("addedToStage",setFocus);
         _searchBtn.removeEventListener("click",__searchCondition);
         menu.removeEventListener("menuClicked",menuItemClick);
         menu.removeEventListener("menuRefresh",menuRefrash);
      }
      
      private function _clickName(param1:MouseEvent) : void
      {
         if(_name.text == LanguageMgr.GetTranslation("tank.auctionHouse.view.pleaseInputOnThere"))
         {
            _name.text = "";
         }
      }
      
      private function setFocus(param1:Event) : void
      {
         _name.text = LanguageMgr.GetTranslation("tank.auctionHouse.view.pleaseInputOnThere");
         _searchValue = "";
         _name.setFocus();
         _name.setCursor(_name.text.length);
      }
      
      public function setFocusName() : void
      {
         _name.setFocus();
      }
      
      function getInfo() : CateCoryInfo
      {
         if(_isForAll)
         {
            return getMainCateInfo(-1,LanguageMgr.GetTranslation("tank.auctionHouse.view.BrowseLeftMenuView.All"));
         }
         if(menu.currentItem)
         {
            return menu.currentItem.info as CateCoryInfo;
         }
         return getMainCateInfo(-1,LanguageMgr.GetTranslation("tank.auctionHouse.view.BrowseLeftMenuView.All"));
      }
      
      function setSelectType(param1:CateCoryInfo) : void
      {
      }
      
      function getType() : int
      {
         if(_isForAll)
         {
            return -1;
         }
         if(menu.currentItem)
         {
            return menu.currentItem.info.ID;
         }
         return -1;
      }
      
      function setCategory(param1:Vector.<CateCoryInfo>) : void
      {
         var _loc52_:* = null;
         var _loc6_:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftStripAsset(ComponentFactory.Instance.creatComponentByStylename("ddtauctionHouse.fuzhuang")),getMainCateInfo(21,LanguageMgr.GetTranslation("")));
         var _loc5_:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftStripAsset(ComponentFactory.Instance.creatComponentByStylename("ddtauctionHouse.meirong")),getMainCateInfo(22,LanguageMgr.GetTranslation("")));
         var _loc3_:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftStripAsset(ComponentFactory.Instance.creatComponentByStylename("ddtauctionHouse.prop")),getMainCateInfo(23,LanguageMgr.GetTranslation("")));
         var _loc46_:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftStripAsset(ComponentFactory.Instance.creatComponentByStylename("ddtauctionHouse.weapon")),getMainCateInfo(25,LanguageMgr.GetTranslation("")));
         var _loc47_:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftStripAsset(ComponentFactory.Instance.creatComponentByStylename("ddtauctionHouse.qianghuahecheng")),getMainCateInfo(1100,LanguageMgr.GetTranslation("")));
         var _loc51_:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftStripAsset(ComponentFactory.Instance.creatComponentByStylename("ddtauctionHouse.baozhuzuantou")),getMainCateInfo(26,LanguageMgr.GetTranslation("")));
         var _loc48_:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftStripAsset(ComponentFactory.Instance.creatComponentByStylename("ddtauctionHouse.xycp")),getMainCateInfo(30,LanguageMgr.GetTranslation("")));
         var _loc53_:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftStripAsset(ComponentFactory.Instance.creatComponentByStylename("ddtauctionHouse.cards")),getMainCateInfo(31,LanguageMgr.GetTranslation("")));
         var _loc22_:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftStripAsset(ComponentFactory.Instance.creatComponentByStylename("ddtauctionHouse.pets")),getMainCateInfo(36,LanguageMgr.GetTranslation("")));
         var _loc40_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtauctionHouse.Weapon");
         var _loc10_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtauctionHouse.cloth");
         var _loc45_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.auctionHouse.beauty");
         var _loc50_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtauction.qianghuahechengIcon");
         var _loc15_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtauction.hechengshi");
         var _loc42_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.auctionHouse.sphere");
         var _loc43_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtauctionHouse.drill");
         var _loc7_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtauctionHouse.rarechip");
         var _loc2_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtauctionHouse.cards");
         var _loc44_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtauctionHouse.prop");
         var _loc41_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtauctionHouse.petIcon");
         _loc42_.scaleX = 0.397435897435897;
         _loc42_.scaleY = 0.384615384615385;
         menu.addItemAt(_loc46_,-1);
         menu.addItemAt(_loc6_,-1);
         menu.addItemAt(_loc5_,-1);
         menu.addItemAt(_loc47_,-1);
         menu.addItemAt(_loc51_,-1);
         menu.addItemAt(_loc48_,-1);
         menu.addItemAt(_loc53_,-1);
         menu.addItemAt(_loc3_,-1);
         menu.addItemAt(_loc22_,-1);
         _loc46_.addChild(_loc40_);
         _loc6_.addChild(_loc10_);
         _loc5_.addChild(_loc45_);
         _loc47_.addChild(_loc50_);
         _loc51_.addChild(_loc42_);
         _loc48_.addChild(_loc7_);
         _loc53_.addChild(_loc2_);
         _loc3_.addChild(_loc44_);
         _loc22_.addChild(_loc41_);
         var _loc57_:int = 0;
         var _loc56_:* = param1;
         for each(var _loc11_ in param1)
         {
            if(_loc11_.ID == 1 || _loc11_.ID == 2 || _loc11_.ID == 5)
            {
               _loc52_ = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),_loc11_);
               menu.addItemAt(_loc52_,1);
            }
            else if(_loc11_.ID == 13 || _loc11_.ID == 15 || _loc11_.ID == 6 || _loc11_.ID == 4 || _loc11_.ID == 3)
            {
               _loc52_ = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),_loc11_);
               menu.addItemAt(_loc52_,2);
            }
            else if(_loc11_.ID == 11 || _loc11_.ID == 16)
            {
               _loc52_ = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),_loc11_);
               menu.addItemAt(_loc52_,7);
            }
            else
            {
               _loc52_ = null;
            }
         }
         var _loc8_:CateCoryInfo = new CateCoryInfo();
         _loc8_.ID = 24;
         _loc8_.Name = LanguageMgr.GetTranslation("tank.auctionHouse.view.jewelry");
         var _loc29_:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),_loc8_);
         menu.addItemAt(_loc29_,1);
         var _loc28_:CateCoryInfo = new CateCoryInfo();
         _loc28_.ID = 7;
         _loc28_.Name = LanguageMgr.GetTranslation("tank.auctionHouse.view.BrowseLeftMenuView.Weapon");
         var _loc39_:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),_loc28_);
         menu.addItemAt(_loc39_,0);
         var _loc33_:CateCoryInfo = new CateCoryInfo();
         _loc33_.ID = 17;
         _loc33_.Name = LanguageMgr.GetTranslation("tank.auctionHouse.view.offhand");
         var _loc31_:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),_loc33_);
         menu.addItemAt(_loc31_,0);
         var _loc16_:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(11025,LanguageMgr.GetTranslation("tank.auctionHouse.view.BrowseLeftMenuView.qianghua")));
         menu.addItemAt(_loc16_,3);
         var _loc17_:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(1106,LanguageMgr.GetTranslation("BrowseLeftMenuView.zhuque")));
         var _loc20_:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(1107,LanguageMgr.GetTranslation("BrowseLeftMenuView.xuanwu")));
         var _loc19_:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(1108,LanguageMgr.GetTranslation("BrowseLeftMenuView.qinglong")));
         var _loc21_:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(1109,LanguageMgr.GetTranslation("BrowseLeftMenuView.baihu")));
         menu.addItemAt(_loc17_,3);
         menu.addItemAt(_loc20_,3);
         menu.addItemAt(_loc19_,3);
         menu.addItemAt(_loc21_,3);
         var _loc30_:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(1111,LanguageMgr.GetTranslation("BrowseLeftMenuView.wuqisp")));
         var _loc32_:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(1112,LanguageMgr.GetTranslation("BrowseLeftMenuView.fuwuqisp")));
         var _loc27_:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(1121,LanguageMgr.GetTranslation("BrowseLeftMenuView.xiangliansp")));
         menu.addItemAt(_loc27_,5);
         menu.addItemAt(_loc30_,5);
         menu.addItemAt(_loc32_,5);
         var _loc34_:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(1113,LanguageMgr.GetTranslation("BrowseLeftMenuView.freakCard")));
         var _loc35_:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(1114,LanguageMgr.GetTranslation("BrowseLeftMenuView.equipCard")));
         menu.addItemAt(_loc34_,6);
         menu.addItemAt(_loc35_,6);
         var _loc14_:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(37,LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.PetTxt1")));
         var _loc13_:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(38,LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.PetTxt2")));
         var _loc12_:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(39,LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.PetTxt3")));
         menu.addItemAt(_loc14_,8);
         menu.addItemAt(_loc13_,8);
         menu.addItemAt(_loc12_,8);
         var _loc49_:CateCoryInfo = new CateCoryInfo();
         _loc49_.ID = 27;
         _loc49_.Name = LanguageMgr.GetTranslation("tank.auctionHouse.view.triangle");
         var _loc4_:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),_loc49_);
         menu.addItemAt(_loc4_,4);
         var _loc9_:CateCoryInfo = new CateCoryInfo();
         _loc9_.ID = 28;
         _loc9_.Name = LanguageMgr.GetTranslation("tank.auctionHouse.view.round");
         var _loc23_:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),_loc9_);
         menu.addItemAt(_loc23_,4);
         var _loc55_:CateCoryInfo = new CateCoryInfo();
         _loc55_.ID = 29;
         _loc55_.Name = LanguageMgr.GetTranslation("tank.auctionHouse.view.square");
         var _loc18_:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),_loc55_);
         menu.addItemAt(_loc18_,4);
         var _loc54_:CateCoryInfo = new CateCoryInfo();
         _loc54_.ID = 35;
         _loc54_.Name = LanguageMgr.GetTranslation("tank.auctionHouse.view.wishBead");
         var _loc38_:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),_loc54_);
         menu.addItemAt(_loc38_,4);
         var _loc36_:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(1116,LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.drillnote",1116 - 1115)));
         var _loc37_:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(1117,LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.drillnote",1117 - 1115)));
         var _loc24_:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(1118,LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.drillnote",1118 - 1115)));
         var _loc25_:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(1119,LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.drillnote",1119 - 1115)));
         var _loc26_:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(1120,LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.drillnote",1120 - 1115)));
         menu.addItemAt(_loc36_,4);
         menu.addItemAt(_loc37_,4);
         menu.addItemAt(_loc24_,4);
         menu.addItemAt(_loc25_,4);
         menu.addItemAt(_loc26_,4);
         list.invalidateViewport();
      }
      
      private function getMainCateInfo(param1:int, param2:String) : CateCoryInfo
      {
         var _loc3_:CateCoryInfo = new CateCoryInfo();
         _loc3_.ID = param1;
         _loc3_.Name = param2;
         return _loc3_;
      }
      
      private function _nameKeyUp(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            AuctionHouseModel._dimBooble = false;
            if(!_isFindAll)
            {
               __searchGoods(true);
               return;
            }
            __searchGoods(false);
         }
      }
      
      private function _nameChange(param1:Event) : void
      {
         if(_name.text.indexOf(LanguageMgr.GetTranslation("tank.auctionHouse.view.pleaseInputOnThere")) > -1)
         {
            _name.text = _name.text.replace(LanguageMgr.GetTranslation("tank.auctionHouse.view.pleaseInputOnThere"),"");
         }
      }
      
      public function get searchText() : String
      {
         return _searchValue;
      }
      
      public function set setSearchStatus(param1:Boolean) : void
      {
         searchStatus = param1;
      }
      
      public function set searchText(param1:String) : void
      {
         _name.text = param1;
         _searchValue = param1;
      }
      
      private function __searchCondition(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         AuctionHouseModel._dimBooble = false;
         if(!_isFindAll)
         {
            __searchGoods(true);
            return;
         }
         __searchGoods(false);
      }
      
      private function __searchGoods(param1:Boolean = false) : void
      {
         _isForAll = param1;
         AuctionHouseModel._dimBooble = false;
         if(_name.text == LanguageMgr.GetTranslation("tank.auctionHouse.view.pleaseInputOnThere"))
         {
            _name.text = "";
         }
         _searchValue = "";
         _name.text = _trim(_name.text);
         _searchValue = _name.text;
         AuctionHouseModel.searchType = 2;
         dispatchEvent(new AuctionHouseEvent("selectStrip"));
      }
      
      private function __searchGoodsII(param1:Boolean = false) : void
      {
         _isForAll = param1;
         AuctionHouseModel._dimBooble = false;
         _searchValue = "";
         AuctionHouseModel.searchType = 2;
         dispatchEvent(new AuctionHouseEvent("selectStrip"));
      }
      
      private function _trim(param1:String) : String
      {
         if(!param1)
         {
            return param1;
         }
         return param1.replace(/(^\s*)|(\s*$)/g,"");
      }
      
      private function menuItemClick(param1:Event) : void
      {
         list.invalidateViewport();
         if(menu.isseach)
         {
            AuctionHouseModel._dimBooble = false;
            __searchGoodsII();
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_searchBtn)
         {
            _searchBtn.removeEventListener("click",__searchCondition);
         }
         if(menu)
         {
            menu.removeEventListener("menuClicked",menuItemClick);
            menu.dispose();
            menu = null;
         }
         if(list)
         {
            ObjectUtils.disposeObject(list);
            list = null;
         }
         if(_name)
         {
            ObjectUtils.disposeObject(_name);
         }
         _name = null;
         if(_searchBtn)
         {
            ObjectUtils.disposeObject(_searchBtn);
         }
         _searchBtn = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
