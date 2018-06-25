package carnivalActivity.view.activityItem
{
   import carnivalActivity.CarnivalActivityControl;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.PlayerCurInfo;
   
   public class PetUpgradeItem extends UseUpEnergyItem
   {
       
      
      public function PetUpgradeItem(type:int, info:GiftBagInfo, index:int)
      {
         super(type,info,index);
      }
      
      override public function updateView() : void
      {
         var infoDic:Object = WonderfulActivityManager.Instance.activityInitData[_info.activityId];
         if(infoDic)
         {
            _giftCurInfo = infoDic.giftInfoDic[_info.giftbagId];
            _statusArr = infoDic.statusArr;
            var _loc4_:int = 0;
            var _loc3_:* = _statusArr;
            for each(var info in _statusArr)
            {
               if(info.statusID == _condtion)
               {
                  _currentCondtion = info.statusValue;
                  break;
               }
            }
            _playerAlreadyGetCount = _giftCurInfo.times;
            _getBtn.enable = CarnivalActivityControl.instance.canGetAward() && _playerAlreadyGetCount == 0 && _currentCondtion > 0;
            _alreadyGetBtn.visible = _playerAlreadyGetCount > 0;
            _getBtn.visible = !_alreadyGetBtn.visible;
         }
      }
   }
}
