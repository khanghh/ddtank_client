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
         var _loc6_:int = 0;
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc1_:* = null;
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
         _loc6_ = 1;
         while(_loc6_ <= 10)
         {
            _loc2_ = new AccumulativeItem();
            _loc2_.buttonMode = true;
            _loc2_.initView(_loc6_);
            _loc2_.turnGray(true);
            _loc2_.box.addEventListener("click",__itemBoxClick);
            _itemList.addChild(_loc2_);
            _itemArr.push(_loc2_);
            _loc6_++;
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
         _loc5_ = 1;
         while(_loc5_ <= 8)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("wonderful.accumulative.progress2");
            _loc3_.visible = false;
            _loc3_.addEventListener("rollOver",progressBackOver);
            _loc3_.addEventListener("mouseMove",progressBackOver);
            _loc3_.addEventListener("rollOut",progressBackOut);
            _progressList.addChild(_loc3_);
            _progressArr.push(_loc3_);
            _loc5_++;
         }
         _content.addChild(_progressList);
         _prizeList = ComponentFactory.Instance.creatComponentByStylename("wonderful.accumulative.Hbox");
         _loc4_ = 1;
         while(_loc4_ <= 7)
         {
            _loc1_ = new PrizeListItem();
            _loc1_.initView(_loc4_);
            _prizeList.addChild(_loc1_);
            _prizeArr.push(_loc1_);
            _loc4_++;
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
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc2_:int = 0;
         if(!checkData())
         {
            return;
         }
         var _loc1_:Array = activityData[actId].giftbagArray;
         _loc6_ = 0;
         while(_loc6_ <= _loc1_.length - 1)
         {
            if(accPayValue >= _loc1_[_loc6_].giftConditionArr[0].conditionValue)
            {
               (_itemArr[_loc6_] as AccumulativeItem).turnGray(false);
               (_itemArr[_loc6_] as AccumulativeItem).glint(true);
               (_itemArr[_loc6_] as AccumulativeItem).setNumber(_loc1_[_loc6_].giftConditionArr[0].conditionValue);
               (_itemArr[_loc6_] as AccumulativeItem).lightProgressPoint();
               index = _loc6_;
            }
            _loc6_++;
         }
         var _loc5_:* = -1;
         _loc3_ = 0;
         while(_loc3_ <= index)
         {
            _loc4_ = _loc1_[_loc3_].giftbagId;
            if(giftCurInfoDic[_loc4_].times > 0)
            {
               (_itemArr[_loc3_] as AccumulativeItem).glint(false);
            }
            else
            {
               _loc5_ = _loc3_;
               _getPrizeBtn.enable = true;
            }
            _loc3_++;
         }
         if(_loc5_ >= 0)
         {
            (_itemArr[_loc5_] as AccumulativeItem).turnLight(true);
            showGift(_loc5_);
         }
         else
         {
            _loc2_ = index + 1 <= _itemArr.length - 1?index + 1:index;
            (_itemArr[_loc2_] as AccumulativeItem).turnLight(true);
            showGift(_loc2_);
         }
         if(index + 1 <= _loc1_.length - 1)
         {
            (_itemArr[index + 1] as AccumulativeItem).setNumber(_loc1_[index + 1].giftConditionArr[0].conditionValue);
            _nextPrizeNeedValue.text = (_loc1_[index + 1].giftConditionArr[0].conditionValue - accPayValue).toString();
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
         for each(var _loc1_ in activityData)
         {
            if(_loc1_.activityType == 0 && _loc1_.activityChildType == 3)
            {
               actId = _loc1_.activityId;
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
      
      private function progressBackOver(param1:MouseEvent) : void
      {
         _tip.visible = true;
         _tip.x = _content.mouseX;
         _tip.y = _content.mouseY;
      }
      
      private function progressBackOut(param1:MouseEvent) : void
      {
         _tip.visible = false;
      }
      
      private function showProgress(param1:int) : void
      {
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Number = NaN;
         if(param1 < 0)
         {
            return;
         }
         var _loc4_:int = -1;
         _loc7_ = 0;
         while(_loc7_ <= param1)
         {
            _loc4_++;
            if(_loc7_ == 4 || _loc7_ == 9)
            {
               _loc4_--;
            }
            _progressArr[_loc4_].visible = true;
            _loc7_++;
         }
         var _loc2_:Array = activityData[actId].giftbagArray;
         if(param1 == 4 || param1 == 9 || param1 + 1 >= _loc2_.length || _loc4_ <= 0)
         {
            return;
         }
         _loc3_ = _loc2_[param1].giftConditionArr[0].conditionValue;
         _loc5_ = _loc2_[param1 + 1].giftConditionArr[0].conditionValue;
         _loc6_ = (accPayValue - _loc3_) / (_loc5_ - _loc3_);
         (_progressArr[_loc4_] as ScaleBitmapImage).scaleX = _loc6_;
      }
      
      private function showGift(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         if(param1 < 0 || param1 > activityData[actId].giftbagArray.length - 1)
         {
            return;
         }
         var _loc4_:Vector.<GiftRewardInfo> = activityData[actId].giftbagArray[param1].giftRewardArr;
         clearPrizeArr();
         _loc3_ = 0;
         while(_loc3_ <= _loc4_.length - 1)
         {
            _loc2_ = _loc4_[_loc3_] as GiftRewardInfo;
            _prizeArr[_loc3_].setCellData(_loc2_);
            _loc3_++;
         }
      }
      
      private function clearPrizeArr() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _prizeArr;
         for each(var _loc1_ in _prizeArr)
         {
            _loc1_.setCellData(null);
         }
      }
      
      private function __GetPrizeBtnClick(param1:MouseEvent) : void
      {
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:SendGiftInfo = new SendGiftInfo();
         _loc7_.activityId = actId;
         var _loc5_:Array = activityData[actId].giftbagArray;
         var _loc3_:Array = [];
         _loc6_ = 0;
         while(_loc6_ <= _loc5_.length - 1)
         {
            _loc3_.push(_loc5_[_loc6_].giftbagId);
            _loc6_++;
         }
         _loc7_.giftIdArr = _loc3_;
         var _loc2_:Vector.<SendGiftInfo> = new Vector.<SendGiftInfo>();
         _loc2_.push(_loc7_);
         SocketManager.Instance.out.sendWonderfulActivityGetReward(_loc2_);
         _loc4_ = 0;
         while(_loc4_ <= index)
         {
            _itemArr[_loc4_].glint(false);
            _loc4_++;
         }
         _getPrizeBtn.enable = false;
      }
      
      private function __itemBoxClick(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:AccumulativeItem = param1.target.parent as AccumulativeItem;
         var _loc3_:int = index + 1 < _itemArr.length?index + 1:index;
         if(_loc2_.index - 1 <= _loc3_)
         {
            _loc4_ = 0;
            while(_loc4_ <= _loc3_)
            {
               (_itemArr[_loc4_] as AccumulativeItem).turnLight(false);
               _loc4_++;
            }
            _loc2_.turnLight(true);
            showGift(_loc2_.index - 1);
         }
      }
      
      private function removeEvents() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _getPrizeBtn.removeEventListener("click",__GetPrizeBtnClick);
         _loc2_ = 0;
         while(_loc2_ <= _itemArr.length - 1)
         {
            _itemArr[_loc2_].box.removeEventListener("click",__itemBoxClick);
            _loc2_++;
         }
         _loc1_ = 0;
         while(_loc1_ <= _progressArr.length - 1)
         {
            _progressArr[_loc1_].removeEventListener("rollOver",progressBackOver);
            _progressArr[_loc1_].removeEventListener("mouseMove",progressBackOver);
            _progressArr[_loc1_].removeEventListener("rollOut",progressBackOut);
            _loc1_++;
         }
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
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
         _loc3_ = 0;
         while(_loc3_ <= _itemArr.length - 1)
         {
            if(_itemArr[_loc3_])
            {
               ObjectUtils.disposeObject(_itemArr[_loc3_]);
            }
            _itemArr[_loc3_] = null;
            _loc3_++;
         }
         if(_progressList)
         {
            ObjectUtils.disposeObject(_progressList);
         }
         _progressList = null;
         _loc1_ = 0;
         while(_loc1_ <= _progressArr.length - 1)
         {
            if(_progressArr[_loc1_])
            {
               ObjectUtils.disposeObject(_progressArr[_loc1_]);
            }
            _progressArr[_loc1_] = null;
            _loc1_++;
         }
         _loc2_ = 0;
         while(_loc2_ <= _prizeArr.length - 1)
         {
            if(_prizeArr[_loc2_])
            {
               ObjectUtils.disposeObject(_prizeArr[_loc2_]);
            }
            _prizeArr[_loc2_] = null;
            _loc2_++;
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
      
      public function setState(param1:int, param2:int) : void
      {
      }
   }
}
