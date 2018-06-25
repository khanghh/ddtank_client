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
         var i:int = 0;
         var item:* = null;
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
         for(i = 0; i < 6; )
         {
            item = new PanicBuyingItem();
            _tileList.addChild(item);
            _itemVec.push(item);
            i++;
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
         var i:int = 0;
         var len:int = _hBox.numChildren;
         for(i = 1; i < len; )
         {
            if((_hBox.getChildAt(i - 1) as SelectedButtonForArrange).selected)
            {
               _hBox.getChildAt(i).x = _hBox.getChildAt(i - 1).x + 2 + 132;
            }
            else
            {
               _hBox.getChildAt(i).x = _hBox.getChildAt(i - 1).x + 2 + 113;
            }
            i++;
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
         var endDate:Date = DateUtils.getDateByStr(_xmlData.endTime);
         var nowDate:Date = TimeManager.Instance.Now();
         var str:String = getTimeDiff(endDate,nowDate);
         if(_remainTxt)
         {
            _remainTxt.text = str;
         }
         if(str == "0")
         {
            if(_remainTxt)
            {
               _remainTxt.text = LanguageMgr.GetTranslation("treasureHunting.over");
            }
            WonderfulActivityManager.Instance.delTimerFun("panicBuying");
         }
      }
      
      public function getTimeDiff(endDate:Date, nowDate:Date) : String
      {
         var d:* = 0;
         var h:* = 0;
         var m:* = 0;
         var s:* = 0;
         var str:* = null;
         var diff:Number = Math.round((endDate.getTime() - nowDate.getTime()) / 1000);
         if(diff >= 0)
         {
            d = uint(Math.floor(diff / 60 / 60 / 24));
            diff = diff % 86400;
            h = uint(Math.floor(diff / 60 / 60));
            diff = diff % 3600;
            m = uint(Math.floor(diff / 60));
            s = uint(diff % 60);
            if(d > 0)
            {
               return d + LanguageMgr.GetTranslation("wonderfulActivityManager.d");
            }
            str = "";
            if(h > 0)
            {
               str = str + (h + LanguageMgr.GetTranslation("wonderfulActivityManager.h"));
            }
            if(m > 0)
            {
               str = str + (m + LanguageMgr.GetTranslation("wonderfulActivityManager.m"));
            }
            if(str == "")
            {
               str = s + LanguageMgr.GetTranslation("wonderfulActivityManager.s");
            }
            return str;
         }
         return "0";
      }
      
      protected function __lastBtnClick(event:MouseEvent) : void
      {
         var total:int = 0;
         SoundManager.instance.play("008");
         if(_curType == 2)
         {
            total = ShopManager.Instance.getDisCountResultPages(1,6);
         }
         else
         {
            total = getGiftBagTotal();
         }
         _curPage = total;
         update();
      }
      
      protected function __nextBtnClick(event:MouseEvent) : void
      {
         var total:int = 0;
         SoundManager.instance.play("008");
         if(_curType == 2)
         {
            total = ShopManager.Instance.getDisCountResultPages(1,6);
         }
         else
         {
            total = getGiftBagTotal();
         }
         _curPage = _curPage >= total?total:_curPage + 1;
         update();
      }
      
      protected function __preBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _curPage = _curPage <= 1?1:Number(_curPage - 1);
         update();
      }
      
      protected function __firstBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _curPage = 1;
         update();
      }
      
      protected function __changeHandler(event:Event) : void
      {
         SoundManager.instance.play("008");
         _curType = _typeArr[_tabGroup.selectIndex];
         _curPage = 1;
         update();
         refreshTab();
      }
      
      private function update() : void
      {
         var i:int = 0;
         var info:* = null;
         var totalPage:int = 0;
         var list:* = undefined;
         var arr:* = null;
         var giftBagArr:* = null;
         var conditionArr:* = undefined;
         var j:int = 0;
         var rewardArr:* = undefined;
         var k:int = 0;
         updateFrameStyle();
         if(_curType == 2)
         {
            list = ShopManager.Instance.getDisCountGoods(1,_curPage,6);
            for(i = 0; i < 6; )
            {
               info = new PBuyingItemInfo();
               if(i <= list.length - 1)
               {
                  info.templateId = list[i].TemplateID;
                  info.goodsId = list[i].GoodsID;
                  info.price = list[i].AValue1;
                  info.originalPrice = list[i].Position;
                  info.priceType = list[i].APrice1;
                  info.unitCount = list[i].AUnit;
               }
               else
               {
                  info.templateId = 0;
               }
               _itemVec[i].setData(info,_curType);
               i++;
            }
            _xmlData = WonderfulActivityManager.Instance.activityData[PanicBuyingManager.instance.entireId];
            setHelpTxt(_xmlData.desc);
            totalPage = ShopManager.Instance.getDisCountResultPages(1,6);
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
                  arr = WonderfulActivityManager.Instance.activityInitData[PanicBuyingManager.instance.vipId].statusArr;
                  break;
               default:
                  _xmlData = WonderfulActivityManager.Instance.activityData[PanicBuyingManager.instance.vipId];
                  _giftInfoDic = WonderfulActivityManager.Instance.activityInitData[PanicBuyingManager.instance.vipId].giftInfoDic;
                  arr = WonderfulActivityManager.Instance.activityInitData[PanicBuyingManager.instance.vipId].statusArr;
                  break;
               case 3:
                  _xmlData = WonderfulActivityManager.Instance.activityData[PanicBuyingManager.instance.indivId];
                  _giftInfoDic = WonderfulActivityManager.Instance.activityInitData[PanicBuyingManager.instance.indivId].giftInfoDic;
                  break;
               case 4:
                  _xmlData = WonderfulActivityManager.Instance.activityData[PanicBuyingManager.instance.newEntireId];
                  _giftInfoDic = WonderfulActivityManager.Instance.activityInitData[PanicBuyingManager.instance.newEntireId].giftInfoDic;
            }
            giftBagArr = getGiftBagInCurPage(_curPage);
            for(i = 0; i < 6; )
            {
               info = new PBuyingItemInfo();
               if(i <= giftBagArr.length - 1)
               {
                  info.templateId = giftBagArr[i].giftRewardArr[0].templateId;
                  info.activityId = giftBagArr[i].activityId;
                  info.giftbagId = giftBagArr[i].giftbagId;
                  info.limitedType = 0;
                  conditionArr = giftBagArr[i].giftConditionArr;
                  for(j = 0; j <= conditionArr.length - 1; )
                  {
                     if(conditionArr[j].conditionIndex == 1)
                     {
                        info.total = conditionArr[j].conditionValue;
                     }
                     if(conditionArr[j].conditionIndex == 2)
                     {
                        info.priceType = conditionArr[j].conditionValue;
                     }
                     if(conditionArr[j].conditionIndex == 3)
                     {
                        info.price = conditionArr[j].conditionValue;
                     }
                     else if(conditionArr[j].conditionIndex == 4)
                     {
                        info.levelLimit = conditionArr[j].conditionValue;
                     }
                     else if(conditionArr[j].conditionIndex == 5)
                     {
                        info.vipLimit = conditionArr[j].conditionValue;
                     }
                     else if(conditionArr[j].conditionIndex == 6)
                     {
                        info.originalPrice = conditionArr[j].conditionValue;
                     }
                     else if(conditionArr[j].conditionIndex == 100)
                     {
                        info.remain = conditionArr[j].conditionValue;
                        info.limitedType = 1;
                     }
                     j++;
                  }
                  if(_curType == 4)
                  {
                     if(i <= giftBagArr.length - 1)
                     {
                        if(info.total == 0)
                        {
                           info.remain = info.remain - _giftInfoDic[info.giftbagId].allGiftGetTimes;
                        }
                        else
                        {
                           info.limitedType = 1;
                           info.remain = info.total - _giftInfoDic[info.giftbagId].times;
                        }
                     }
                  }
                  else
                  {
                     info.remain = info.total - _giftInfoDic[info.giftbagId].times;
                  }
                  rewardArr = giftBagArr[i].giftRewardArr;
                  for(k = 0; k <= rewardArr.length - 1; )
                  {
                     info.count = rewardArr[k].count;
                     if(rewardArr[k].validDate == 0)
                     {
                        info.buyType = 1;
                        info.unitCount = rewardArr[k].count;
                     }
                     else
                     {
                        info.buyType = 0;
                        info.unitCount = rewardArr[k].validDate;
                     }
                     k++;
                  }
               }
               else
               {
                  info.templateId = 0;
               }
               _itemVec[i].setData(info,_curType);
               i++;
            }
            totalPage = getGiftBagTotal();
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
         _pageTxt.text = _curPage + "/" + totalPage;
         timerHandler();
      }
      
      private function setHelpTxt(desc:String) : void
      {
         _helpTxt.autoSize = "none";
         _helpTxt.width = _helpTxtWidth;
         _helpTxt.text = _xmlData.desc;
         _helpTxt.autoSize = "left";
         _helpScrollPanel.invalidateViewport(false);
      }
      
      private function getGiftBagInCurPage(curPage:int) : Array
      {
         var arr:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = _xmlData.giftbagArray;
         for each(var giftInfo in _xmlData.giftbagArray)
         {
            if(giftInfo.giftbagOrder >= (curPage - 1) * 6 && giftInfo.giftbagOrder <= curPage * 6 - 1)
            {
               arr.push(giftInfo);
            }
         }
         return arr;
      }
      
      private function getGiftBagTotal() : int
      {
         return Math.ceil(_xmlData.giftbagArray.length / 6);
      }
      
      private function dateTrim(dateStr:String) : String
      {
         var str:String = "";
         var temp:Array = dateStr.split(" ");
         str = temp[0].replace(/\//g,".");
         return str;
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
      
      public function refreshActivity(event:WonderfulActivityEvent = null) : void
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
      
      protected function __responseHandler(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(event.responseCode == 0 || event.responseCode == 1)
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
         var i:int = 0;
         removeEvents();
         WonderfulActivityManager.Instance.delTimerFun("panicBuying");
         for(i = 0; i <= _itemVec.length - 1; )
         {
            ObjectUtils.disposeObject(_itemVec[i]);
            _itemVec[i] = null;
            i++;
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
