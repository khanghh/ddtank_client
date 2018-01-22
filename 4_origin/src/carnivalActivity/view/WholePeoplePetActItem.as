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
      
      public function WholePeoplePetActItem(param1:int, param2:GiftBagInfo, param3:int)
      {
         super(param1,param2,param3);
      }
      
      override protected function initItem() : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _awardCountTxt = ComponentFactory.Instance.creatComponentByStylename("carnivalAct.countTxt");
         addChild(_awardCountTxt);
         _loc4_ = 0;
         while(_loc4_ < _info.giftConditionArr.length)
         {
            if(_info.giftConditionArr[_loc4_].conditionIndex == 4)
            {
               _selfIsSuperPet = true;
            }
            else if(_info.giftConditionArr[_loc4_].conditionIndex == 5)
            {
               _personIsSuperPet = true;
            }
            else if(_info.giftConditionArr[_loc4_].conditionIndex == 6)
            {
               _addedIsSuperPet = true;
            }
            _loc4_++;
         }
         _loc5_ = 0;
         while(_loc5_ < _info.giftConditionArr.length)
         {
            if(_info.giftConditionArr[_loc5_].conditionIndex == (!!_selfIsSuperPet?4:0))
            {
               _selfNeedPetStar = _info.giftConditionArr[_loc5_].conditionValue;
               _selfNeedPetNum = _info.giftConditionArr[_loc5_].remain1;
            }
            else if(_info.giftConditionArr[_loc5_].conditionIndex == (!!_personIsSuperPet?5:1))
            {
               _personNeedPetStar = _info.giftConditionArr[_loc5_].conditionValue;
               _personNeedPetNum = _info.giftConditionArr[_loc5_].remain1;
            }
            else if(_info.giftConditionArr[_loc5_].conditionIndex == (!!_addedIsSuperPet?6:2))
            {
               _addedNeedPetStar = _info.giftConditionArr[_loc5_].conditionValue;
               _addedNeedPetNum = _info.giftConditionArr[_loc5_].remain1;
            }
            else if(_info.giftConditionArr[_loc5_].conditionIndex == 3)
            {
               _getCount = _info.giftConditionArr[_loc5_].conditionValue;
            }
            _loc5_++;
         }
         var _loc1_:String = "";
         if(_addedNeedPetNum != -1)
         {
            _loc3_ = !!_addedIsSuperPet?6:3;
            _loc2_ = !!_selfIsSuperPet?6:3;
            _loc1_ = LanguageMgr.GetTranslation("wholePeople.pet.descTxt" + _loc3_,_addedNeedPetNum,!!_addedIsSuperPet?_addedNeedPetStar - 10:_addedNeedPetStar);
            if(_selfNeedPetNum != -1)
            {
               _tipStr = LanguageMgr.GetTranslation("wholePeople.pet.tipTxt" + _loc2_,_selfNeedPetNum,!!_selfIsSuperPet?_selfNeedPetStar - 10:_selfNeedPetStar);
            }
         }
         else if(_personNeedPetNum != -1)
         {
            _loc3_ = !!_personIsSuperPet?5:2;
            _loc2_ = !!_selfIsSuperPet?5:2;
            _loc1_ = LanguageMgr.GetTranslation("wholePeople.pet.descTxt" + _loc3_,_personNeedPetNum,!!_personIsSuperPet?_personNeedPetStar - 10:_personNeedPetStar);
            if(_selfNeedPetNum != -1)
            {
               _tipStr = LanguageMgr.GetTranslation("wholePeople.pet.tipTxt" + _loc2_,_selfNeedPetNum,!!_selfIsSuperPet?_selfNeedPetStar - 10:_selfNeedPetStar);
            }
         }
         else
         {
            _loc3_ = !!_selfIsSuperPet?4:1;
            _loc1_ = LanguageMgr.GetTranslation("wholePeople.pet.descTxt" + _loc3_,_selfNeedPetNum,!!_selfIsSuperPet?_selfNeedPetStar - 10:_selfNeedPetStar);
         }
         _descTxt.text = _loc1_;
      }
      
      override public function updateView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _giftCurInfo = WonderfulActivityManager.Instance.activityInitData[_info.activityId].giftInfoDic[_info.giftbagId];
         _statusArr = WonderfulActivityManager.Instance.activityInitData[_info.activityId].statusArr;
         var _loc11_:int = 0;
         var _loc10_:* = _statusArr;
         for each(var _loc9_ in _statusArr)
         {
            if(_loc9_.statusID >= _selfNeedPetStar + (!!_selfIsSuperPet?200:0) && _loc9_.statusID < 50 + (!!_selfIsSuperPet?200:0))
            {
               _loc3_ = _loc3_ + _loc9_.statusValue;
            }
            else if(_loc9_.statusID == _personNeedPetStar + (!!_personIsSuperPet?300:100))
            {
               _loc2_ = _loc9_.statusValue;
            }
            else if(_loc9_.statusID == _addedNeedPetStar + (!!_addedIsSuperPet?300:100))
            {
               _loc1_ = _loc9_.statusValue;
            }
         }
         var _loc7_:Boolean = _addedNeedPetNum != -1?int(_loc1_ / _addedNeedPetNum) > _giftCurInfo.times:true;
         var _loc6_:Boolean = _personNeedPetNum != -1?_loc2_ >= _personNeedPetNum:true;
         var _loc5_:Boolean = _selfNeedPetNum != -1?_loc3_ >= _selfNeedPetNum:true;
         var _loc4_:Boolean = _getCount == 0?true:_giftCurInfo.times < _getCount;
         var _loc8_:Boolean = CarnivalActivityControl.instance.canGetAward() && _loc7_ && _loc6_ && _loc5_ && _loc4_;
         if(_addedNeedPetNum != -1)
         {
            ObjectUtils.disposeObject(_getBtn);
            _getBtn = null;
            ObjectUtils.disposeObject(_btnTxt);
            _btnTxt = null;
            ObjectUtils.disposeObject(_tipsBtn);
            _tipsBtn = null;
            if(_loc8_ && int(_loc1_ / _addedNeedPetNum) - _giftCurInfo.times >= 1)
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
               _btnTxt.text = "(" + (int(_loc1_ / _addedNeedPetNum) - _giftCurInfo.times) + ")";
               _awardCount = int(_loc1_ / _addedNeedPetNum) - _giftCurInfo.times;
            }
            else
            {
               _getBtn = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.bigGetBtn");
               addChild(_getBtn);
            }
            _getBtn.enable = _loc8_ && int(_loc1_ / _addedNeedPetNum) - _giftCurInfo.times >= 1;
            _getBtn.addEventListener("click",__getAwardHandler);
            PositionUtils.setPos(_getBtn,"carnivalAct.getButtonPos");
            _awardCountTxt.text = "" + _loc1_;
         }
         else if(_personNeedPetNum != -1)
         {
            _awardCountTxt.text = _loc2_ + "/" + _personNeedPetNum;
            _alreadyGetBtn.visible = _giftCurInfo.times > 0;
            _getBtn.enable = _loc8_ && _giftCurInfo.times == 0;
            _getBtn.visible = !_alreadyGetBtn.visible;
         }
         else
         {
            _awardCountTxt.text = _loc3_ + "/" + _selfNeedPetNum;
            _alreadyGetBtn.visible = _giftCurInfo.times > 0;
            _getBtn.enable = _loc8_ && _giftCurInfo.times == 0;
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
      
      override protected function __getAwardHandler(param1:MouseEvent) : void
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
         if(_addedNeedPetNum != -1)
         {
            _loc3_.awardCount = _awardCount;
         }
         else
         {
            _loc3_.awardCount = 1;
         }
         _loc2_.push(_loc3_);
         SocketManager.Instance.out.sendWonderfulActivityGetReward(_loc2_);
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
