package wonderfulActivity.items
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import road7th.utils.DateUtils;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.GiftConditionInfo;
   import wonderfulActivity.data.GiftRewardInfo;
   import wonderfulActivity.data.GmActivityInfo;
   import wonderfulActivity.data.PlayerCurInfo;
   import wonderfulActivity.data.SendGiftInfo;
   import wonderfulActivity.event.WonderfulActivityEvent;
   import wonderfulActivity.views.IRightView;
   
   public class DaySupplyAwardItem extends Sprite implements IRightView
   {
       
      
      private var _id:String;
      
      private var _activityInfo:GmActivityInfo;
      
      private var _data:Object;
      
      private var _bg:Bitmap;
      
      private var _coinsText:FilterFrameText;
      
      private var _totalText:FilterFrameText;
      
      private var _timeText:FilterFrameText;
      
      private var _getBtn:SimpleBitmapButton;
      
      private var _getImage:Bitmap;
      
      private var _hBox:HBox;
      
      public function DaySupplyAwardItem(param1:String = "")
      {
         _id = param1;
         super();
      }
      
      public function init() : void
      {
         _activityInfo = WonderfulActivityManager.Instance.activityData[_id];
         if(_activityInfo == null)
         {
            return;
         }
         PositionUtils.setPos(this,"wonderfulactivity.DaySupplyAwardItemPos");
         _bg = ComponentFactory.Instance.creatBitmap("wonderfulactivity.daySupplyAwardBg");
         addChild(_bg);
         _coinsText = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.daySupplyAward.coinsText");
         addChild(_coinsText);
         _totalText = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.daySupplyAward.totalText");
         addChild(_totalText);
         _timeText = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.daySupplyAward.timeText");
         addChild(_timeText);
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.getButton");
         _getBtn.addEventListener("click",__onClick);
         addChild(_getBtn);
         _getImage = ComponentFactory.Instance.creatBitmap("wonderfulactivity.getBg");
         addChild(_getImage);
         _hBox = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.daySupplyHBox");
         addChild(_hBox);
         WonderfulActivityManager.Instance.addEventListener("refresh",updateActivityData);
         updateActivityData();
      }
      
      private function __onClick(param1:MouseEvent) : void
      {
         var _loc4_:* = undefined;
         var _loc5_:* = null;
         SoundManager.instance.playButtonSound();
         if(_activityInfo == null || _activityInfo.giftbagArray == null)
         {
            return;
         }
         var _loc3_:PlayerCurInfo = _data.statusArr[_data.statusArr.length - 1];
         var _loc7_:int = 0;
         var _loc6_:* = _activityInfo.giftbagArray;
         for each(var _loc2_ in _activityInfo.giftbagArray)
         {
            if(_loc2_.giftbagOrder == _loc3_.statusID)
            {
               _loc4_ = new Vector.<SendGiftInfo>();
               _loc5_ = new SendGiftInfo();
               _loc5_.activityId = _activityInfo.activityId;
               _loc5_.giftIdArr = [_loc2_.giftbagId];
               _loc4_.push(_loc5_);
               SocketManager.Instance.out.sendWonderfulActivityGetReward(_loc4_);
               _getBtn.visible = false;
               _getImage.visible = true;
               return;
            }
         }
      }
      
      private function update() : void
      {
         var _loc9_:* = null;
         var _loc2_:* = null;
         var _loc6_:* = null;
         var _loc10_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc5_:* = null;
         var _loc3_:Number = NaN;
         _getImage.visible = false;
         _getBtn.visible = false;
         if(_data && _activityInfo)
         {
            _loc9_ = _data.statusArr;
            _loc2_ = _data.giftInfoDic;
            _loc6_ = _loc9_[_loc9_.length - 1];
            _totalText.text = LanguageMgr.GetTranslation("wonderful.daySupplyAwardTotal",_loc6_.statusValue);
            _hBox.clearAllChild();
            var _loc14_:int = 0;
            var _loc13_:* = _activityInfo.giftbagArray;
            for each(var _loc4_ in _activityInfo.giftbagArray)
            {
               if(_loc4_.giftbagOrder == _loc6_.statusID)
               {
                  _loc10_ = _loc4_.giftConditionArr[0];
                  _coinsText.text = _loc10_.conditionValue.toString();
                  var _loc12_:int = 0;
                  var _loc11_:* = _loc4_.giftRewardArr;
                  for each(var _loc1_ in _loc4_.giftRewardArr)
                  {
                     _loc7_ = ItemManager.fillByID(int(_loc1_.templateId));
                     _loc7_.Count = _loc1_.count;
                     _loc7_.IsBinds = _loc1_.isBind == 1;
                     _loc7_.ValidDate = _loc1_.validDate;
                     _loc8_ = ComponentFactory.Instance.creatBitmap("wonderfulactivity.goods.back");
                     _loc5_ = new BagCell(0,_loc7_,false,_loc8_);
                     _hBox.addChild(_loc5_);
                  }
                  if(_loc2_[_loc10_.giftbagId] && _loc2_[_loc10_.giftbagId].times >= 1)
                  {
                     _getImage.visible = true;
                     _getBtn.visible = false;
                  }
                  else
                  {
                     _getImage.visible = false;
                     _getBtn.visible = true;
                     if(_loc6_.statusValue >= _loc10_.conditionValue)
                     {
                        _getBtn.enable = true;
                     }
                     else
                     {
                        _getBtn.enable = false;
                     }
                  }
                  break;
               }
            }
            _loc3_ = DateUtils.getDateByStr(_activityInfo.endTime).getTime() - TimeManager.Instance.NowTime();
            if(_loc3_ <= 3600000)
            {
               _timeText.text = LanguageMgr.GetTranslation("wonderful.daySupplyAwardLackTime");
            }
            else if(_loc3_ <= 86400000)
            {
               _timeText.text = LanguageMgr.GetTranslation("wonderful.daySupplyAwardTime",int(_loc3_ / 3600000));
            }
            else
            {
               _timeText.text = LanguageMgr.GetTranslation("wonderful.daySupplyAwardGreaterTime",int(_loc3_ / 86400000));
            }
         }
      }
      
      public function updateActivityData(param1:WonderfulActivityEvent = null) : void
      {
         _data = WonderfulActivityManager.Instance.activityInitData[_id];
         update();
      }
      
      public function dispose() : void
      {
         WonderfulActivityManager.Instance.removeEventListener("refresh",updateActivityData);
         _data = null;
         _activityInfo = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_coinsText);
         _coinsText = null;
         ObjectUtils.disposeObject(_totalText);
         _totalText = null;
         ObjectUtils.disposeObject(_timeText);
         _timeText = null;
         if(_getBtn)
         {
            _getBtn.removeEventListener("click",__onClick);
         }
         ObjectUtils.disposeObject(_getBtn);
         _getBtn = null;
         ObjectUtils.disposeObject(_getImage);
         _getImage = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
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
