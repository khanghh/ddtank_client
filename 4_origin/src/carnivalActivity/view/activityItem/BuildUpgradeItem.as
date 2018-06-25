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
      
      public function BuildUpgradeItem(type:int, info:GiftBagInfo, index:int)
      {
         super(type,info,index);
      }
      
      override protected function initItem() : void
      {
         var i:int = 0;
         for(i = 0; i < _info.giftConditionArr.length; )
         {
            if(_info.giftConditionArr[i].conditionIndex == 0)
            {
               _templeGrade = _info.giftConditionArr[i].remain1;
               index = (_templeGrade - 1) / BUILDLEN;
               offset = _templeGrade % BUILDLEN == 0?BUILDLEN:_templeGrade % BUILDLEN;
               _descTxt.text = LanguageMgr.GetTranslation("buildTemple.levelup.descTxt" + index,offset);
            }
            i++;
         }
         _descTxt.y = _descTxt.y + 5;
      }
      
      override public function updateView() : void
      {
         var grade:int = 0;
         var currentGrade:int = 0;
         _giftCurInfo = WonderfulActivityManager.Instance.activityInitData[_info.activityId].giftInfoDic[_info.giftbagId];
         _statusArr = WonderfulActivityManager.Instance.activityInitData[_info.activityId].statusArr;
         var _loc7_:int = 0;
         var _loc6_:* = _statusArr;
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
         var isComplate:Boolean = false;
         var curPro:int = index * BUILDLEN + offset;
         if(grade >= curPro)
         {
            isComplate = false;
         }
         else if(grade < curPro && curPro <= currentGrade)
         {
            isComplate = true;
         }
         else
         {
            isComplate = false;
         }
         _getBtn.enable = CarnivalActivityControl.instance.canGetAward() && _giftCurInfo.times == 0 && isComplate;
         _alreadyGetBtn.visible = _giftCurInfo.times > 0;
         _getBtn.visible = !_alreadyGetBtn.visible;
      }
   }
}
