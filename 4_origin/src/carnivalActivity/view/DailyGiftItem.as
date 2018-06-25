package carnivalActivity.view
{
   import carnivalActivity.CarnivalActivityControl;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.goods.QualityType;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.PlayerCurInfo;
   
   public class DailyGiftItem extends CarnivalActivityItem
   {
       
      
      private var _count:int;
      
      private var _temId:int;
      
      private var _getGoodsType:int;
      
      private var _beadGrade:int;
      
      private var _magicStoneQuality:int;
      
      private var _actType:int;
      
      public function DailyGiftItem(type:int, info:GiftBagInfo, index:int)
      {
         super(type,info,index);
      }
      
      override protected function initItem() : void
      {
         var i:int = 0;
         var quality:int = 0;
         _awardCountTxt = ComponentFactory.Instance.creatComponentByStylename("carnivalAct.countTxt");
         addChild(_awardCountTxt);
         for(i = 0; i < _info.giftConditionArr.length; )
         {
            if(_info.giftConditionArr[i].conditionIndex == 0)
            {
               _actType = 1;
            }
            else if(_info.giftConditionArr[i].conditionIndex == 1)
            {
               _actType = 2;
               _count = _info.giftConditionArr[i].remain1;
               _getGoodsType = int(_info.giftConditionArr[i].remain2);
               if(_getGoodsType == 2)
               {
                  _beadGrade = _info.giftConditionArr[i].conditionValue;
               }
               else
               {
                  _magicStoneQuality = _info.giftConditionArr[i].conditionValue;
               }
            }
            else if(_info.giftConditionArr[i].conditionIndex == 2)
            {
               _actType = 3;
            }
            else if(_info.giftConditionArr[i].conditionIndex != 3)
            {
               if(_info.giftConditionArr[i].conditionIndex > 50 && _info.giftConditionArr[i].conditionIndex < 100)
               {
                  _temId = _info.giftConditionArr[i].conditionValue;
                  _count = _info.giftConditionArr[i].remain1;
               }
            }
            i++;
         }
         _descTxt.height = _descTxt.height * 2;
         if(_actType == 1)
         {
            _descTxt.y = _descTxt.y - 8;
            _awardCountTxt.y = _awardCountTxt.y + 7;
            _descTxt.text = LanguageMgr.GetTranslation("dailyGift.useType.descTxt",_count,ItemManager.Instance.getTemplateById(_temId).Name);
         }
         else if(_actType == 2)
         {
            if(_getGoodsType == 1)
            {
               _descTxt.text = LanguageMgr.GetTranslation("dailyGift.getType.descTxt" + _getGoodsType,_count);
            }
            else if(_getGoodsType == 2)
            {
               _descTxt.text = LanguageMgr.GetTranslation("dailyGift.getType.descTxt" + _getGoodsType,_count,_beadGrade);
            }
            else
            {
               quality = _magicStoneQuality / 100;
               _descTxt.text = LanguageMgr.GetTranslation("dailyGift.getType.descTxt" + _getGoodsType,_count,QualityType.QUALITY_STRING[quality]);
            }
         }
         else
         {
            _descTxt.y = _descTxt.y - 8;
            _awardCountTxt.y = _awardCountTxt.y + 7;
            _descTxt.text = LanguageMgr.GetTranslation("dailyGift.getType.plantTxt",_count,ItemManager.Instance.getTemplateById(_temId).Name);
         }
      }
      
      override public function updateView() : void
      {
         var magicStoneInfo:* = null;
         var beadInfo:* = null;
         _giftCurInfo = WonderfulActivityManager.Instance.activityInitData[_info.activityId].giftInfoDic[_info.giftbagId];
         _statusArr = WonderfulActivityManager.Instance.activityInitData[_info.activityId].statusArr;
         var _loc5_:int = 0;
         var _loc4_:* = _statusArr;
         for each(var info in _statusArr)
         {
            if(_actType == 1 || _actType == 3)
            {
               if(info.statusID == _temId)
               {
                  _getBtn.enable = CarnivalActivityControl.instance.canGetAward() && _giftCurInfo.times == 0 && info.statusValue >= _count;
                  _awardCountTxt.text = info.statusValue + "/" + _count;
               }
            }
            else if(_getGoodsType == 3)
            {
               if(info.statusID == _magicStoneQuality)
               {
                  magicStoneInfo = info;
               }
            }
            else if(_getGoodsType == 2)
            {
               if(info.statusID == _beadGrade)
               {
                  beadInfo = info;
               }
            }
            else
            {
               _getBtn.enable = CarnivalActivityControl.instance.canGetAward() && _giftCurInfo.times == 0 && info.statusValue >= _count;
               _awardCountTxt.text = info.statusValue + "/" + _count;
            }
         }
         if(_actType == 2)
         {
            if(_getGoodsType == 3)
            {
               _getBtn.enable = CarnivalActivityControl.instance.canGetAward() && magicStoneInfo?_giftCurInfo.times == 0 && magicStoneInfo.statusValue >= _count:false;
               _awardCountTxt.text = (!!magicStoneInfo?magicStoneInfo.statusValue:0) + "/" + _count;
            }
            else if(_getGoodsType == 2)
            {
               _getBtn.enable = CarnivalActivityControl.instance.canGetAward() && beadInfo?_giftCurInfo.times == 0 && beadInfo.statusValue >= _count:false;
               _awardCountTxt.text = (!!beadInfo?beadInfo.statusValue:0) + "/" + _count;
            }
         }
         _alreadyGetBtn.visible = _giftCurInfo.times > 0;
         _getBtn.visible = !_alreadyGetBtn.visible;
      }
   }
}
