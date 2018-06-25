package carnivalActivity.view
{
   import carnivalActivity.CarnivalActivityControl;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
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
   
   public class WholePeopleVipActItem extends CarnivalActivityItem
   {
       
      
      private var _selfGrade:int = -1;
      
      private var _personNum:int = -1;
      
      private var _vipGd:int;
      
      private var _addedNum:int = -1;
      
      private var _addedVipGd:int;
      
      private var _btnTxt:FilterFrameText;
      
      private var _tipsBtn:Bitmap;
      
      private var _tipStr:String = "";
      
      private var _tipSp:WholePeopleTipSp;
      
      private var _awardCount:int;
      
      private var _getCount:int = -1;
      
      public function WholePeopleVipActItem(type:int, info:GiftBagInfo, index:int)
      {
         super(type,info,index);
      }
      
      override protected function initItem() : void
      {
         var i:int = 0;
         _awardCountTxt = ComponentFactory.Instance.creatComponentByStylename("carnivalAct.countTxt");
         addChild(_awardCountTxt);
         for(i = 0; i < _info.giftConditionArr.length; )
         {
            if(_info.giftConditionArr[i].conditionIndex == 0)
            {
               _selfGrade = _info.giftConditionArr[i].conditionValue;
            }
            else if(_info.giftConditionArr[i].conditionIndex == 1)
            {
               _vipGd = _info.giftConditionArr[i].conditionValue;
               _personNum = _info.giftConditionArr[i].remain1;
            }
            else if(_info.giftConditionArr[i].conditionIndex == 2)
            {
               _addedVipGd = _info.giftConditionArr[i].conditionValue;
               _addedNum = _info.giftConditionArr[i].remain1;
            }
            else if(_info.giftConditionArr[i].conditionIndex == 3)
            {
               _getCount = _info.giftConditionArr[i].conditionValue;
            }
            i++;
         }
         var desc:String = "";
         if(_addedNum != -1)
         {
            desc = LanguageMgr.GetTranslation("wholePeople.vip.descTxt3",_addedVipGd,_addedNum);
            if(_selfGrade != -1)
            {
               _tipStr = LanguageMgr.GetTranslation("wholePeople.vip.tipTxt",_selfGrade);
            }
         }
         else if(_personNum != -1)
         {
            desc = LanguageMgr.GetTranslation("wholePeople.vip.descTxt2",_vipGd,_personNum);
            if(_selfGrade != -1)
            {
               _tipStr = LanguageMgr.GetTranslation("wholePeople.vip.tipTxt",_selfGrade);
            }
         }
         else
         {
            desc = LanguageMgr.GetTranslation("wholePeople.vip.descTxt1",_selfGrade);
         }
         _descTxt.text = desc;
      }
      
      override public function updateView() : void
      {
         var addedNum:int = 0;
         var personNum:int = 0;
         var selfGrade:int = 0;
         _giftCurInfo = WonderfulActivityManager.Instance.activityInitData[_info.activityId].giftInfoDic[_info.giftbagId];
         _statusArr = WonderfulActivityManager.Instance.activityInitData[_info.activityId].statusArr;
         var _loc11_:int = 0;
         var _loc10_:* = _statusArr;
         for each(var info in _statusArr)
         {
            if(info.statusID == 0)
            {
               selfGrade = info.statusValue;
            }
            else if(info.statusID == _vipGd)
            {
               personNum = info.statusValue;
            }
            else if(info.statusID == _addedVipGd)
            {
               addedNum = info.statusValue;
            }
         }
         var addedBoolean:Boolean = _addedNum != -1?int(addedNum / _addedNum) > _giftCurInfo.times:true;
         var personBoolean:Boolean = _personNum != -1?personNum >= _personNum:true;
         var selfBoolean:Boolean = _selfGrade != -1?selfGrade >= _selfGrade:true;
         var timeBoolean:Boolean = _getCount == 0?true:_giftCurInfo.times < _getCount;
         var canGet:Boolean = CarnivalActivityControl.instance.canGetAward() && addedBoolean && personBoolean && selfBoolean && timeBoolean;
         if(_addedNum != -1)
         {
            ObjectUtils.disposeObject(_getBtn);
            _getBtn = null;
            if(canGet && int(addedNum / _addedNum) - _giftCurInfo.times >= 1)
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
               _btnTxt.text = "(" + (int(addedNum / _addedNum) - _giftCurInfo.times) + ")";
               _awardCount = int(addedNum / _addedNum) - _giftCurInfo.times;
            }
            else
            {
               _getBtn = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.bigGetBtn");
               addChild(_getBtn);
            }
            _getBtn.enable = !PlayerManager.Instance.Self.snapVip && canGet && int(addedNum / _addedNum) - _giftCurInfo.times >= 1;
            _getBtn.addEventListener("click",__getAwardHandler);
            PositionUtils.setPos(_getBtn,"carnivalAct.getButtonPos");
            _awardCountTxt.text = "" + addedNum;
         }
         else if(_personNum != -1)
         {
            _awardCountTxt.text = personNum + "/" + _personNum;
            _alreadyGetBtn.visible = _giftCurInfo.times > 0;
            _getBtn.enable = !PlayerManager.Instance.Self.snapVip && canGet && _giftCurInfo.times == 0;
            _getBtn.visible = !_alreadyGetBtn.visible;
         }
         else
         {
            _descTxt.y = _descTxt.y + 9;
            _alreadyGetBtn.visible = _giftCurInfo.times > 0;
            _getBtn.enable = !PlayerManager.Instance.Self.snapVip && canGet && _giftCurInfo.times == 0;
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
         if(_addedNum != -1)
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
