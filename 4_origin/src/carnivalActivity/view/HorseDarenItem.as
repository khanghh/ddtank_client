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
      
      public function HorseDarenItem(type:int, info:GiftBagInfo, index:int)
      {
         super(type,info,index);
      }
      
      override protected function initItem() : void
      {
         var i:int = 0;
         var skillName:* = null;
         if(HorseManager.instance.horseTemplateList == null || HorseManager.instance.horseSkillGetIdList == null)
         {
            new HelperDataModuleLoad().loadDataModule([LoaderCreate.Instance.createHorseTemplateDataLoader(),LoaderCreate.Instance.createHorseSkillGetDataLoader()],initItem);
            return;
         }
         i = 0;
         while(i < _info.giftConditionArr.length)
         {
            if(CarnivalActivityControl.instance.currentChildType == 0)
            {
               if(_info.giftConditionArr[i].conditionIndex == 0)
               {
                  _horseGrade = _info.giftConditionArr[i].conditionValue;
                  _reallyHorseGrade = _info.giftConditionArr[i].remain1;
               }
               else
               {
                  _horseStar = _info.giftConditionArr[i].conditionValue;
               }
            }
            else if(_info.giftConditionArr[i].conditionIndex == 0)
            {
               _horseSkillType = _info.giftConditionArr[i].conditionValue;
            }
            else
            {
               _horseSkillGrade = _info.giftConditionArr[i].conditionValue;
            }
            i++;
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
            skillName = HorseManager.instance.getHorseSkillName(_horseSkillType,_horseSkillGrade);
            _descTxt.text = LanguageMgr.GetTranslation("horseDaren.skill.descTxt",skillName);
         }
      }
      
      override public function updateView() : void
      {
         var grade:int = 0;
         var currentGrade:int = 0;
         var skillGrade:int = 0;
         var currentSkillGrade:int = 0;
         _giftCurInfo = WonderfulActivityManager.Instance.activityInitData[_info.activityId].giftInfoDic[_info.giftbagId];
         _statusArr = WonderfulActivityManager.Instance.activityInitData[_info.activityId].statusArr;
         var _loc7_:int = 0;
         var _loc6_:* = _statusArr;
         for each(var info in _statusArr)
         {
            if(CarnivalActivityControl.instance.currentChildType == 0)
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
            else if(info.statusID == _horseSkillType)
            {
               skillGrade = info.statusValue;
            }
            else if(info.statusID == _horseSkillType + 100)
            {
               currentSkillGrade = info.statusValue;
            }
         }
         if(CarnivalActivityControl.instance.currentChildType == 0)
         {
            _getBtn.enable = CarnivalActivityControl.instance.canGetAward() && _giftCurInfo.times == 0 && _reallyHorseGrade > grade && _reallyHorseGrade <= currentGrade;
            _alreadyGetBtn.visible = _giftCurInfo.times > 0;
            _getBtn.visible = !_alreadyGetBtn.visible;
         }
         else
         {
            _getBtn.enable = CarnivalActivityControl.instance.canGetAward() && _giftCurInfo.times == 0 && _horseSkillGrade > skillGrade && _horseSkillGrade <= currentSkillGrade;
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
