package carnivalActivity.view
{
   import carnivalActivity.CarnivalActivityControl;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.manager.LanguageMgr;
   import ddt.utils.HelperDataModuleLoad;
   import homeTemple.HomeTempleController;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.PlayerCurInfo;
   
   public class GodTempleItem extends CarnivalActivityItem
   {
       
      
      private var _needTempleLevel:int;
      
      private var _needTempleStar:int;
      
      private var _reallyTempleGrade:int;
      
      public function GodTempleItem(param1:int, param2:GiftBagInfo, param3:int)
      {
         super(param1,param2,param3);
      }
      
      override protected function initItem() : void
      {
         var _loc1_:int = 0;
         if(HomeTempleController.Instance.practiceList == null)
         {
            new HelperDataModuleLoad().loadDataModule([HomeTempleController.Instance.getHomeTempleList2],initItem);
            return;
         }
         if(CarnivalActivityControl.instance.currentChildType == 0)
         {
            _loc1_ = 0;
            while(_loc1_ < _info.giftConditionArr.length)
            {
               if(_info.giftConditionArr[_loc1_].conditionIndex == 0)
               {
                  _needTempleStar = _info.giftConditionArr[_loc1_].conditionValue;
                  _reallyTempleGrade = _info.giftConditionArr[_loc1_].remain1;
               }
               else if(_info.giftConditionArr[_loc1_].conditionIndex == 1)
               {
                  _needTempleLevel = _info.giftConditionArr[_loc1_].conditionValue;
               }
               _loc1_++;
            }
         }
         if(_sumCount != 0)
         {
            _awardCountTxt = ComponentFactory.Instance.creatComponentByStylename("carnivalAct.countTxt");
            addChild(_awardCountTxt);
         }
         else
         {
            _descTxt.y = _descTxt.y + 9;
         }
         if(CarnivalActivityControl.instance.currentChildType == 0)
         {
            if(_needTempleLevel == 0)
            {
               _descTxt.text = LanguageMgr.GetTranslation("godTemple.levelup.descTxt2",_needTempleStar);
            }
            else
            {
               _descTxt.text = LanguageMgr.GetTranslation("godTemple.levelup.descTxt",_needTempleStar,_needTempleLevel);
            }
         }
         updateView();
      }
      
      override public function updateView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _giftCurInfo = WonderfulActivityManager.Instance.activityInitData[_info.activityId].giftInfoDic[_info.giftbagId];
         _statusArr = WonderfulActivityManager.Instance.activityInitData[_info.activityId].statusArr;
         if(CarnivalActivityControl.instance.currentChildType == 0)
         {
            var _loc5_:int = 0;
            var _loc4_:* = _statusArr;
            for each(var _loc3_ in _statusArr)
            {
               if(_loc3_.statusID == 0)
               {
                  _loc2_ = _loc3_.statusValue;
               }
               else if(_loc3_.statusID == 1)
               {
                  _loc1_ = _loc3_.statusValue;
               }
            }
         }
         if(CarnivalActivityControl.instance.currentChildType == 0)
         {
            _getBtn.enable = CarnivalActivityControl.instance.canGetAward() && _giftCurInfo.times == 0 && _reallyTempleGrade > _loc2_ && _reallyTempleGrade <= _loc1_;
            _alreadyGetBtn.visible = _giftCurInfo.times > 0;
            _getBtn.visible = !_alreadyGetBtn.visible;
         }
         if(_awardCountTxt)
         {
            _awardCountTxt.text = LanguageMgr.GetTranslation("carnival.awardCountTxt") + (_sumCount - _giftCurInfo.allGiftGetTimes);
         }
      }
   }
}
