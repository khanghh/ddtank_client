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
      
      public function setState(param1:int, param2:int) : void
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
         var _loc3_:int = 0;
         var _loc1_:Date = TimeManager.Instance.Now();
         var _loc5_:int = 0;
         var _loc4_:* = WonderfulActivityManager.Instance.activityData;
         for each(var _loc2_ in WonderfulActivityManager.Instance.activityData)
         {
            if(!(_loc1_.time < Date.parse(_loc2_.beginTime) || _loc1_.time > Date.parse(_loc2_.endShowTime)))
            {
               if(_loc2_.activityType == 6 && _loc2_.activityChildType == 1)
               {
                  _activityInfo = _loc2_;
                  _loc3_ = 0;
                  while(_loc3_ <= _activityInfo.giftbagArray.length - 1)
                  {
                     if(_activityInfo.giftbagArray[_loc3_].rewardMark != 100 && (_giftCondition == 0 || _giftCondition > _activityInfo.giftbagArray[_loc3_].giftConditionArr[0].conditionValue))
                     {
                        _giftCondition = _activityInfo.giftbagArray[_loc3_].giftConditionArr[0].conditionValue;
                        _giftNeedMinId = _activityInfo.giftbagArray[_loc3_].giftbagId;
                     }
                     _loc3_++;
                  }
                  if(WonderfulActivityManager.Instance.activityInitData[_loc2_.activityId])
                  {
                     _giftInfoDic = WonderfulActivityManager.Instance.activityInitData[_loc2_.activityId]["giftInfoDic"];
                     _statusArr = WonderfulActivityManager.Instance.activityInitData[_loc2_.activityId]["statusArr"];
                  }
               }
            }
         }
      }
      
      private function initViewWithData() : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:* = null;
         if(!_activityInfo)
         {
            return;
         }
         var _loc3_:Array = [_activityInfo.beginTime.split(" ")[0],_activityInfo.endTime.split(" ")[0]];
         _activityTimeTxt.text = _loc3_[0] + "-" + _loc3_[1];
         _contentTxt.text = _activityInfo.desc;
         changeBtnState();
         _loc4_ = 0;
         while(_loc4_ < _activityInfo.giftbagArray.length)
         {
            if(_activityInfo.giftbagArray[_loc4_].rewardMark != 100)
            {
               _loc2_ = 0;
               while(_loc2_ < _activityInfo.giftbagArray[_loc4_].giftRewardArr.length)
               {
                  _loc1_ = createBagCell(0,_activityInfo.giftbagArray[_loc4_].giftRewardArr[_loc2_]);
                  _hbox.addChild(_loc1_);
                  _loc2_++;
               }
            }
            _loc4_++;
         }
      }
      
      private function createBagCell(param1:int, param2:GiftRewardInfo) : BagCell
      {
         var _loc5_:InventoryItemInfo = new InventoryItemInfo();
         _loc5_.TemplateID = param2.templateId;
         _loc5_ = ItemManager.fill(_loc5_);
         _loc5_.IsBinds = param2.isBind;
         _loc5_.ValidDate = param2.validDate;
         var _loc4_:Array = param2.property.split(",");
         _loc5_.StrengthenLevel = parseInt(_loc4_[0]);
         _loc5_.AttackCompose = parseInt(_loc4_[1]);
         _loc5_.DefendCompose = parseInt(_loc4_[2]);
         _loc5_.AgilityCompose = parseInt(_loc4_[3]);
         _loc5_.LuckCompose = parseInt(_loc4_[4]);
         if(EquipType.isMagicStone(_loc5_.CategoryID))
         {
            _loc5_.Level = _loc5_.StrengthenLevel;
            _loc5_.Attack = _loc5_.AttackCompose;
            _loc5_.Defence = _loc5_.DefendCompose;
            _loc5_.Agility = _loc5_.AgilityCompose;
            _loc5_.Luck = _loc5_.LuckCompose;
            _loc5_.MagicAttack = parseInt(_loc4_[6]);
            _loc5_.MagicDefence = parseInt(_loc4_[7]);
            _loc5_.StrengthenExp = parseInt(_loc4_[8]);
         }
         var _loc3_:BagCell = new BagCell(param1);
         _loc3_.info = _loc5_;
         _loc3_.setCount(param2.count);
         _loc3_.setBgVisible(false);
         return _loc3_;
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
      
      protected function __getAwardHandler(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         SoundManager.instance.play("008");
         var _loc5_:Vector.<SendGiftInfo> = new Vector.<SendGiftInfo>();
         var _loc2_:SendGiftInfo = new SendGiftInfo();
         _loc2_.activityId = _activityInfo.activityId;
         var _loc4_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < _activityInfo.giftbagArray.length)
         {
            if(_activityInfo.giftbagArray[_loc3_].rewardMark != 100)
            {
               _loc4_.push(_activityInfo.giftbagArray[_loc3_].giftbagId);
            }
            _loc3_++;
         }
         _loc2_.giftIdArr = _loc4_;
         _loc5_.push(_loc2_);
         SocketManager.Instance.out.sendWonderfulActivityGetReward(_loc5_);
      }
      
      public function setData(param1:* = null) : void
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
