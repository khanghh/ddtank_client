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
      
      public function GodTempleItem(type:int, info:GiftBagInfo, index:int)
      {
         super(type,info,index);
      }
      
      override protected function initItem() : void
      {
         var i:int = 0;
         if(HomeTempleController.Instance.practiceList == null)
         {
            new HelperDataModuleLoad().loadDataModule([HomeTempleController.Instance.getHomeTempleList2],initItem);
            return;
         }
         if(CarnivalActivityControl.instance.currentChildType == 0)
         {
            for(i = 0; i < _info.giftConditionArr.length; )
            {
               if(_info.giftConditionArr[i].conditionIndex == 0)
               {
                  _needTempleStar = _info.giftConditionArr[i].conditionValue;
                  _reallyTempleGrade = _info.giftConditionArr[i].remain1;
               }
               else if(_info.giftConditionArr[i].conditionIndex == 1)
               {
                  _needTempleLevel = _info.giftConditionArr[i].conditionValue;
               }
               i++;
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
         var grade:int = 0;
         var currentGrade:int = 0;
         _giftCurInfo = WonderfulActivityManager.Instance.activityInitData[_info.activityId].giftInfoDic[_info.giftbagId];
         _statusArr = WonderfulActivityManager.Instance.activityInitData[_info.activityId].statusArr;
         if(CarnivalActivityControl.instance.currentChildType == 0)
         {
            var _loc5_:int = 0;
            var _loc4_:* = _statusArr;
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
         }
         if(CarnivalActivityControl.instance.currentChildType == 0)
         {
            _getBtn.enable = CarnivalActivityControl.instance.canGetAward() && _giftCurInfo.times == 0 && _reallyTempleGrade > grade && _reallyTempleGrade <= currentGrade;
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
