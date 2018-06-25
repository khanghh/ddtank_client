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
      
      public function RookieItem(type:int, info:GiftBagInfo, index:int)
      {
         super(type,info,index);
      }
      
      override protected function initData() : void
      {
         var i:int = 0;
         for(i = 0; i < _info.giftConditionArr.length; )
         {
            if(_info.giftConditionArr[i].conditionIndex == 0)
            {
               _fightPower = _info.giftConditionArr[i].conditionValue;
            }
            else if(_info.giftConditionArr[i].conditionIndex == 1)
            {
               _fightPowerRankOne = _info.giftConditionArr[i].conditionValue;
               _fightPowerRankTwo = _info.giftConditionArr[i].remain1;
            }
            else if(_info.giftConditionArr[i].conditionIndex == 100)
            {
               _sumCount = _info.giftConditionArr[i].conditionValue;
            }
            i++;
         }
      }
      
      override public function updateView() : void
      {
         var power:int = 0;
         var rank:int = 0;
         _giftCurInfo = WonderfulActivityManager.Instance.activityInitData[_info.activityId].giftInfoDic[_info.giftbagId];
         _statusArr = WonderfulActivityManager.Instance.activityInitData[_info.activityId].statusArr;
         var _loc5_:int = 0;
         var _loc4_:* = _statusArr;
         for each(var info in _statusArr)
         {
            if(info.statusID == 0)
            {
               power = info.statusValue;
            }
            else
            {
               rank = info.statusValue;
            }
         }
         if(_fightPower != -1)
         {
            _descTxt.text = LanguageMgr.GetTranslation("carnival.rookie.descTxt3",_fightPower);
            _getBtn.enable = CarnivalActivityControl.instance.canGetAward() && _giftCurInfo.times == 0 && power >= _fightPower;
         }
         else if(_fightPowerRankOne == _fightPowerRankTwo)
         {
            _descTxt.text = LanguageMgr.GetTranslation("carnival.rookie.descTxt1",_fightPowerRankOne);
            _getBtn.enable = CarnivalActivityControl.instance.rookieRankCanGetAward() && _giftCurInfo.times == 0 && rank >= _fightPowerRankOne;
         }
         else
         {
            _descTxt.text = LanguageMgr.GetTranslation("carnival.rookie.descTxt2",_fightPowerRankOne,_fightPowerRankTwo);
            _getBtn.enable = CarnivalActivityControl.instance.rookieRankCanGetAward() && _giftCurInfo.times == 0 && rank >= _fightPowerRankOne && rank <= _fightPowerRankTwo;
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
