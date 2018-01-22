package carnivalActivity.view.activityItem
{
   import carnivalActivity.CarnivalActivityControl;
   import carnivalActivity.view.CarnivalActivityItem;
   import ddt.manager.LanguageMgr;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.PlayerCurInfo;
   
   public class BuildUpgradeItem extends CarnivalActivityItem
   {
      
      protected static var BUILDLEN:int = 14;
       
      
      protected var _templeGrade:int;
      
      private var offset:int;
      
      private var index:int;
      
      public function BuildUpgradeItem(param1:int, param2:GiftBagInfo, param3:int)
      {
         super(param1,param2,param3);
      }
      
      override protected function initItem() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _info.giftConditionArr.length)
         {
            if(_info.giftConditionArr[_loc1_].conditionIndex == 0)
            {
               _templeGrade = _info.giftConditionArr[_loc1_].remain1;
               index = (_templeGrade - 1) / BUILDLEN;
               offset = _templeGrade % BUILDLEN == 0?BUILDLEN:_templeGrade % BUILDLEN;
               _descTxt.text = LanguageMgr.GetTranslation("buildTemple.levelup.descTxt" + index,offset);
            }
            _loc1_++;
         }
         _descTxt.y = _descTxt.y + 5;
      }
      
      override public function updateView() : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         _giftCurInfo = WonderfulActivityManager.Instance.activityInitData[_info.activityId].giftInfoDic[_info.giftbagId];
         _statusArr = WonderfulActivityManager.Instance.activityInitData[_info.activityId].statusArr;
         var _loc7_:int = 0;
         var _loc6_:* = _statusArr;
         for each(var _loc5_ in _statusArr)
         {
            if(_loc5_.statusID == 0)
            {
               _loc4_ = _loc5_.statusValue;
            }
            else if(_loc5_.statusID == 1)
            {
               _loc2_ = _loc5_.statusValue;
            }
         }
         var _loc1_:Boolean = false;
         var _loc3_:int = index * BUILDLEN + offset;
         if(_loc4_ >= _loc3_)
         {
            _loc1_ = false;
         }
         else if(_loc4_ < _loc3_ && _loc3_ <= _loc2_)
         {
            _loc1_ = true;
         }
         else
         {
            _loc1_ = false;
         }
         _getBtn.enable = CarnivalActivityControl.instance.canGetAward() && _giftCurInfo.times == 0 && _loc1_;
         _alreadyGetBtn.visible = _giftCurInfo.times > 0;
         _getBtn.visible = !_alreadyGetBtn.visible;
      }
   }
}
