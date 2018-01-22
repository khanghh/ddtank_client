package carnivalActivity.view
{
   import bagAndInfo.cell.BagCell;
   import carnivalActivity.CarnivalActivityControl;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.GiftCurInfo;
   import wonderfulActivity.data.GiftRewardInfo;
   import wonderfulActivity.data.PlayerCurInfo;
   import wonderfulActivity.data.SendGiftInfo;
   
   public class CarnivalActivityItem extends Sprite implements Disposeable
   {
       
      
      protected var _bg:Bitmap;
      
      protected var _getBtn:BaseButton;
      
      protected var _giftCurInfo:GiftCurInfo;
      
      protected var _sumCount:int;
      
      protected var _allGiftAlreadyGetCount:int;
      
      protected var _playerAlreadyGetCount:int;
      
      protected var _condtion:int;
      
      protected var _currentCondtion:int;
      
      protected var _goodContent:Sprite;
      
      protected var _descTxt:FilterFrameText;
      
      protected var _awardCountTxt:FilterFrameText;
      
      protected var _type:int;
      
      protected var _info:GiftBagInfo;
      
      protected var _index:int;
      
      protected var _alreadyGetBtn:BaseButton;
      
      protected var _statusArr:Array;
      
      public function CarnivalActivityItem(param1:int, param2:GiftBagInfo, param3:int)
      {
         super();
         _type = param1;
         _info = param2;
         _index = param3;
         initData();
         initView();
         initItem();
         initEvent();
      }
      
      protected function initData() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _info.giftConditionArr.length)
         {
            if(_info.giftConditionArr[_loc1_].conditionIndex == 0)
            {
               _condtion = _info.giftConditionArr[_loc1_].conditionValue;
            }
            else if(_info.giftConditionArr[_loc1_].conditionIndex == 100)
            {
               _sumCount = _info.giftConditionArr[_loc1_].conditionValue;
            }
            _loc1_++;
         }
      }
      
      protected function initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:* = null;
         _bg = ComponentFactory.Instance.creat("carnicalAct.listItem" + _index);
         addChild(_bg);
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("carnivalAct.condtionTxt");
         addChild(_descTxt);
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("activity.receive.btn");
         addChild(_getBtn);
         _getBtn.enable = false;
         PositionUtils.setPos(_getBtn,"carnivalAct.getButtonPos");
         _alreadyGetBtn = ComponentFactory.Instance.creatComponentByStylename("activity.havaReceived.btn");
         addChild(_alreadyGetBtn);
         var _loc4_:Boolean = false;
         _alreadyGetBtn.visible = _loc4_;
         _alreadyGetBtn.enable = _loc4_;
         PositionUtils.setPos(_alreadyGetBtn,"carnivalAct.getButtonPos");
         _goodContent = new Sprite();
         addChild(_goodContent);
         _loc3_ = 0;
         while(_loc3_ < _info.giftRewardArr.length)
         {
            _loc1_ = createBagCell(0,_info.giftRewardArr[_loc3_]);
            _loc2_ = ComponentFactory.Instance.creat("wonderfulactivity.goods.back");
            _loc2_.x = (_loc2_.width + 5) * _loc3_;
            _loc1_.x = _loc2_.width / 2 - _loc1_.width / 2 + _loc2_.x + 2;
            _loc1_.y = _loc2_.height / 2 - _loc1_.height / 2 + 1;
            _goodContent.addChild(_loc2_);
            _goodContent.addChild(_loc1_);
            _loc3_++;
         }
         _goodContent.x = 142;
         _goodContent.y = 7;
      }
      
      protected function initItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         if(_sumCount != 0)
         {
            _awardCountTxt = ComponentFactory.Instance.creatComponentByStylename("carnivalAct.countTxt");
            addChild(_awardCountTxt);
         }
         else
         {
            _descTxt.y = _descTxt.y + 9;
         }
         if(CarnivalActivityControl.instance.currentChildType == 10)
         {
            _loc2_ = int(_condtion / 10) + 1;
            _loc1_ = _condtion % 10;
            _descTxt.text = LanguageMgr.GetTranslation("carnival.descTxt" + CarnivalActivityControl.instance.currentChildType,_loc2_,_loc1_);
         }
         else if(CarnivalActivityControl.instance.currentChildType != 4)
         {
            _descTxt.text = LanguageMgr.GetTranslation("carnival.descTxt" + CarnivalActivityControl.instance.currentChildType,_condtion);
         }
      }
      
      protected function createBagCell(param1:int, param2:GiftRewardInfo) : BagCell
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
      
      public function updateView() : void
      {
         _giftCurInfo = WonderfulActivityManager.Instance.activityInitData[_info.activityId].giftInfoDic[_info.giftbagId];
         _statusArr = WonderfulActivityManager.Instance.activityInitData[_info.activityId].statusArr;
         _playerAlreadyGetCount = _giftCurInfo.times;
         _allGiftAlreadyGetCount = _giftCurInfo.allGiftGetTimes;
         _currentCondtion = _statusArr[0].statusValue;
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         if(CarnivalActivityControl.instance.currentChildType == 10)
         {
            var _loc5_:int = 0;
            var _loc4_:* = _statusArr;
            for each(var _loc3_ in _statusArr)
            {
               if(_loc3_.statusID == 0)
               {
                  _loc2_ = _loc3_.statusValue;
               }
               else if(_loc3_.statusID == 1)
               {
                  _loc1_ = _loc3_.statusValue;
               }
            }
            _getBtn.enable = CarnivalActivityControl.instance.canGetAward() && _playerAlreadyGetCount == 0 && _condtion > _loc2_ && _condtion <= _loc1_ && (_sumCount == 0 || _sumCount - _allGiftAlreadyGetCount > 0);
         }
         else
         {
            _getBtn.enable = CarnivalActivityControl.instance.canGetAward() && _playerAlreadyGetCount == 0 && _currentCondtion >= _condtion && (_sumCount == 0 || _sumCount - _allGiftAlreadyGetCount > 0);
         }
         if(_awardCountTxt)
         {
            _awardCountTxt.text = LanguageMgr.GetTranslation("carnival.awardCountTxt") + (_sumCount - _allGiftAlreadyGetCount);
         }
         _alreadyGetBtn.visible = _playerAlreadyGetCount > 0;
         _getBtn.visible = !_alreadyGetBtn.visible;
      }
      
      protected function initEvent() : void
      {
         _getBtn.addEventListener("click",__getAwardHandler);
      }
      
      protected function __getAwardHandler(param1:MouseEvent) : void
      {
         if(getTimer() - CarnivalActivityControl.instance.lastClickTime < 2000)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("carnival.clickTip"));
            return;
         }
         CarnivalActivityControl.instance.lastClickTime = getTimer();
         SoundManager.instance.playButtonSound();
         var _loc2_:Vector.<SendGiftInfo> = new Vector.<SendGiftInfo>();
         var _loc3_:SendGiftInfo = new SendGiftInfo();
         _loc3_.activityId = _info.activityId;
         _loc3_.giftIdArr = [_info.giftbagId];
         _loc3_.awardCount = 1 - _playerAlreadyGetCount;
         _loc2_.push(_loc3_);
         SocketManager.Instance.out.sendWonderfulActivityGetReward(_loc2_);
      }
      
      protected function removeEvent() : void
      {
         _getBtn.removeEventListener("click",__getAwardHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         while(_goodContent.numChildren)
         {
            ObjectUtils.disposeObject(_goodContent.getChildAt(0));
         }
         _goodContent = null;
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         _getBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
