package wonderfulActivity.items
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import ddt.view.tips.OneLineTip;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GiftRewardInfo;
   import wonderfulActivity.data.GmActivityInfo;
   import wonderfulActivity.data.SendGiftInfo;
   import wonderfulActivity.views.IRightView;
   
   public class AccumulativePayView extends Sprite implements IRightView
   {
      
      private static const LENGTH:int = 10;
      
      private static const LENGTH2:int = 8;
      
      private static const NUMBER:int = 5;
      
      private static const NUMBER2:int = 4;
      
      private static const PRIZE_LEN:int = 7;
       
      
      private var _content:Sprite;
      
      private var _bg:Bitmap;
      
      private var _title:Bitmap;
      
      private var _shadowBG:Bitmap;
      
      private var _progressBack1:ScaleBitmapImage;
      
      private var _progressBack2:ScaleBitmapImage;
      
      private var _itemList:SimpleTileList;
      
      private var _itemArr:Array;
      
      private var _prizeBG:Bitmap;
      
      private var _prizeList:HBox;
      
      private var _prizeArr:Array;
      
      private var _alreadyPayTxt:FilterFrameText;
      
      private var _alreadyPayValue:FilterFrameText;
      
      private var _nextPrizeNeedTxt:FilterFrameText;
      
      private var _nextPrizeNeedValue:FilterFrameText;
      
      private var _getPrizeBtn:SimpleBitmapButton;
      
      private var _progressList:SimpleTileList;
      
      private var _progressArr:Array;
      
      private var _tip:OneLineTip;
      
      private var activityData:Dictionary;
      
      private var activityInitData:Dictionary;
      
      private var actId:String;
      
      private var accPayValue:int;
      
      private var giftCurInfoDic:Dictionary;
      
      private var giftData:Array;
      
      private var index:int;
      
      public function AccumulativePayView()
      {
         super();
      }
      
      public function init() : void
      {
         accPayValue = 0;
         index = -1;
         _itemArr = [];
         _progressArr = [];
         _prizeArr = [];
         initView();
         initData();
         initEvent();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var item:* = null;
         var k:int = 0;
         var progressLine:* = null;
         var j:int = 0;
         var prizeItem:* = null;
         _content = new Sprite();
         PositionUtils.setPos(_content,"wonderful.Accumulative.ContentPos");
         _bg = ComponentFactory.Instance.creat("wonderful.accumulative.BG");
         _content.addChild(_bg);
         _title = ComponentFactory.Instance.creat("wonderful.accumulative.title");
         _content.addChild(_title);
         _shadowBG = ComponentFactory.Instance.creat("wonderful.accumulative.shadowBG");
         _content.addChild(_shadowBG);
         _progressBack1 = ComponentFactory.Instance.creatComponentByStylename("wonderful.accumulative.progressBack");
         PositionUtils.setPos(_progressBack1,"wonderful.Accumulative.ProgressBackPos1");
         _content.addChild(_progressBack1);
         _progressBack2 = ComponentFactory.Instance.creatComponentByStylename("wonderful.accumulative.progressBack");
         PositionUtils.setPos(_progressBack2,"wonderful.Accumulative.ProgressBackPos2");
         _content.addChild(_progressBack2);
         _itemList = ComponentFactory.Instance.creatCustomObject("wonderful.Accumulative.SimpleTileList",[5]);
         for(i = 1; i <= 10; )
         {
            item = new AccumulativeItem();
            item.buttonMode = true;
            item.initView(i);
            item.turnGray(true);
            item.box.addEventListener("click",__itemBoxClick);
            _itemList.addChild(item);
            _itemArr.push(item);
            i++;
         }
         _content.addChild(_itemList);
         _prizeBG = ComponentFactory.Instance.creat("wonderful.accumulative.prizeBG");
         _content.addChild(_prizeBG);
         _alreadyPayTxt = ComponentFactory.Instance.creatComponentByStylename("wonderful.accumulative.alreadyPayTxt");
         _alreadyPayTxt.text = LanguageMgr.GetTranslation("wonderful.accumulative.alreadyPayTxt");
         _content.addChild(_alreadyPayTxt);
         _alreadyPayValue = ComponentFactory.Instance.creatComponentByStylename("wonderful.accumulative.alreadyPayValue");
         _alreadyPayValue.text = "0";
         _content.addChild(_alreadyPayValue);
         _nextPrizeNeedTxt = ComponentFactory.Instance.creatComponentByStylename("wonderful.accumulative.nextPrizeNeedTxt");
         _nextPrizeNeedTxt.text = LanguageMgr.GetTranslation("wonderful.accumulative.nextPrizeNeedTxt");
         _content.addChild(_nextPrizeNeedTxt);
         _nextPrizeNeedValue = ComponentFactory.Instance.creatComponentByStylename("wonderful.accumulative.nextPrizeNeedValue");
         _nextPrizeNeedValue.text = "9999";
         _content.addChild(_nextPrizeNeedValue);
         _getPrizeBtn = ComponentFactory.Instance.creatComponentByStylename("wonderful.accumulative.getPrizeBtn");
         _getPrizeBtn.enable = false;
         _content.addChild(_getPrizeBtn);
         _progressList = ComponentFactory.Instance.creatCustomObject("wonderful.Accumulative.progressList",[4]);
         for(k = 1; k <= 8; )
         {
            progressLine = ComponentFactory.Instance.creatComponentByStylename("wonderful.accumulative.progress2");
            progressLine.visible = false;
            progressLine.addEventListener("rollOver",progressBackOver);
            progressLine.addEventListener("mouseMove",progressBackOver);
            progressLine.addEventListener("rollOut",progressBackOut);
            _progressList.addChild(progressLine);
            _progressArr.push(progressLine);
            k++;
         }
         _content.addChild(_progressList);
         _prizeList = ComponentFactory.Instance.creatComponentByStylename("wonderful.accumulative.Hbox");
         for(j = 1; j <= 7; )
         {
            prizeItem = new PrizeListItem();
            prizeItem.initView(j);
            _prizeList.addChild(prizeItem);
            _prizeArr.push(prizeItem);
            j++;
         }
         _content.addChild(_prizeList);
         _prizeList.refreshChildPos();
         _tip = new OneLineTip();
         _tip.visible = false;
         _content.addChild(_tip);
         addChild(_content);
      }
      
      private function initData() : void
      {
         var i:int = 0;
         var j:int = 0;
         var key:* = null;
         var selectableIndex:int = 0;
         if(!checkData())
         {
            return;
         }
         var giftArr:Array = activityData[actId].giftbagArray;
         for(i = 0; i <= giftArr.length - 1; )
         {
            if(accPayValue >= giftArr[i].giftConditionArr[0].conditionValue)
            {
               (_itemArr[i] as AccumulativeItem).turnGray(false);
               (_itemArr[i] as AccumulativeItem).glint(true);
               (_itemArr[i] as AccumulativeItem).setNumber(giftArr[i].giftConditionArr[0].conditionValue);
               (_itemArr[i] as AccumulativeItem).lightProgressPoint();
               index = i;
            }
            i++;
         }
         var lastGetIndex:* = -1;
         for(j = 0; j <= index; )
         {
            key = giftArr[j].giftbagId;
            if(giftCurInfoDic[key].times > 0)
            {
               (_itemArr[j] as AccumulativeItem).glint(false);
            }
            else
            {
               lastGetIndex = j;
               _getPrizeBtn.enable = true;
            }
            j++;
         }
         if(lastGetIndex >= 0)
         {
            (_itemArr[lastGetIndex] as AccumulativeItem).turnLight(true);
            showGift(lastGetIndex);
         }
         else
         {
            selectableIndex = index + 1 <= _itemArr.length - 1?index + 1:index;
            (_itemArr[selectableIndex] as AccumulativeItem).turnLight(true);
            showGift(selectableIndex);
         }
         if(index + 1 <= giftArr.length - 1)
         {
            (_itemArr[index + 1] as AccumulativeItem).setNumber(giftArr[index + 1].giftConditionArr[0].conditionValue);
            _nextPrizeNeedValue.text = (giftArr[index + 1].giftConditionArr[0].conditionValue - accPayValue).toString();
         }
         else
         {
            _nextPrizeNeedValue.text = "0";
         }
         _alreadyPayValue.text = accPayValue.toString();
         showProgress(index);
         _tip.tipData = accPayValue.toString();
      }
      
      private function checkData() : Boolean
      {
         activityData = WonderfulActivityManager.Instance.activityData;
         activityInitData = WonderfulActivityManager.Instance.activityInitData;
         var _loc3_:int = 0;
         var _loc2_:* = activityData;
         for each(var data in activityData)
         {
            if(data.activityType == 0 && data.activityChildType == 3)
            {
               actId = data.activityId;
               break;
            }
         }
         if(actId == null || activityData[actId] == null)
         {
            return false;
         }
         if(activityInitData[actId] != null)
         {
            accPayValue = activityInitData[actId].statusArr[0].statusValue;
            giftCurInfoDic = activityInitData[actId].giftInfoDic;
         }
         return true;
      }
      
      private function initEvent() : void
      {
         _getPrizeBtn.addEventListener("click",__GetPrizeBtnClick);
      }
      
      private function progressBackOver(event:MouseEvent) : void
      {
         _tip.visible = true;
         _tip.x = _content.mouseX;
         _tip.y = _content.mouseY;
      }
      
      private function progressBackOut(event:MouseEvent) : void
      {
         _tip.visible = false;
      }
      
      private function showProgress(num:int) : void
      {
         var i:int = 0;
         var value:int = 0;
         var nextValue:int = 0;
         var pencent:Number = NaN;
         if(num < 0)
         {
            return;
         }
         var tmp:int = -1;
         for(i = 0; i <= num; )
         {
            tmp++;
            if(i == 4 || i == 9)
            {
               tmp--;
            }
            _progressArr[tmp].visible = true;
            i++;
         }
         var arr:Array = activityData[actId].giftbagArray;
         if(num == 4 || num == 9 || num + 1 >= arr.length || tmp <= 0)
         {
            return;
         }
         value = arr[num].giftConditionArr[0].conditionValue;
         nextValue = arr[num + 1].giftConditionArr[0].conditionValue;
         pencent = (accPayValue - value) / (nextValue - value);
         (_progressArr[tmp] as ScaleBitmapImage).scaleX = pencent;
      }
      
      private function showGift(num:int) : void
      {
         var i:int = 0;
         var gift:* = null;
         if(num < 0 || num > activityData[actId].giftbagArray.length - 1)
         {
            return;
         }
         var vec:Vector.<GiftRewardInfo> = activityData[actId].giftbagArray[num].giftRewardArr;
         clearPrizeArr();
         for(i = 0; i <= vec.length - 1; )
         {
            gift = vec[i] as GiftRewardInfo;
            _prizeArr[i].setCellData(gift);
            i++;
         }
      }
      
      private function clearPrizeArr() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _prizeArr;
         for each(var item in _prizeArr)
         {
            item.setCellData(null);
         }
      }
      
      private function __GetPrizeBtnClick(event:MouseEvent) : void
      {
         var i:int = 0;
         var j:int = 0;
         var getAwardInfo:SendGiftInfo = new SendGiftInfo();
         getAwardInfo.activityId = actId;
         var bagArr:Array = activityData[actId].giftbagArray;
         var tmpArr:Array = [];
         for(i = 0; i <= bagArr.length - 1; )
         {
            tmpArr.push(bagArr[i].giftbagId);
            i++;
         }
         getAwardInfo.giftIdArr = tmpArr;
         var data:Vector.<SendGiftInfo> = new Vector.<SendGiftInfo>();
         data.push(getAwardInfo);
         SocketManager.Instance.out.sendWonderfulActivityGetReward(data);
         for(j = 0; j <= index; )
         {
            _itemArr[j].glint(false);
            j++;
         }
         _getPrizeBtn.enable = false;
      }
      
      private function __itemBoxClick(event:MouseEvent) : void
      {
         var i:int = 0;
         var item:AccumulativeItem = event.target.parent as AccumulativeItem;
         var selectableIndex:int = index + 1 < _itemArr.length?index + 1:index;
         if(item.index - 1 <= selectableIndex)
         {
            for(i = 0; i <= selectableIndex; )
            {
               (_itemArr[i] as AccumulativeItem).turnLight(false);
               i++;
            }
            item.turnLight(true);
            showGift(item.index - 1);
         }
      }
      
      private function removeEvents() : void
      {
         var i:int = 0;
         var j:int = 0;
         _getPrizeBtn.removeEventListener("click",__GetPrizeBtnClick);
         for(i = 0; i <= _itemArr.length - 1; )
         {
            _itemArr[i].box.removeEventListener("click",__itemBoxClick);
            i++;
         }
         for(j = 0; j <= _progressArr.length - 1; )
         {
            _progressArr[j].removeEventListener("rollOver",progressBackOver);
            _progressArr[j].removeEventListener("mouseMove",progressBackOver);
            _progressArr[j].removeEventListener("rollOut",progressBackOut);
            j++;
         }
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         var j:int = 0;
         var k:int = 0;
         removeEvents();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_title)
         {
            ObjectUtils.disposeObject(_title);
         }
         _title = null;
         if(_shadowBG)
         {
            ObjectUtils.disposeObject(_shadowBG);
         }
         _shadowBG = null;
         if(_progressBack1)
         {
            ObjectUtils.disposeObject(_progressBack1);
         }
         _progressBack1 = null;
         if(_progressBack2)
         {
            ObjectUtils.disposeObject(_progressBack2);
         }
         _progressBack2 = null;
         if(_prizeBG)
         {
            ObjectUtils.disposeObject(_prizeBG);
         }
         _prizeBG = null;
         if(_alreadyPayTxt)
         {
            ObjectUtils.disposeObject(_alreadyPayTxt);
         }
         _alreadyPayTxt = null;
         if(_alreadyPayValue)
         {
            ObjectUtils.disposeObject(_alreadyPayValue);
         }
         _alreadyPayValue = null;
         if(_nextPrizeNeedTxt)
         {
            ObjectUtils.disposeObject(_nextPrizeNeedTxt);
         }
         _nextPrizeNeedTxt = null;
         if(_nextPrizeNeedValue)
         {
            ObjectUtils.disposeObject(_nextPrizeNeedValue);
         }
         _nextPrizeNeedValue = null;
         if(_getPrizeBtn)
         {
            ObjectUtils.disposeObject(_getPrizeBtn);
         }
         _getPrizeBtn = null;
         if(_itemList)
         {
            ObjectUtils.disposeObject(_itemList);
         }
         _itemList = null;
         if(_prizeList)
         {
            ObjectUtils.disposeObject(_prizeList);
         }
         _prizeList = null;
         for(i = 0; i <= _itemArr.length - 1; )
         {
            if(_itemArr[i])
            {
               ObjectUtils.disposeObject(_itemArr[i]);
            }
            _itemArr[i] = null;
            i++;
         }
         if(_progressList)
         {
            ObjectUtils.disposeObject(_progressList);
         }
         _progressList = null;
         for(j = 0; j <= _progressArr.length - 1; )
         {
            if(_progressArr[j])
            {
               ObjectUtils.disposeObject(_progressArr[j]);
            }
            _progressArr[j] = null;
            j++;
         }
         for(k = 0; k <= _prizeArr.length - 1; )
         {
            if(_prizeArr[k])
            {
               ObjectUtils.disposeObject(_prizeArr[k]);
            }
            _prizeArr[k] = null;
            k++;
         }
         if(_tip)
         {
            ObjectUtils.disposeObject(_tip);
         }
         _tip = null;
         if(_content)
         {
            ObjectUtils.disposeObject(_content);
         }
         _content = null;
      }
      
      public function content() : Sprite
      {
         return this;
      }
      
      public function setState(type:int, id:int) : void
      {
      }
   }
}
