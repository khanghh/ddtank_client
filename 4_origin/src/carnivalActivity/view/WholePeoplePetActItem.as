package carnivalActivity.view
{
   import carnivalActivity.CarnivalActivityControl;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.PlayerCurInfo;
   import wonderfulActivity.data.SendGiftInfo;
   
   public class WholePeoplePetActItem extends CarnivalActivityItem
   {
       
      
      private var _selfNeedPetNum:int = -1;
      
      private var _selfNeedPetStar:int;
      
      private var _personNeedPetNum:int = -1;
      
      private var _personNeedPetStar:int;
      
      private var _addedNeedPetNum:int = -1;
      
      private var _addedNeedPetStar:int;
      
      private var _getCount:int = -1;
      
      private var _addedIsSuperPet:Boolean;
      
      private var _personIsSuperPet:Boolean;
      
      private var _selfIsSuperPet:Boolean;
      
      private var _btnTxt:FilterFrameText;
      
      private var _tipsBtn:Bitmap;
      
      private var _tipStr:String = "";
      
      private var _tipSp:WholePeopleTipSp;
      
      private var _awardCount:int;
      
      public function WholePeoplePetActItem(type:int, info:GiftBagInfo, index:int)
      {
         super(type,info,index);
      }
      
      override protected function initItem() : void
      {
         var j:int = 0;
         var i:int = 0;
         var temp:int = 0;
         var selfTemp:int = 0;
         _awardCountTxt = ComponentFactory.Instance.creatComponentByStylename("carnivalAct.countTxt");
         addChild(_awardCountTxt);
         for(j = 0; j < _info.giftConditionArr.length; )
         {
            if(_info.giftConditionArr[j].conditionIndex == 4)
            {
               _selfIsSuperPet = true;
            }
            else if(_info.giftConditionArr[j].conditionIndex == 5)
            {
               _personIsSuperPet = true;
            }
            else if(_info.giftConditionArr[j].conditionIndex == 6)
            {
               _addedIsSuperPet = true;
            }
            j++;
         }
         for(i = 0; i < _info.giftConditionArr.length; )
         {
            if(_info.giftConditionArr[i].conditionIndex == (!!_selfIsSuperPet?4:0))
            {
               _selfNeedPetStar = _info.giftConditionArr[i].conditionValue;
               _selfNeedPetNum = _info.giftConditionArr[i].remain1;
            }
            else if(_info.giftConditionArr[i].conditionIndex == (!!_personIsSuperPet?5:1))
            {
               _personNeedPetStar = _info.giftConditionArr[i].conditionValue;
               _personNeedPetNum = _info.giftConditionArr[i].remain1;
            }
            else if(_info.giftConditionArr[i].conditionIndex == (!!_addedIsSuperPet?6:2))
            {
               _addedNeedPetStar = _info.giftConditionArr[i].conditionValue;
               _addedNeedPetNum = _info.giftConditionArr[i].remain1;
            }
            else if(_info.giftConditionArr[i].conditionIndex == 3)
            {
               _getCount = _info.giftConditionArr[i].conditionValue;
            }
            i++;
         }
         var desc:String = "";
         if(_addedNeedPetNum != -1)
         {
            temp = !!_addedIsSuperPet?6:3;
            selfTemp = !!_selfIsSuperPet?6:3;
            desc = LanguageMgr.GetTranslation("wholePeople.pet.descTxt" + temp,_addedNeedPetNum,!!_addedIsSuperPet?_addedNeedPetStar - 10:_addedNeedPetStar);
            if(_selfNeedPetNum != -1)
            {
               _tipStr = LanguageMgr.GetTranslation("wholePeople.pet.tipTxt" + selfTemp,_selfNeedPetNum,!!_selfIsSuperPet?_selfNeedPetStar - 10:_selfNeedPetStar);
            }
         }
         else if(_personNeedPetNum != -1)
         {
            temp = !!_personIsSuperPet?5:2;
            selfTemp = !!_selfIsSuperPet?5:2;
            desc = LanguageMgr.GetTranslation("wholePeople.pet.descTxt" + temp,_personNeedPetNum,!!_personIsSuperPet?_personNeedPetStar - 10:_personNeedPetStar);
            if(_selfNeedPetNum != -1)
            {
               _tipStr = LanguageMgr.GetTranslation("wholePeople.pet.tipTxt" + selfTemp,_selfNeedPetNum,!!_selfIsSuperPet?_selfNeedPetStar - 10:_selfNeedPetStar);
            }
         }
         else
         {
            temp = !!_selfIsSuperPet?4:1;
            desc = LanguageMgr.GetTranslation("wholePeople.pet.descTxt" + temp,_selfNeedPetNum,!!_selfIsSuperPet?_selfNeedPetStar - 10:_selfNeedPetStar);
         }
         _descTxt.text = desc;
      }
      
      override public function updateView() : void
      {
         var addedNum:int = 0;
         var personNum:int = 0;
         var selfNum:int = 0;
         _giftCurInfo = WonderfulActivityManager.Instance.activityInitData[_info.activityId].giftInfoDic[_info.giftbagId];
         _statusArr = WonderfulActivityManager.Instance.activityInitData[_info.activityId].statusArr;
         var _loc11_:int = 0;
         var _loc10_:* = _statusArr;
         for each(var info in _statusArr)
         {
            if(info.statusID >= _selfNeedPetStar + (!!_selfIsSuperPet?200:0) && info.statusID < 50 + (!!_selfIsSuperPet?200:0))
            {
               selfNum = selfNum + info.statusValue;
            }
            else if(info.statusID == _personNeedPetStar + (!!_personIsSuperPet?300:100))
            {
               personNum = info.statusValue;
            }
            else if(info.statusID == _addedNeedPetStar + (!!_addedIsSuperPet?300:100))
            {
               addedNum = info.statusValue;
            }
         }
         var addedBoolean:Boolean = _addedNeedPetNum != -1?int(addedNum / _addedNeedPetNum) > _giftCurInfo.times:true;
         var personBoolean:Boolean = _personNeedPetNum != -1?personNum >= _personNeedPetNum:true;
         var selfBoolean:Boolean = _selfNeedPetNum != -1?selfNum >= _selfNeedPetNum:true;
         var timeBoolean:Boolean = _getCount == 0?true:_giftCurInfo.times < _getCount;
         var canGet:Boolean = CarnivalActivityControl.instance.canGetAward() && addedBoolean && personBoolean && selfBoolean && timeBoolean;
         if(_addedNeedPetNum != -1)
         {
            ObjectUtils.disposeObject(_getBtn);
            _getBtn = null;
            ObjectUtils.disposeObject(_btnTxt);
            _btnTxt = null;
            ObjectUtils.disposeObject(_tipsBtn);
            _tipsBtn = null;
            if(canGet && int(addedNum / _addedNeedPetNum) - _giftCurInfo.times >= 1)
            {
               _getBtn = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.smallGetBtn");
               _btnTxt = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.right.btnTxt");
               addChild(_getBtn);
               addChild(_btnTxt);
               _btnTxt.x = _getBtn.x + 49;
               _btnTxt.y = _getBtn.y + 8;
               _tipsBtn = ComponentFactory.Instance.creat("wonderfulactivity.can.repeat");
               _tipsBtn.x = _getBtn.x + 45;
               _tipsBtn.y = _getBtn.y - 16;
               addChild(_tipsBtn);
               _btnTxt.text = "(" + (int(addedNum / _addedNeedPetNum) - _giftCurInfo.times) + ")";
               _awardCount = int(addedNum / _addedNeedPetNum) - _giftCurInfo.times;
            }
            else
            {
               _getBtn = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.bigGetBtn");
               addChild(_getBtn);
            }
            _getBtn.enable = canGet && int(addedNum / _addedNeedPetNum) - _giftCurInfo.times >= 1;
            _getBtn.addEventListener("click",__getAwardHandler);
            PositionUtils.setPos(_getBtn,"carnivalAct.getButtonPos");
            _awardCountTxt.text = "" + addedNum;
         }
         else if(_personNeedPetNum != -1)
         {
            _awardCountTxt.text = personNum + "/" + _personNeedPetNum;
            _alreadyGetBtn.visible = _giftCurInfo.times > 0;
            _getBtn.enable = canGet && _giftCurInfo.times == 0;
            _getBtn.visible = !_alreadyGetBtn.visible;
         }
         else
         {
            _awardCountTxt.text = selfNum + "/" + _selfNeedPetNum;
            _alreadyGetBtn.visible = _giftCurInfo.times > 0;
            _getBtn.enable = canGet && _giftCurInfo.times == 0;
            _getBtn.visible = !_alreadyGetBtn.visible;
         }
         if(_tipStr != "")
         {
            if(!_getBtn.enable)
            {
               _tipSp = new WholePeopleTipSp();
               addChild(_tipSp);
               _tipSp.graphics.beginFill(16777215,0);
               _tipSp.graphics.drawRect(0,0,_getBtn.width,_getBtn.height);
               _tipSp.graphics.endFill();
               _tipSp.width = _tipSp.displayWidth;
               _tipSp.height = _tipSp.displayHeight;
               PositionUtils.setPos(_tipSp,"carnivalAct.getButtonPos");
               _tipSp.tipStyle = "ddt.view.tips.OneLineTip";
               _tipSp.tipDirctions = "0,5";
               _tipSp.tipData = _tipStr;
            }
            else
            {
               _getBtn.tipStyle = "ddt.view.tips.OneLineTip";
               _getBtn.tipDirctions = "0,5";
               _getBtn.tipData = _tipStr;
            }
         }
         if(_tipsBtn && !_getBtn.enable)
         {
            ObjectUtils.disposeObject(_tipsBtn);
            _tipsBtn = null;
         }
      }
      
      override protected function __getAwardHandler(event:MouseEvent) : void
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
         if(_addedNeedPetNum != -1)
         {
            info.awardCount = _awardCount;
         }
         else
         {
            info.awardCount = 1;
         }
         sendInfoVec.push(info);
         SocketManager.Instance.out.sendWonderfulActivityGetReward(sendInfoVec);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_tipSp);
         _tipSp = null;
         ObjectUtils.disposeObject(_btnTxt);
         _btnTxt = null;
         ObjectUtils.disposeObject(_tipsBtn);
         _tipsBtn = null;
         super.dispose();
      }
   }
}
