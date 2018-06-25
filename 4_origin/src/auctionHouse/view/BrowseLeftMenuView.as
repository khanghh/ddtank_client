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
      
      private static const MARK1:int = 40;
      
      private static const MARK2:int = 41;
      
      private static const MARK3:int = 42;
      
      private static const MARK4:int = 43;
      
      private static const MARK5:int = 45;
      
      private static const MARKALL:int = 44;
      
      private static const MARK6:int = 46;
      
      private static const MARK7:int = 47;
       
      
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
         var bg1:MutipleImage = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.LeftBG1");
         addChild(bg1);
         var inputBg:Scale9CornerImage = ComponentFactory.Instance.creatComponentByStylename("asset.auctionHouse.Browse.baiduBG");
         addChild(inputBg);
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
      
      private function menuRefrash(event:Event) : void
      {
         _isFindAll = ((event.currentTarget as VerticalMenu).currentItem as BrowseLeftMenuItem).isOpen;
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
      
      private function _clickName(e:MouseEvent) : void
      {
         if(_name.text == LanguageMgr.GetTranslation("tank.auctionHouse.view.pleaseInputOnThere"))
         {
            _name.text = "";
         }
      }
      
      private function setFocus(evt:Event) : void
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
      
      function setSelectType(type:CateCoryInfo) : void
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
      
      function setCategory(value:Vector.<CateCoryInfo>) : void
      {
         var item:* = null;
         var item0:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftStripAsset(ComponentFactory.Instance.creatComponentByStylename("ddtauctionHouse.fuzhuang")),getMainCateInfo(21,LanguageMgr.GetTranslation("")));
         var item1:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftStripAsset(ComponentFactory.Instance.creatComponentByStylename("ddtauctionHouse.meirong")),getMainCateInfo(22,LanguageMgr.GetTranslation("")));
         var item2:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftStripAsset(ComponentFactory.Instance.creatComponentByStylename("ddtauctionHouse.prop")),getMainCateInfo(23,LanguageMgr.GetTranslation("")));
         var item4:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftStripAsset(ComponentFactory.Instance.creatComponentByStylename("ddtauctionHouse.weapon")),getMainCateInfo(25,LanguageMgr.GetTranslation("")));
         var item5:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftStripAsset(ComponentFactory.Instance.creatComponentByStylename("ddtauctionHouse.qianghuahecheng")),getMainCateInfo(1100,LanguageMgr.GetTranslation("")));
         var item7:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftStripAsset(ComponentFactory.Instance.creatComponentByStylename("ddtauctionHouse.baozhuzuantou")),getMainCateInfo(26,LanguageMgr.GetTranslation("")));
         var item8:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftStripAsset(ComponentFactory.Instance.creatComponentByStylename("ddtauctionHouse.xycp")),getMainCateInfo(30,LanguageMgr.GetTranslation("")));
         var item9:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftStripAsset(ComponentFactory.Instance.creatComponentByStylename("ddtauctionHouse.cards")),getMainCateInfo(31,LanguageMgr.GetTranslation("")));
         var item11:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftStripAsset(ComponentFactory.Instance.creatComponentByStylename("ddtauctionHouse.pets")),getMainCateInfo(36,LanguageMgr.GetTranslation("")));
         var item12:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftStripAsset(ComponentFactory.Instance.creatComponentByStylename("ddtauctionHouse.mark")),getMainCateInfo(36,LanguageMgr.GetTranslation("")));
         var _Weapon:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtauctionHouse.Weapon");
         var _Cloth:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtauctionHouse.cloth");
         var _beauty:Bitmap = ComponentFactory.Instance.creatBitmap("asset.auctionHouse.beauty");
         var _qianghuahecheng:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtauction.qianghuahechengIcon");
         var _hechengshi:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtauction.hechengshi");
         var _sphere:Bitmap = ComponentFactory.Instance.creatBitmap("asset.auctionHouse.sphere");
         var _drill:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtauctionHouse.drill");
         var _rarechip:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtauctionHouse.rarechip");
         var _cards:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtauctionHouse.cards");
         var _prop:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtauctionHouse.prop");
         var _pet:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtauctionHouse.petIcon");
         var _mark:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtauctionHouse.markIcon");
         _sphere.scaleX = 0.397435897435897;
         _sphere.scaleY = 0.384615384615385;
         menu.addItemAt(item4,-1);
         menu.addItemAt(item0,-1);
         menu.addItemAt(item1,-1);
         menu.addItemAt(item5,-1);
         menu.addItemAt(item7,-1);
         menu.addItemAt(item8,-1);
         menu.addItemAt(item9,-1);
         menu.addItemAt(item2,-1);
         menu.addItemAt(item11,-1);
         menu.addItemAt(item12,-1);
         item4.addChild(_Weapon);
         item0.addChild(_Cloth);
         item1.addChild(_beauty);
         item5.addChild(_qianghuahecheng);
         item7.addChild(_sphere);
         item8.addChild(_rarechip);
         item9.addChild(_cards);
         item2.addChild(_prop);
         item11.addChild(_pet);
         item12.addChild(_mark);
         var _loc65_:int = 0;
         var _loc64_:* = value;
         for each(var info in value)
         {
            if(info.ID == 1 || info.ID == 2 || info.ID == 5)
            {
               item = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),info);
               menu.addItemAt(item,1);
            }
            else if(info.ID == 13 || info.ID == 15 || info.ID == 6 || info.ID == 4 || info.ID == 3)
            {
               item = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),info);
               menu.addItemAt(item,2);
            }
            else if(info.ID == 11 || info.ID == 16)
            {
               item = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),info);
               menu.addItemAt(item,7);
            }
            else
            {
               item = null;
            }
         }
         var jewelry:CateCoryInfo = new CateCoryInfo();
         jewelry.ID = 24;
         jewelry.Name = LanguageMgr.GetTranslation("tank.auctionHouse.view.jewelry");
         var jewelryItem:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),jewelry);
         menu.addItemAt(jewelryItem,1);
         var subWeapon:CateCoryInfo = new CateCoryInfo();
         subWeapon.ID = 7;
         subWeapon.Name = LanguageMgr.GetTranslation("tank.auctionHouse.view.BrowseLeftMenuView.Weapon");
         var subWeaponItem:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),subWeapon);
         menu.addItemAt(subWeaponItem,0);
         var offHand:CateCoryInfo = new CateCoryInfo();
         offHand.ID = 17;
         offHand.Name = LanguageMgr.GetTranslation("tank.auctionHouse.view.offhand");
         var offHandItem:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),offHand);
         menu.addItemAt(offHandItem,0);
         var subItem1:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(11025,LanguageMgr.GetTranslation("tank.auctionHouse.view.BrowseLeftMenuView.qianghua")));
         menu.addItemAt(subItem1,3);
         var subItem6:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(1106,LanguageMgr.GetTranslation("BrowseLeftMenuView.zhuque")));
         var subItem7:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(1107,LanguageMgr.GetTranslation("BrowseLeftMenuView.xuanwu")));
         var subItem8:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(1108,LanguageMgr.GetTranslation("BrowseLeftMenuView.qinglong")));
         var subItem9:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(1109,LanguageMgr.GetTranslation("BrowseLeftMenuView.baihu")));
         menu.addItemAt(subItem6,3);
         menu.addItemAt(subItem7,3);
         menu.addItemAt(subItem8,3);
         menu.addItemAt(subItem9,3);
         var subItem10:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(1111,LanguageMgr.GetTranslation("BrowseLeftMenuView.wuqisp")));
         var subItem11:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(1112,LanguageMgr.GetTranslation("BrowseLeftMenuView.fuwuqisp")));
         var subItem19:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(1121,LanguageMgr.GetTranslation("BrowseLeftMenuView.xiangliansp")));
         menu.addItemAt(subItem19,5);
         menu.addItemAt(subItem10,5);
         menu.addItemAt(subItem11,5);
         var subItem12:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(1113,LanguageMgr.GetTranslation("BrowseLeftMenuView.freakCard")));
         var subItem13:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(1114,LanguageMgr.GetTranslation("BrowseLeftMenuView.equipCard")));
         menu.addItemAt(subItem12,6);
         menu.addItemAt(subItem13,6);
         var subItemPet1:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(37,LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.PetTxt1")));
         var subItemPet2:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(38,LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.PetTxt2")));
         var subItemPet3:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(39,LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.PetTxt3")));
         menu.addItemAt(subItemPet1,8);
         menu.addItemAt(subItemPet2,8);
         menu.addItemAt(subItemPet3,8);
         var triangle:CateCoryInfo = new CateCoryInfo();
         triangle.ID = 27;
         triangle.Name = LanguageMgr.GetTranslation("tank.auctionHouse.view.triangle");
         var triangleItem:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),triangle);
         menu.addItemAt(triangleItem,4);
         var round:CateCoryInfo = new CateCoryInfo();
         round.ID = 28;
         round.Name = LanguageMgr.GetTranslation("tank.auctionHouse.view.round");
         var roundItem:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),round);
         menu.addItemAt(roundItem,4);
         var square:CateCoryInfo = new CateCoryInfo();
         square.ID = 29;
         square.Name = LanguageMgr.GetTranslation("tank.auctionHouse.view.square");
         var squareItem:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),square);
         menu.addItemAt(squareItem,4);
         var wishBead:CateCoryInfo = new CateCoryInfo();
         wishBead.ID = 35;
         wishBead.Name = LanguageMgr.GetTranslation("tank.auctionHouse.view.wishBead");
         var wishBeadItem:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),wishBead);
         menu.addItemAt(wishBeadItem,4);
         var subItem14:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(1116,LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.drillnote",1116 - 1115)));
         var subItem15:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(1117,LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.drillnote",1117 - 1115)));
         var subItem16:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(1118,LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.drillnote",1118 - 1115)));
         var subItem17:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(1119,LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.drillnote",1119 - 1115)));
         var subItem18:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(1120,LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.drillnote",1120 - 1115)));
         menu.addItemAt(subItem14,4);
         menu.addItemAt(subItem15,4);
         menu.addItemAt(subItem16,4);
         menu.addItemAt(subItem17,4);
         menu.addItemAt(subItem18,4);
         var subItem20:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(40,LanguageMgr.GetTranslation("mark.type3")));
         var subItem21:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(41,LanguageMgr.GetTranslation("mark.type4")));
         var subItem22:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(42,LanguageMgr.GetTranslation("mark.type1")));
         var subItem23:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(43,LanguageMgr.GetTranslation("mark.type2")));
         var subItem24:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(45,LanguageMgr.GetTranslation("mark.type5")));
         var subItem25:BrowseLeftMenuItem = new BrowseLeftMenuItem(new BrowserLeftSubStripAsset(),getMainCateInfo(46,LanguageMgr.GetTranslation("mark.type6")));
         menu.addItemAt(subItem20,9);
         menu.addItemAt(subItem21,9);
         menu.addItemAt(subItem22,9);
         menu.addItemAt(subItem23,9);
         menu.addItemAt(subItem24,9);
         menu.addItemAt(subItem25,9);
         list.invalidateViewport();
      }
      
      private function getMainCateInfo(id:int, name:String) : CateCoryInfo
      {
         var info:CateCoryInfo = new CateCoryInfo();
         info.ID = id;
         info.Name = name;
         return info;
      }
      
      private function _nameKeyUp(e:KeyboardEvent) : void
      {
         if(e.keyCode == 13)
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
      
      private function _nameChange(e:Event) : void
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
      
      public function set setSearchStatus(b:Boolean) : void
      {
         searchStatus = b;
      }
      
      public function set searchText(s:String) : void
      {
         _name.text = s;
         _searchValue = s;
      }
      
      private function __searchCondition(event:MouseEvent) : void
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
      
      private function __searchGoods(isForAll:Boolean = false) : void
      {
         _isForAll = isForAll;
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
      
      private function __searchGoodsII(isForAll:Boolean = false) : void
      {
         _isForAll = isForAll;
         AuctionHouseModel._dimBooble = false;
         _searchValue = "";
         AuctionHouseModel.searchType = 2;
         dispatchEvent(new AuctionHouseEvent("selectStrip"));
      }
      
      private function _trim(str:String) : String
      {
         if(!str)
         {
            return str;
         }
         return str.replace(/(^\s*)|(\s*$)/g,"");
      }
      
      private function menuItemClick(e:Event) : void
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
