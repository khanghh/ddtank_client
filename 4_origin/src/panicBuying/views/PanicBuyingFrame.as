package panicBuying.views
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonForArrange;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.HelpFrameUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import panicBuying.PanicBuyingManager;
   import panicBuying.components.PanicBuyingItem;
   import panicBuying.data.PBuyingItemInfo;
   import road7th.utils.DateUtils;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.GiftConditionInfo;
   import wonderfulActivity.data.GiftRewardInfo;
   import wonderfulActivity.data.GmActivityInfo;
   import wonderfulActivity.event.WonderfulActivityEvent;
   
   public class PanicBuyingFrame extends Frame
   {
      
      private static const NUM:int = 3;
      
      private static const ITEM_COUNT:int = 6;
      
      public static const LEVEL:int = 0;
      
      public static const VIP:int = 1;
      
      public static const ENTIRE:int = 2;
      
      public static const INDIV:int = 3;
      
      public static const NEW_ENTIRE:int = 4;
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _vipBg:Bitmap;
      
      private var _dateBmp:Bitmap;
      
      private var _dateTxt:FilterFrameText;
      
      private var _remainBmp:Bitmap;
      
      private var _remainTxt:FilterFrameText;
      
      private var _tabGroup:SelectedButtonGroup;
      
      private var _hBox:Sprite;
      
      private var _levelRushBtn:SelectedButtonForArrange;
      
      private var _vipRushBtn:SelectedButtonForArrange;
      
      private var _entireRushBtn:SelectedButtonForArrange;
      
      private var _newEntireRushBtn:SelectedButtonForArrange;
      
      private var _indivRushBtn:SelectedButtonForArrange;
      
      private var _typeArr:Array;
      
      private var _tileList:SimpleTileList;
      
      private var _itemVec:Vector.<PanicBuyingItem>;
      
      private var _firstBtn:SimpleBitmapButton;
      
      private var _preBtn:SimpleBitmapButton;
      
      private var _nextBtn:SimpleBitmapButton;
      
      private var _lastBtn:SimpleBitmapButton;
      
      private var _pageBg:Scale9CornerImage;
      
      private var _pageTxt:FilterFrameText;
      
      private var _btnHelp:BaseButton;
      
      private var _helpSprite:Sprite;
      
      private var _helpScrollPanel:ScrollPanel;
      
      private var _helpTxt:FilterFrameText;
      
      private var _helpTxtWidth:int;
      
      private var _curType:int;
      
      private var _curPage:int;
      
      private var _xmlData:GmActivityInfo;
      
      private var _giftInfoDic:Dictionary;
      
      private var tmpFlag:int;
      
      public function PanicBuyingFrame()
      {
         super();
         initView();
         addEvents();
         initTimer();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         titleText = LanguageMgr.GetTranslation("panicBuying.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("panicBuying.bg");
         addToContent(_bg);
         _vipBg = ComponentFactory.Instance.creat("panicBuying.vipBg");
         addToContent(_vipBg);
         _vipBg.visible = false;
         _dateBmp = ComponentFactory.Instance.creat("panicBuying.date");
         addToContent(_dateBmp);
         _dateTxt = ComponentFactory.Instance.creatComponentByStylename("panicBuying.dateTxt");
         addToContent(_dateTxt);
         _tileList = ComponentFactory.Instance.creat("panicBuying.tileList",[3]);
         addToContent(_tileList);
         _itemVec = new Vector.<PanicBuyingItem>();
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = new PanicBuyingItem();
            _tileList.addChild(_loc1_);
            _itemVec.push(_loc1_);
            _loc2_++;
         }
         _remainBmp = ComponentFactory.Instance.creat("panicBuying.remain");
         addToContent(_remainBmp);
         _remainTxt = ComponentFactory.Instance.creatComponentByStylename("panicBuying.remainTxt");
         addToContent(_remainTxt);
         _remainTxt.text = "12小时20分";
         _firstBtn = ComponentFactory.Instance.creatComponentByStylename("panicBuying.firstBtn");
         addToContent(_firstBtn);
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("panicBuying.preBtn");
         addToContent(_preBtn);
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("panicBuying.nextBtn");
         addToContent(_nextBtn);
         _lastBtn = ComponentFactory.Instance.creatComponentByStylename("panicBuying.lastBtn");
         addToContent(_lastBtn);
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("panicBuying.pageBg");
         addToContent(_pageBg);
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("panicBuying.pageTxt");
         addToContent(_pageTxt);
         _pageTxt.text = "1/15";
         _helpTxt = ComponentFactory.Instance.creatComponentByStylename("panicBuying.helpTxt");
         _helpTxtWidth = _helpTxt.width;
         _helpSprite = new Sprite();
         _helpScrollPanel = ComponentFactory.Instance.creatComponentByStylename("panicBuying.helpScrollPanel");
         _helpScrollPanel.setView(_helpTxt);
         _helpSprite.addChild(_helpScrollPanel);
         _btnHelp = HelpFrameUtils.Instance.simpleHelpButton(this,"core.helpButtonSmall",{
            "x":544,
            "y":-40
         },LanguageMgr.GetTranslation("panicBuying.helpTxt"),_helpSprite,408,488);
         initView2();
      }
      
      private function initView2() : void
      {
         _hBox = new Sprite();
         _hBox.x = 5;
         addToContent(_hBox);
         _levelRushBtn = ComponentFactory.Instance.creatComponentByStylename("panicBuying.levelRushBtn");
         _vipRushBtn = ComponentFactory.Instance.creatComponentByStylename("panicBuying.vipRushBtn");
         _entireRushBtn = ComponentFactory.Instance.creatComponentByStylename("panicBuying.entireRushBtn");
         _newEntireRushBtn = ComponentFactory.Instance.creatComponentByStylename("panicBuying.newEntireRushBtn");
         _indivRushBtn = ComponentFactory.Instance.creatComponentByStylename("panicBuying.indivRushBtn");
         _tabGroup = new SelectedButtonGroup();
         _typeArr = [];
         tmpFlag = PanicBuyingManager.instance.showIconFlag;
         if(tmpFlag & 2)
         {
            _hBox.addChild(_levelRushBtn);
            _tabGroup.addSelectItem(_levelRushBtn);
            _typeArr.push(0);
         }
         if(tmpFlag & 4)
         {
            _hBox.addChild(_vipRushBtn);
            _tabGroup.addSelectItem(_vipRushBtn);
            _typeArr.push(1);
         }
         if(tmpFlag & 1)
         {
            _hBox.addChild(_entireRushBtn);
            _tabGroup.addSelectItem(_entireRushBtn);
            _typeArr.push(2);
         }
         if(tmpFlag & 8)
         {
            _hBox.addChild(_indivRushBtn);
            _tabGroup.addSelectItem(_indivRushBtn);
            _typeArr.push(3);
         }
         if(tmpFlag & 16)
         {
            _hBox.addChild(_newEntireRushBtn);
            _tabGroup.addSelectItem(_newEntireRushBtn);
            _typeArr.push(4);
         }
         _tabGroup.selectIndex = 0;
         _curType = _typeArr[_tabGroup.selectIndex];
         _curPage = 1;
         update();
         refreshTab();
      }
      
      private function refreshTab() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = _hBox.numChildren;
         _loc2_ = 1;
         while(_loc2_ < _loc1_)
         {
            if((_hBox.getChildAt(_loc2_ - 1) as SelectedButtonForArrange).selected)
            {
               _hBox.getChildAt(_loc2_).x = _hBox.getChildAt(_loc2_ - 1).x + 2 + 132;
            }
            else
            {
               _hBox.getChildAt(_loc2_).x = _hBox.getChildAt(_loc2_ - 1).x + 2 + 113;
            }
            _loc2_++;
         }
      }
      
      private function addEvents() : void
      {
         addEventListener("response",__responseHandler);
         _tabGroup.addEventListener("change",__changeHandler);
         _firstBtn.addEventListener("click",__firstBtnClick);
         _preBtn.addEventListener("click",__preBtnClick);
         _nextBtn.addEventListener("click",__nextBtnClick);
         _lastBtn.addEventListener("click",__lastBtnClick);
         WonderfulActivityManager.Instance.addEventListener("refresh",refreshActivity);
      }
      
      private function initTimer() : void
      {
         timerHandler();
         WonderfulActivityManager.Instance.addTimerFun("panicBuying",timerHandler);
      }
      
      private function timerHandler() : void
      {
         if(!_xmlData)
         {
            return;
         }
         var _loc3_:Date = DateUtils.getDateByStr(_xmlData.endTime);
         var _loc2_:Date = TimeManager.Instance.Now();
         var _loc1_:String = getTimeDiff(_loc3_,_loc2_);
         if(_remainTxt)
         {
            _remainTxt.text = _loc1_;
         }
         if(_loc1_ == "0")
         {
            if(_remainTxt)
            {
               _remainTxt.text = LanguageMgr.GetTranslation("treasureHunting.over");
            }
            WonderfulActivityManager.Instance.delTimerFun("panicBuying");
         }
      }
      
      public function getTimeDiff(param1:Date, param2:Date) : String
      {
         var _loc3_:* = 0;
         var _loc8_:* = 0;
         var _loc7_:* = 0;
         var _loc5_:* = 0;
         var _loc4_:* = null;
         var _loc6_:Number = Math.round((param1.getTime() - param2.getTime()) / 1000);
         if(_loc6_ >= 0)
         {
            _loc3_ = uint(Math.floor(_loc6_ / 60 / 60 / 24));
            _loc6_ = _loc6_ % 86400;
            _loc8_ = uint(Math.floor(_loc6_ / 60 / 60));
            _loc6_ = _loc6_ % 3600;
            _loc7_ = uint(Math.floor(_loc6_ / 60));
            _loc5_ = uint(_loc6_ % 60);
            if(_loc3_ > 0)
            {
               return _loc3_ + LanguageMgr.GetTranslation("wonderfulActivityManager.d");
            }
            _loc4_ = "";
            if(_loc8_ > 0)
            {
               _loc4_ = _loc4_ + (_loc8_ + LanguageMgr.GetTranslation("wonderfulActivityManager.h"));
            }
            if(_loc7_ > 0)
            {
               _loc4_ = _loc4_ + (_loc7_ + LanguageMgr.GetTranslation("wonderfulActivityManager.m"));
            }
            if(_loc4_ == "")
            {
               _loc4_ = _loc5_ + LanguageMgr.GetTranslation("wonderfulActivityManager.s");
            }
            return _loc4_;
         }
         return "0";
      }
      
      protected function __lastBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("008");
         if(_curType == 2)
         {
            _loc2_ = ShopManager.Instance.getDisCountResultPages(1,6);
         }
         else
         {
            _loc2_ = getGiftBagTotal();
         }
         _curPage = _loc2_;
         update();
      }
      
      protected function __nextBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("008");
         if(_curType == 2)
         {
            _loc2_ = ShopManager.Instance.getDisCountResultPages(1,6);
         }
         else
         {
            _loc2_ = getGiftBagTotal();
         }
         _curPage = _curPage >= _loc2_?_loc2_:_curPage + 1;
         update();
      }
      
      protected function __preBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _curPage = _curPage <= 1?1:Number(_curPage - 1);
         update();
      }
      
      protected function __firstBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _curPage = 1;
         update();
      }
      
      protected function __changeHandler(param1:Event) : void
      {
         SoundManager.instance.play("008");
         _curType = _typeArr[_tabGroup.selectIndex];
         _curPage = 1;
         update();
         refreshTab();
      }
      
      private function update() : void
      {
         var _loc10_:int = 0;
         var _loc9_:* = null;
         var _loc7_:int = 0;
         var _loc3_:* = undefined;
         var _loc2_:* = null;
         var _loc6_:* = null;
         var _loc8_:* = undefined;
         var _loc4_:int = 0;
         var _loc1_:* = undefined;
         var _loc5_:int = 0;
         updateFrameStyle();
         if(_curType == 2)
         {
            _loc3_ = ShopManager.Instance.getDisCountGoods(1,_curPage,6);
            _loc10_ = 0;
            while(_loc10_ < 6)
            {
               _loc9_ = new PBuyingItemInfo();
               if(_loc10_ <= _loc3_.length - 1)
               {
                  _loc9_.templateId = _loc3_[_loc10_].TemplateID;
                  _loc9_.goodsId = _loc3_[_loc10_].GoodsID;
                  _loc9_.price = _loc3_[_loc10_].AValue1;
                  _loc9_.originalPrice = _loc3_[_loc10_].Position;
                  _loc9_.priceType = _loc3_[_loc10_].APrice1;
                  _loc9_.unitCount = _loc3_[_loc10_].AUnit;
               }
               else
               {
                  _loc9_.templateId = 0;
               }
               _itemVec[_loc10_].setData(_loc9_,_curType);
               _loc10_++;
            }
            _xmlData = WonderfulActivityManager.Instance.activityData[PanicBuyingManager.instance.entireId];
            setHelpTxt(_xmlData.desc);
            _loc7_ = ShopManager.Instance.getDisCountResultPages(1,6);
         }
         else
         {
            switch(int(_curType))
            {
               case 0:
                  _xmlData = WonderfulActivityManager.Instance.activityData[PanicBuyingManager.instance.levelId];
                  _giftInfoDic = WonderfulActivityManager.Instance.activityInitData[PanicBuyingManager.instance.levelId].giftInfoDic;
                  break;
               case 1:
                  _xmlData = WonderfulActivityManager.Instance.activityData[PanicBuyingManager.instance.vipId];
                  _giftInfoDic = WonderfulActivityManager.Instance.activityInitData[PanicBuyingManager.instance.vipId].giftInfoDic;
                  _loc2_ = WonderfulActivityManager.Instance.activityInitData[PanicBuyingManager.instance.vipId].statusArr;
                  break;
               default:
                  _xmlData = WonderfulActivityManager.Instance.activityData[PanicBuyingManager.instance.vipId];
                  _giftInfoDic = WonderfulActivityManager.Instance.activityInitData[PanicBuyingManager.instance.vipId].giftInfoDic;
                  _loc2_ = WonderfulActivityManager.Instance.activityInitData[PanicBuyingManager.instance.vipId].statusArr;
                  break;
               case 3:
                  _xmlData = WonderfulActivityManager.Instance.activityData[PanicBuyingManager.instance.indivId];
                  _giftInfoDic = WonderfulActivityManager.Instance.activityInitData[PanicBuyingManager.instance.indivId].giftInfoDic;
                  break;
               case 4:
                  _xmlData = WonderfulActivityManager.Instance.activityData[PanicBuyingManager.instance.newEntireId];
                  _giftInfoDic = WonderfulActivityManager.Instance.activityInitData[PanicBuyingManager.instance.newEntireId].giftInfoDic;
            }
            _loc6_ = getGiftBagInCurPage(_curPage);
            _loc10_ = 0;
            while(_loc10_ < 6)
            {
               _loc9_ = new PBuyingItemInfo();
               if(_loc10_ <= _loc6_.length - 1)
               {
                  _loc9_.templateId = _loc6_[_loc10_].giftRewardArr[0].templateId;
                  _loc9_.activityId = _loc6_[_loc10_].activityId;
                  _loc9_.giftbagId = _loc6_[_loc10_].giftbagId;
                  _loc9_.limitedType = 0;
                  _loc8_ = _loc6_[_loc10_].giftConditionArr;
                  _loc4_ = 0;
                  while(_loc4_ <= _loc8_.length - 1)
                  {
                     if(_loc8_[_loc4_].conditionIndex == 1)
                     {
                        _loc9_.total = _loc8_[_loc4_].conditionValue;
                     }
                     if(_loc8_[_loc4_].conditionIndex == 2)
                     {
                        _loc9_.priceType = _loc8_[_loc4_].conditionValue;
                     }
                     if(_loc8_[_loc4_].conditionIndex == 3)
                     {
                        _loc9_.price = _loc8_[_loc4_].conditionValue;
                     }
                     else if(_loc8_[_loc4_].conditionIndex == 4)
                     {
                        _loc9_.levelLimit = _loc8_[_loc4_].conditionValue;
                     }
                     else if(_loc8_[_loc4_].conditionIndex == 5)
                     {
                        _loc9_.vipLimit = _loc8_[_loc4_].conditionValue;
                     }
                     else if(_loc8_[_loc4_].conditionIndex == 6)
                     {
                        _loc9_.originalPrice = _loc8_[_loc4_].conditionValue;
                     }
                     else if(_loc8_[_loc4_].conditionIndex == 100)
                     {
                        _loc9_.remain = _loc8_[_loc4_].conditionValue;
                        _loc9_.limitedType = 1;
                     }
                     _loc4_++;
                  }
                  if(_curType == 4)
                  {
                     if(_loc10_ <= _loc6_.length - 1)
                     {
                        if(_loc9_.total == 0)
                        {
                           _loc9_.remain = _loc9_.remain - _giftInfoDic[_loc9_.giftbagId].allGiftGetTimes;
                        }
                        else
                        {
                           _loc9_.limitedType = 1;
                           _loc9_.remain = _loc9_.total - _giftInfoDic[_loc9_.giftbagId].times;
                        }
                     }
                  }
                  else
                  {
                     _loc9_.remain = _loc9_.total - _giftInfoDic[_loc9_.giftbagId].times;
                  }
                  _loc1_ = _loc6_[_loc10_].giftRewardArr;
                  _loc5_ = 0;
                  while(_loc5_ <= _loc1_.length - 1)
                  {
                     _loc9_.count = _loc1_[_loc5_].count;
                     if(_loc1_[_loc5_].validDate == 0)
                     {
                        _loc9_.buyType = 1;
                        _loc9_.unitCount = _loc1_[_loc5_].count;
                     }
                     else
                     {
                        _loc9_.buyType = 0;
                        _loc9_.unitCount = _loc1_[_loc5_].validDate;
                     }
                     _loc5_++;
                  }
               }
               else
               {
                  _loc9_.templateId = 0;
               }
               _itemVec[_loc10_].setData(_loc9_,_curType);
               _loc10_++;
            }
            _loc7_ = getGiftBagTotal();
         }
         if(_curType == 2)
         {
            _dateBmp.visible = false;
            _dateTxt.visible = false;
         }
         else
         {
            _dateBmp.visible = true;
            _dateTxt.visible = true;
            _dateTxt.text = dateTrim(_xmlData.beginTime) + "-" + dateTrim(_xmlData.endTime);
            setHelpTxt(_xmlData.desc);
         }
         _pageTxt.text = _curPage + "/" + _loc7_;
         timerHandler();
      }
      
      private function setHelpTxt(param1:String) : void
      {
         _helpTxt.autoSize = "none";
         _helpTxt.width = _helpTxtWidth;
         _helpTxt.text = _xmlData.desc;
         _helpTxt.autoSize = "left";
         _helpScrollPanel.invalidateViewport(false);
      }
      
      private function getGiftBagInCurPage(param1:int) : Array
      {
         var _loc3_:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = _xmlData.giftbagArray;
         for each(var _loc2_ in _xmlData.giftbagArray)
         {
            if(_loc2_.giftbagOrder >= (param1 - 1) * 6 && _loc2_.giftbagOrder <= param1 * 6 - 1)
            {
               _loc3_.push(_loc2_);
            }
         }
         return _loc3_;
      }
      
      private function getGiftBagTotal() : int
      {
         return Math.ceil(_xmlData.giftbagArray.length / 6);
      }
      
      private function dateTrim(param1:String) : String
      {
         var _loc2_:String = "";
         var _loc3_:Array = param1.split(" ");
         _loc2_ = _loc3_[0].replace(/\//g,".");
         return _loc2_;
      }
      
      private function updateFrameStyle() : void
      {
         switch(int(_curType))
         {
            case 0:
               _bg.visible = true;
               _vipBg.visible = false;
               _remainBmp.visible = true;
               _remainTxt.visible = true;
               break;
            case 1:
               _bg.visible = false;
               _vipBg.visible = true;
               _remainBmp.visible = true;
               _remainTxt.visible = true;
               break;
            case 2:
            case 3:
               _bg.visible = true;
               _vipBg.visible = false;
               _remainBmp.visible = false;
               _remainTxt.visible = false;
               break;
            case 4:
               _bg.visible = true;
               _vipBg.visible = false;
               _remainBmp.visible = true;
               _remainTxt.visible = true;
         }
      }
      
      public function refreshActivity(param1:WonderfulActivityEvent = null) : void
      {
         if(PanicBuyingManager.instance.showIconFlag == tmpFlag)
         {
            update();
            return;
         }
         tmpFlag = PanicBuyingManager.instance.showIconFlag;
         if(tmpFlag == 0)
         {
            dispose();
            return;
         }
         _tabGroup.removeEventListener("change",__changeHandler);
         ObjectUtils.disposeObject(_tabGroup);
         _tabGroup = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeObject(_levelRushBtn);
         _levelRushBtn = null;
         ObjectUtils.disposeObject(_vipRushBtn);
         _vipRushBtn = null;
         ObjectUtils.disposeObject(_entireRushBtn);
         _entireRushBtn = null;
         ObjectUtils.disposeObject(_newEntireRushBtn);
         _newEntireRushBtn = null;
         ObjectUtils.disposeObject(_indivRushBtn);
         _indivRushBtn = null;
         initView2();
         _tabGroup.addEventListener("change",__changeHandler);
      }
      
      protected function __responseHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            dispose();
         }
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",__responseHandler);
         _tabGroup.removeEventListener("change",__changeHandler);
         _firstBtn.removeEventListener("click",__firstBtnClick);
         _preBtn.removeEventListener("click",__preBtnClick);
         _nextBtn.removeEventListener("click",__nextBtnClick);
         _lastBtn.removeEventListener("click",__lastBtnClick);
         WonderfulActivityManager.Instance.removeEventListener("refresh",refreshActivity);
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         removeEvents();
         WonderfulActivityManager.Instance.delTimerFun("panicBuying");
         _loc1_ = 0;
         while(_loc1_ <= _itemVec.length - 1)
         {
            ObjectUtils.disposeObject(_itemVec[_loc1_]);
            _itemVec[_loc1_] = null;
            _loc1_++;
         }
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_vipBg);
         _vipBg = null;
         ObjectUtils.disposeObject(_dateBmp);
         _dateBmp = null;
         ObjectUtils.disposeObject(_dateTxt);
         _dateTxt = null;
         ObjectUtils.disposeObject(_remainBmp);
         _remainBmp = null;
         ObjectUtils.disposeObject(_remainTxt);
         _remainTxt = null;
         ObjectUtils.disposeObject(_tabGroup);
         _tabGroup = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeObject(_levelRushBtn);
         _levelRushBtn = null;
         ObjectUtils.disposeObject(_vipRushBtn);
         _vipRushBtn = null;
         ObjectUtils.disposeObject(_entireRushBtn);
         _entireRushBtn = null;
         ObjectUtils.disposeObject(_newEntireRushBtn);
         _newEntireRushBtn = null;
         ObjectUtils.disposeObject(_indivRushBtn);
         _indivRushBtn = null;
         ObjectUtils.disposeObject(_tileList);
         _tileList = null;
         ObjectUtils.disposeObject(_firstBtn);
         _firstBtn = null;
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_lastBtn);
         _lastBtn = null;
         ObjectUtils.disposeObject(_pageBg);
         _pageBg = null;
         ObjectUtils.disposeObject(_pageTxt);
         _pageTxt = null;
         ObjectUtils.disposeObject(_btnHelp);
         _btnHelp = null;
         ObjectUtils.disposeObject(_helpTxt);
         _helpTxt = null;
         ObjectUtils.disposeObject(_helpScrollPanel);
         _helpScrollPanel = null;
         ObjectUtils.disposeObject(_helpSprite);
         _helpSprite = null;
         super.dispose();
      }
   }
}
