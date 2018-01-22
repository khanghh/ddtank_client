package carnivalActivity.view
{
   import carnivalActivity.CarnivalActivityControl;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.loader.LoaderCreate;
   import ddt.manager.LanguageMgr;
   import ddt.utils.HelperDataModuleLoad;
   import horse.HorseManager;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.PlayerCurInfo;
   
   public class HorseDarenItem extends CarnivalActivityItem
   {
       
      
      private var _horseGrade:int;
      
      private var _horseStar:int;
      
      private var _horseSkillType:int;
      
      private var _horseSkillGrade:int;
      
      private var _reallyHorseGrade:int;
      
      public function HorseDarenItem(param1:int, param2:GiftBagInfo, param3:int)
      {
         super(param1,param2,param3);
      }
      
      override protected function initItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         if(HorseManager.instance.horseTemplateList == null || HorseManager.instance.horseSkillGetIdList == null)
         {
            new HelperDataModuleLoad().loadDataModule([LoaderCreate.Instance.createHorseTemplateDataLoader(),LoaderCreate.Instance.createHorseSkillGetDataLoader()],initItem);
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < _info.giftConditionArr.length)
         {
            if(CarnivalActivityControl.instance.currentChildType == 0)
            {
               if(_info.giftConditionArr[_loc2_].conditionIndex == 0)
               {
                  _horseGrade = _info.giftConditionArr[_loc2_].conditionValue;
                  _reallyHorseGrade = _info.giftConditionArr[_loc2_].remain1;
               }
               else
               {
                  _horseStar = _info.giftConditionArr[_loc2_].conditionValue;
               }
            }
            else if(_info.giftConditionArr[_loc2_].conditionIndex == 0)
            {
               _horseSkillType = _info.giftConditionArr[_loc2_].conditionValue;
            }
            else
            {
               _horseSkillGrade = _info.giftConditionArr[_loc2_].conditionValue;
            }
            _loc2_++;
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
            _descTxt.text = LanguageMgr.GetTranslation("horseDaren.grade.descTxt",_horseGrade,_horseStar);
         }
         else
         {
            _loc1_ = HorseManager.instance.getHorseSkillName(_horseSkillType,_horseSkillGrade);
            _descTxt.text = LanguageMgr.GetTranslation("horseDaren.skill.descTxt",_loc1_);
         }
      }
      
      override public function updateView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         _giftCurInfo = WonderfulActivityManager.Instance.activityInitData[_info.activityId].giftInfoDic[_info.giftbagId];
         _statusArr = WonderfulActivityManager.Instance.activityInitData[_info.activityId].statusArr;
         var _loc7_:int = 0;
         var _loc6_:* = _statusArr;
         for each(var _loc5_ in _statusArr)
         {
            if(CarnivalActivityControl.instance.currentChildType == 0)
            {
               if(_loc5_.statusID == 0)
               {
                  _loc3_ = _loc5_.statusValue;
               }
               else if(_loc5_.statusID == 1)
               {
                  _loc1_ = _loc5_.statusValue;
               }
            }
            else if(_loc5_.statusID == _horseSkillType)
            {
               _loc4_ = _loc5_.statusValue;
            }
            else if(_loc5_.statusID == _horseSkillType + 100)
            {
               _loc2_ = _loc5_.statusValue;
            }
         }
         if(CarnivalActivityControl.instance.currentChildType == 0)
         {
            _getBtn.enable = CarnivalActivityControl.instance.canGetAward() && _giftCurInfo.times == 0 && _reallyHorseGrade > _loc3_ && _reallyHorseGrade <= _loc1_;
            _alreadyGetBtn.visible = _giftCurInfo.times > 0;
            _getBtn.visible = !_alreadyGetBtn.visible;
         }
         else
         {
            _getBtn.enable = CarnivalActivityControl.instance.canGetAward() && _giftCurInfo.times == 0 && _horseSkillGrade > _loc4_ && _horseSkillGrade <= _loc2_;
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
