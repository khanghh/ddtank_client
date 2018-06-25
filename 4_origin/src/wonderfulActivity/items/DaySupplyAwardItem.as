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
      
      public function DaySupplyAwardItem($id:String = "")
      {
         _id = $id;
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
      
      private function __onClick(e:MouseEvent) : void
      {
         var sendInfoVec:* = undefined;
         var info:* = null;
         SoundManager.instance.playButtonSound();
         if(_activityInfo == null || _activityInfo.giftbagArray == null)
         {
            return;
         }
         var playerStatus:PlayerCurInfo = _data.statusArr[_data.statusArr.length - 1];
         var _loc7_:int = 0;
         var _loc6_:* = _activityInfo.giftbagArray;
         for each(var giftInfo in _activityInfo.giftbagArray)
         {
            if(giftInfo.giftbagOrder == playerStatus.statusID)
            {
               sendInfoVec = new Vector.<SendGiftInfo>();
               info = new SendGiftInfo();
               info.activityId = _activityInfo.activityId;
               info.giftIdArr = [giftInfo.giftbagId];
               sendInfoVec.push(info);
               SocketManager.Instance.out.sendWonderfulActivityGetReward(sendInfoVec);
               _getBtn.visible = false;
               _getImage.visible = true;
               return;
            }
         }
      }
      
      private function update() : void
      {
         var statusArr:* = null;
         var giftInfoDic:* = null;
         var playerStatus:* = null;
         var conditionInfo:* = null;
         var itemInfo:* = null;
         var cellBg:* = null;
         var cell:* = null;
         var time:Number = NaN;
         _getImage.visible = false;
         _getBtn.visible = false;
         if(_data && _activityInfo)
         {
            statusArr = _data.statusArr;
            giftInfoDic = _data.giftInfoDic;
            playerStatus = statusArr[statusArr.length - 1];
            _totalText.text = LanguageMgr.GetTranslation("wonderful.daySupplyAwardTotal",playerStatus.statusValue);
            _hBox.clearAllChild();
            var _loc14_:int = 0;
            var _loc13_:* = _activityInfo.giftbagArray;
            for each(var giftInfo in _activityInfo.giftbagArray)
            {
               if(giftInfo.giftbagOrder == playerStatus.statusID)
               {
                  conditionInfo = giftInfo.giftConditionArr[0];
                  _coinsText.text = conditionInfo.conditionValue.toString();
                  var _loc12_:int = 0;
                  var _loc11_:* = giftInfo.giftRewardArr;
                  for each(var rewardInfo in giftInfo.giftRewardArr)
                  {
                     itemInfo = ItemManager.fillByID(int(rewardInfo.templateId));
                     itemInfo.Count = rewardInfo.count;
                     itemInfo.IsBinds = rewardInfo.isBind == 1;
                     itemInfo.ValidDate = rewardInfo.validDate;
                     cellBg = ComponentFactory.Instance.creatBitmap("wonderfulactivity.goods.back");
                     cell = new BagCell(0,itemInfo,false,cellBg);
                     _hBox.addChild(cell);
                  }
                  if(giftInfoDic[conditionInfo.giftbagId] && giftInfoDic[conditionInfo.giftbagId].times >= 1)
                  {
                     _getImage.visible = true;
                     _getBtn.visible = false;
                  }
                  else
                  {
                     _getImage.visible = false;
                     _getBtn.visible = true;
                     if(playerStatus.statusValue >= conditionInfo.conditionValue)
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
            time = DateUtils.getDateByStr(_activityInfo.endTime).getTime() - TimeManager.Instance.NowTime();
            if(time <= 3600000)
            {
               _timeText.text = LanguageMgr.GetTranslation("wonderful.daySupplyAwardLackTime");
            }
            else if(time <= 86400000)
            {
               _timeText.text = LanguageMgr.GetTranslation("wonderful.daySupplyAwardTime",int(time / 3600000));
            }
            else
            {
               _timeText.text = LanguageMgr.GetTranslation("wonderful.daySupplyAwardGreaterTime",int(time / 86400000));
            }
         }
      }
      
      public function updateActivityData(event:WonderfulActivityEvent = null) : void
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
      
      public function setState(type:int, id:int) : void
      {
      }
   }
}
