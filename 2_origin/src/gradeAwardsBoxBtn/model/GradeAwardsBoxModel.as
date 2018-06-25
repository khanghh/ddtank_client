package gradeAwardsBoxBtn.model
{
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import road7th.data.DictionaryData;
   
   public class GradeAwardsBoxModel
   {
      
      private static var instance:GradeAwardsBoxModel;
       
      
      public function GradeAwardsBoxModel(single:inner)
      {
         super();
      }
      
      public static function getInstance() : GradeAwardsBoxModel
      {
         if(!instance)
         {
            instance = new GradeAwardsBoxModel(new inner());
         }
         return instance;
      }
      
      public function getGradeAwardsBoxInfo() : InventoryItemInfo
      {
         var itemInfos:* = null;
         var bagInfo:BagInfo = PlayerManager.Instance.Self.PropBag;
         if(bagInfo != null)
         {
            itemInfos = bagInfo.items;
            var _loc6_:int = 0;
            var _loc5_:* = itemInfos;
            while(true)
            {
               for each(var i in itemInfos)
               {
                  var _loc4_:* = i["TemplateID"];
                  if(1120098 !== _loc4_)
                  {
                     if(1120099 !== _loc4_)
                     {
                        if(1120100 !== _loc4_)
                        {
                           if(1120101 !== _loc4_)
                           {
                              continue;
                           }
                        }
                        else
                        {
                           addr43:
                        }
                        return i as InventoryItemInfo;
                     }
                     break;
                  }
                  break;
               }
            }
            §§goto(addr43);
         }
         return null;
      }
      
      public function isTheLastBoxBtn(itemInfo:InventoryItemInfo) : Boolean
      {
         if(itemInfo.TemplateID == 1120101)
         {
            return true;
         }
         return false;
      }
      
      public function canGainGradeAwardsOnButtonClicked(itemInfo:InventoryItemInfo) : int
      {
         var playerLevel:int = PlayerManager.Instance.Self.Grade;
         if(itemInfo != null && !isNaN(itemInfo.getRemainDate()) && itemInfo.getRemainDate() <= 0)
         {
            return 0;
         }
         if(canGain(itemInfo) == false)
         {
            return 1;
         }
         return 2;
      }
      
      public function canGain(info:InventoryItemInfo) : Boolean
      {
         return info.NeedLevel <= PlayerManager.Instance.Self.Grade;
      }
      
      public function isShowGradeAwardsBtn(info:InventoryItemInfo = null) : Boolean
      {
         if(info != null && !isNaN(info.getRemainDate()) && info.getRemainDate() > 0)
         {
            return true;
         }
         return false;
      }
      
      public function getRemainTime(_info:InventoryItemInfo) : String
      {
         var timeStr:* = null;
         var tempReman:Number = NaN;
         var tempInfo:* = null;
         var remain:Number = NaN;
         var colorDate:Number = NaN;
         var str:* = null;
         var hour:* = NaN;
         var hh:* = null;
         var mm:* = null;
         var wordRemain:String = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.less");
         var wordUseBefore:String = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.time");
         var wordMinute:String = LanguageMgr.GetTranslation("minute2");
         var wordHours:String = LanguageMgr.GetTranslation("hour2");
         var wordDays:String = LanguageMgr.GetTranslation("shop.ShopIIShoppingCarItem.day");
         if(_info is InventoryItemInfo)
         {
            tempInfo = _info as InventoryItemInfo;
            remain = tempInfo.getRemainDate();
            colorDate = tempInfo.getColorValidDate();
            str = tempInfo.CategoryID == 7?LanguageMgr.GetTranslation("bag.changeColor.tips.armName"):"";
            if(colorDate > 0 && colorDate != 2147483647)
            {
               if(colorDate >= 1)
               {
                  timeStr = (!!tempInfo.IsUsed?LanguageMgr.GetTranslation("bag.changeColor.tips.name") + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.less"):LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.time")) + Math.ceil(colorDate) + LanguageMgr.GetTranslation("shop.ShopIIShoppingCarItem.day");
               }
               else
               {
                  hour = Number(Math.floor(colorDate * 24));
                  if(hour < 1)
                  {
                     hour = 1;
                  }
                  timeStr = (!!tempInfo.IsUsed?LanguageMgr.GetTranslation("bag.changeColor.tips.name") + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.less"):LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.time")) + hour + LanguageMgr.GetTranslation("hours");
               }
            }
            if(remain == 2147483647)
            {
               timeStr = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.use");
            }
            else if(remain > 0)
            {
               hh = (int(remain * 24)).toString();
               mm = (int((remain * 24 - Math.floor(remain * 24)) * 60)).toString();
               tempReman = Math.ceil(remain);
               timeStr = (!!tempInfo.IsUsed?str + wordRemain:wordUseBefore) + hh + wordHours + mm + wordMinute;
            }
            else if(!isNaN(remain))
            {
               timeStr = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.over");
            }
         }
         return timeStr;
      }
   }
}

class inner
{
    
   
   function inner()
   {
      super();
   }
}
