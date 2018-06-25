package wonderfulActivity.items
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GiftRewardInfo;
   import wonderfulActivity.data.GmActivityInfo;
   import wonderfulActivity.data.SendGiftInfo;
   import wonderfulActivity.views.IRightView;
   
   public class JoinIsPowerView extends Sprite implements IRightView
   {
       
      
      private var _back:Bitmap;
      
      private var _activityTimeTxt:FilterFrameText;
      
      private var _contentTxt:FilterFrameText;
      
      private var _getButton:SimpleBitmapButton;
      
      private var _activityInfo:GmActivityInfo;
      
      private var _giftInfoDic:Dictionary;
      
      private var _statusArr:Array;
      
      private var _giftCondition:int;
      
      private var _giftNeedMinId:String;
      
      private var _hbox:HBox;
      
      public function JoinIsPowerView()
      {
         super();
      }
      
      public function init() : void
      {
         initView();
         initData();
         initViewWithData();
      }
      
      public function setState(type:int, id:int) : void
      {
      }
      
      public function content() : Sprite
      {
         return this;
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creat("wonderfulactivity.tuanjie.back");
         addChild(_back);
         _activityTimeTxt = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.right.activetimeTxt");
         addChild(_activityTimeTxt);
         PositionUtils.setPos(_activityTimeTxt,"wonderful.joinispower.activetime.pos");
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.right.joinIsPowerContentTxt");
         addChild(_contentTxt);
         _getButton = ComponentFactory.Instance.creatComponentByStylename("wonderful.ActivityState.GetButton");
         addChild(_getButton);
         PositionUtils.setPos(_getButton,"wonderful.getButton.pos");
         _getButton.enable = false;
         _hbox = ComponentFactory.Instance.creatComponentByStylename("wonderful.joinIsPower.Hbox");
         addChild(_hbox);
      }
      
      private function initData() : void
      {
         var i:int = 0;
         var now:Date = TimeManager.Instance.Now();
         var _loc5_:int = 0;
         var _loc4_:* = WonderfulActivityManager.Instance.activityData;
         for each(var item in WonderfulActivityManager.Instance.activityData)
         {
            if(!(now.time < Date.parse(item.beginTime) || now.time > Date.parse(item.endShowTime)))
            {
               if(item.activityType == 6 && item.activityChildType == 1)
               {
                  _activityInfo = item;
                  for(i = 0; i <= _activityInfo.giftbagArray.length - 1; )
                  {
                     if(_activityInfo.giftbagArray[i].rewardMark != 100 && (_giftCondition == 0 || _giftCondition > _activityInfo.giftbagArray[i].giftConditionArr[0].conditionValue))
                     {
                        _giftCondition = _activityInfo.giftbagArray[i].giftConditionArr[0].conditionValue;
                        _giftNeedMinId = _activityInfo.giftbagArray[i].giftbagId;
                     }
                     i++;
                  }
                  if(WonderfulActivityManager.Instance.activityInitData[item.activityId])
                  {
                     _giftInfoDic = WonderfulActivityManager.Instance.activityInitData[item.activityId]["giftInfoDic"];
                     _statusArr = WonderfulActivityManager.Instance.activityInitData[item.activityId]["statusArr"];
                  }
               }
            }
         }
      }
      
      private function initViewWithData() : void
      {
         var i:int = 0;
         var j:int = 0;
         var bagCell:* = null;
         if(!_activityInfo)
         {
            return;
         }
         var timeArr:Array = [_activityInfo.beginTime.split(" ")[0],_activityInfo.endTime.split(" ")[0]];
         _activityTimeTxt.text = timeArr[0] + "-" + timeArr[1];
         _contentTxt.text = _activityInfo.desc;
         changeBtnState();
         for(i = 0; i < _activityInfo.giftbagArray.length; )
         {
            if(_activityInfo.giftbagArray[i].rewardMark != 100)
            {
               j = 0;
               while(j < _activityInfo.giftbagArray[i].giftRewardArr.length)
               {
                  bagCell = createBagCell(0,_activityInfo.giftbagArray[i].giftRewardArr[j]);
                  _hbox.addChild(bagCell);
                  j++;
               }
            }
            i++;
         }
      }
      
      private function createBagCell(order:int, gift:GiftRewardInfo) : BagCell
      {
         var info:InventoryItemInfo = new InventoryItemInfo();
         info.TemplateID = gift.templateId;
         info = ItemManager.fill(info);
         info.IsBinds = gift.isBind;
         info.ValidDate = gift.validDate;
         var attrArr:Array = gift.property.split(",");
         info.StrengthenLevel = parseInt(attrArr[0]);
         info.AttackCompose = parseInt(attrArr[1]);
         info.DefendCompose = parseInt(attrArr[2]);
         info.AgilityCompose = parseInt(attrArr[3]);
         info.LuckCompose = parseInt(attrArr[4]);
         if(EquipType.isMagicStone(info.CategoryID))
         {
            info.Level = info.StrengthenLevel;
            info.Attack = info.AttackCompose;
            info.Defence = info.DefendCompose;
            info.Agility = info.AgilityCompose;
            info.Luck = info.LuckCompose;
            info.MagicAttack = parseInt(attrArr[6]);
            info.MagicDefence = parseInt(attrArr[7]);
            info.StrengthenExp = parseInt(attrArr[8]);
         }
         var bagCell:BagCell = new BagCell(order);
         bagCell.info = info;
         bagCell.setCount(gift.count);
         bagCell.setBgVisible(false);
         return bagCell;
      }
      
      public function updateAwardState() : void
      {
         if(WonderfulActivityManager.Instance.activityInitData[_activityInfo.activityId])
         {
            _giftInfoDic = WonderfulActivityManager.Instance.activityInitData[_activityInfo.activityId]["giftInfoDic"];
            _statusArr = WonderfulActivityManager.Instance.activityInitData[_activityInfo.activityId]["statusArr"];
         }
         changeBtnState();
      }
      
      private function changeBtnState() : void
      {
         if(_giftInfoDic[_giftNeedMinId] && _statusArr[0].statusValue - _giftInfoDic[_giftNeedMinId].times * _giftCondition >= _giftCondition)
         {
            _getButton.enable = true;
            _getButton.addEventListener("click",__getAwardHandler);
         }
         else
         {
            _getButton.enable = false;
         }
      }
      
      protected function __getAwardHandler(event:MouseEvent) : void
      {
         var j:int = 0;
         SoundManager.instance.play("008");
         var sendInfoVec:Vector.<SendGiftInfo> = new Vector.<SendGiftInfo>();
         var sendInfo:SendGiftInfo = new SendGiftInfo();
         sendInfo.activityId = _activityInfo.activityId;
         var giftIdArr:Array = [];
         for(j = 0; j < _activityInfo.giftbagArray.length; )
         {
            if(_activityInfo.giftbagArray[j].rewardMark != 100)
            {
               giftIdArr.push(_activityInfo.giftbagArray[j].giftbagId);
            }
            j++;
         }
         sendInfo.giftIdArr = giftIdArr;
         sendInfoVec.push(sendInfo);
         SocketManager.Instance.out.sendWonderfulActivityGetReward(sendInfoVec);
      }
      
      public function setData(val:* = null) : void
      {
      }
      
      public function dispose() : void
      {
         _getButton.removeEventListener("click",__getAwardHandler);
         if(_back)
         {
            ObjectUtils.disposeObject(_back);
            _back = null;
         }
         if(_activityTimeTxt)
         {
            ObjectUtils.disposeObject(_activityTimeTxt);
            _activityTimeTxt = null;
         }
         if(_contentTxt)
         {
            ObjectUtils.disposeObject(_contentTxt);
            _contentTxt = null;
         }
         if(_getButton)
         {
            ObjectUtils.disposeObject(_getButton);
            _getButton = null;
         }
         if(_hbox)
         {
            ObjectUtils.disposeObject(_hbox);
            _hbox = null;
         }
         if(parent)
         {
            ObjectUtils.disposeObject(this);
         }
      }
   }
}
