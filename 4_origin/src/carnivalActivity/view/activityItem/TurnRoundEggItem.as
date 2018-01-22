package carnivalActivity.view.activityItem
{
   import carnivalActivity.CarnivalActivityControl;
   import carnivalActivity.view.CarnivalActivityItem;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.manager.LanguageMgr;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.GiftConditionInfo;
   import wonderfulActivity.data.PlayerCurInfo;
   
   public class TurnRoundEggItem extends CarnivalActivityItem
   {
       
      
      protected var _remain:int;
      
      public function TurnRoundEggItem(param1:int, param2:GiftBagInfo, param3:int)
      {
         super(param1,param2,param3);
      }
      
      override protected function initItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = undefined;
         var _loc3_:int = 0;
         _awardCountTxt = ComponentFactory.Instance.creatComponentByStylename("carnivalAct.countTxt");
         addChild(_awardCountTxt);
         if(_descTxt)
         {
            _loc1_ = _info.giftConditionArr;
            _loc3_ = 0;
            while(_loc3_ < _loc1_.length)
            {
               if(_loc1_[_loc3_].conditionIndex == 0)
               {
                  _loc2_ = _loc1_[_loc3_].remain1;
                  _condtion = _loc1_[_loc3_].conditionValue;
               }
               _loc3_++;
            }
            if(_condtion == 1)
            {
               _descTxt.text = LanguageMgr.GetTranslation("carnival.descTxt27_1",_loc2_);
            }
            else
            {
               _descTxt.text = LanguageMgr.GetTranslation("carnival.descTxt27_2",_loc2_);
            }
         }
         if(_sumCount == 0)
         {
            _descTxt.y = _descTxt.y + 5;
         }
      }
      
      override protected function initData() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _info.giftConditionArr.length)
         {
            if(_info.giftConditionArr[_loc1_].conditionIndex == 0)
            {
               _condtion = _info.giftConditionArr[_loc1_].conditionValue;
               _remain = _info.giftConditionArr[_loc1_].remain1;
            }
            _loc1_++;
         }
      }
      
      override public function updateView() : void
      {
         var _loc1_:Object = WonderfulActivityManager.Instance.activityInitData[_info.activityId];
         if(_loc1_)
         {
            _giftCurInfo = _loc1_.giftInfoDic[_info.giftbagId];
            _statusArr = _loc1_.statusArr;
            _playerAlreadyGetCount = _giftCurInfo.times;
            var _loc4_:int = 0;
            var _loc3_:* = _statusArr;
            for each(var _loc2_ in _statusArr)
            {
               if(_loc2_.statusID == _condtion)
               {
                  _currentCondtion = _loc2_.statusValue;
               }
            }
            _getBtn.enable = CarnivalActivityControl.instance.canGetAward() && _playerAlreadyGetCount == 0 && _currentCondtion >= _remain;
            _alreadyGetBtn.visible = _playerAlreadyGetCount > 0;
            _getBtn.visible = !_alreadyGetBtn.visible;
            _awardCountTxt.text = (_currentCondtion > _remain?_remain:int(_currentCondtion)) + "/" + _remain;
         }
      }
   }
}
