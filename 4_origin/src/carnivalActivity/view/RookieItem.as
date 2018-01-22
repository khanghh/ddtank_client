package carnivalActivity.view
{
   import carnivalActivity.CarnivalActivityControl;
   import ddt.manager.LanguageMgr;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.PlayerCurInfo;
   
   public class RookieItem extends CarnivalActivityItem
   {
       
      
      private var _fightPower:int = -1;
      
      private var _fightPowerRankOne:int = -1;
      
      private var _fightPowerRankTwo:int = -1;
      
      public function RookieItem(param1:int, param2:GiftBagInfo, param3:int)
      {
         super(param1,param2,param3);
      }
      
      override protected function initData() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _info.giftConditionArr.length)
         {
            if(_info.giftConditionArr[_loc1_].conditionIndex == 0)
            {
               _fightPower = _info.giftConditionArr[_loc1_].conditionValue;
            }
            else if(_info.giftConditionArr[_loc1_].conditionIndex == 1)
            {
               _fightPowerRankOne = _info.giftConditionArr[_loc1_].conditionValue;
               _fightPowerRankTwo = _info.giftConditionArr[_loc1_].remain1;
            }
            else if(_info.giftConditionArr[_loc1_].conditionIndex == 100)
            {
               _sumCount = _info.giftConditionArr[_loc1_].conditionValue;
            }
            _loc1_++;
         }
      }
      
      override public function updateView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _giftCurInfo = WonderfulActivityManager.Instance.activityInitData[_info.activityId].giftInfoDic[_info.giftbagId];
         _statusArr = WonderfulActivityManager.Instance.activityInitData[_info.activityId].statusArr;
         var _loc5_:int = 0;
         var _loc4_:* = _statusArr;
         for each(var _loc3_ in _statusArr)
         {
            if(_loc3_.statusID == 0)
            {
               _loc2_ = _loc3_.statusValue;
            }
            else
            {
               _loc1_ = _loc3_.statusValue;
            }
         }
         if(_fightPower != -1)
         {
            _descTxt.text = LanguageMgr.GetTranslation("carnival.rookie.descTxt3",_fightPower);
            _getBtn.enable = CarnivalActivityControl.instance.canGetAward() && _giftCurInfo.times == 0 && _loc2_ >= _fightPower;
         }
         else if(_fightPowerRankOne == _fightPowerRankTwo)
         {
            _descTxt.text = LanguageMgr.GetTranslation("carnival.rookie.descTxt1",_fightPowerRankOne);
            _getBtn.enable = CarnivalActivityControl.instance.rookieRankCanGetAward() && _giftCurInfo.times == 0 && _loc1_ >= _fightPowerRankOne;
         }
         else
         {
            _descTxt.text = LanguageMgr.GetTranslation("carnival.rookie.descTxt2",_fightPowerRankOne,_fightPowerRankTwo);
            _getBtn.enable = CarnivalActivityControl.instance.rookieRankCanGetAward() && _giftCurInfo.times == 0 && _loc1_ >= _fightPowerRankOne && _loc1_ <= _fightPowerRankTwo;
         }
         _allGiftAlreadyGetCount = _giftCurInfo.allGiftGetTimes;
         if(_awardCountTxt)
         {
            _awardCountTxt.text = LanguageMgr.GetTranslation("carnival.awardCountTxt") + (_sumCount - _allGiftAlreadyGetCount);
         }
         _alreadyGetBtn.visible = _giftCurInfo.times > 0;
         _getBtn.visible = !_alreadyGetBtn.visible;
      }
   }
}
