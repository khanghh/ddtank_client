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
      
      public function CarnivalActivityItem(type:int, info:GiftBagInfo, index:int)
      {
         super();
         _type = type;
         _info = info;
         _index = index;
         initData();
         initView();
         initItem();
         initEvent();
      }
      
      protected function initData() : void
      {
         var i:int = 0;
         for(i = 0; i < _info.giftConditionArr.length; )
         {
            if(_info.giftConditionArr[i].conditionIndex == 0)
            {
               _condtion = _info.giftConditionArr[i].conditionValue;
            }
            else if(_info.giftConditionArr[i].conditionIndex == 100)
            {
               _sumCount = _info.giftConditionArr[i].conditionValue;
            }
            i++;
         }
      }
      
      protected function initView() : void
      {
         var i:int = 0;
         var bagCell:* = null;
         var back:* = null;
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
         for(i = 0; i < _info.giftRewardArr.length; )
         {
            bagCell = createBagCell(0,_info.giftRewardArr[i]);
            back = ComponentFactory.Instance.creat("wonderfulactivity.goods.back");
            back.x = (back.width + 5) * i;
            bagCell.x = back.width / 2 - bagCell.width / 2 + back.x + 2;
            bagCell.y = back.height / 2 - bagCell.height / 2 + 1;
            _goodContent.addChild(back);
            _goodContent.addChild(bagCell);
            i++;
         }
         _goodContent.x = 142;
         _goodContent.y = 7;
      }
      
      protected function initItem() : void
      {
         var horseGrade:int = 0;
         var horseStar:int = 0;
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
            horseGrade = int(_condtion / 10) + 1;
            horseStar = _condtion % 10;
            _descTxt.text = LanguageMgr.GetTranslation("carnival.descTxt" + CarnivalActivityControl.instance.currentChildType,horseGrade,horseStar);
         }
         else if(CarnivalActivityControl.instance.currentChildType != 4)
         {
            _descTxt.text = LanguageMgr.GetTranslation("carnival.descTxt" + CarnivalActivityControl.instance.currentChildType,_condtion);
         }
      }
      
      protected function createBagCell(order:int, gift:GiftRewardInfo) : BagCell
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
      
      public function updateView() : void
      {
         _giftCurInfo = WonderfulActivityManager.Instance.activityInitData[_info.activityId].giftInfoDic[_info.giftbagId];
         _statusArr = WonderfulActivityManager.Instance.activityInitData[_info.activityId].statusArr;
         _playerAlreadyGetCount = _giftCurInfo.times;
         _allGiftAlreadyGetCount = _giftCurInfo.allGiftGetTimes;
         _currentCondtion = _statusArr[0].statusValue;
         var grade:int = 0;
         var currentGrade:int = 0;
         if(CarnivalActivityControl.instance.currentChildType == 10)
         {
            var _loc5_:int = 0;
            var _loc4_:* = _statusArr;
            for each(var info in _statusArr)
            {
               if(info.statusID == 0)
               {
                  grade = info.statusValue;
               }
               else if(info.statusID == 1)
               {
                  currentGrade = info.statusValue;
               }
            }
            _getBtn.enable = CarnivalActivityControl.instance.canGetAward() && _playerAlreadyGetCount == 0 && _condtion > grade && _condtion <= currentGrade && (_sumCount == 0 || _sumCount - _allGiftAlreadyGetCount > 0);
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
      
      protected function __getAwardHandler(event:MouseEvent) : void
      {
         if(getTimer() - CarnivalActivityControl.instance.lastClickTime < 2000)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("carnival.clickTip"));
            return;
         }
         CarnivalActivityControl.instance.lastClickTime = getTimer();
         SoundManager.instance.playButtonSound();
         var sendInfoVec:Vector.<SendGiftInfo> = new Vector.<SendGiftInfo>();
         var info:SendGiftInfo = new SendGiftInfo();
         info.activityId = _info.activityId;
         info.giftIdArr = [_info.giftbagId];
         info.awardCount = 1 - _playerAlreadyGetCount;
         sendInfoVec.push(info);
         SocketManager.Instance.out.sendWonderfulActivityGetReward(sendInfoVec);
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
