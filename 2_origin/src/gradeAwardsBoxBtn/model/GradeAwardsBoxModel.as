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
       
      
      public function GradeAwardsBoxModel(param1:inner)
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
         var _loc3_:* = null;
         var _loc1_:BagInfo = PlayerManager.Instance.Self.PropBag;
         if(_loc1_ != null)
         {
            _loc3_ = _loc1_.items;
            var _loc6_:int = 0;
            var _loc5_:* = _loc3_;
            while(true)
            {
               for each(var _loc2_ in _loc3_)
               {
                  var _loc4_:* = _loc2_["TemplateID"];
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
                           addr34:
                        }
                        return _loc2_ as InventoryItemInfo;
                     }
                     break;
                  }
                  break;
               }
            }
            §§goto(addr34);
         }
         return null;
      }
      
      public function isTheLastBoxBtn(param1:InventoryItemInfo) : Boolean
      {
         if(param1.TemplateID == 1120101)
         {
            return true;
         }
         return false;
      }
      
      public function canGainGradeAwardsOnButtonClicked(param1:InventoryItemInfo) : int
      {
         var _loc2_:int = PlayerManager.Instance.Self.Grade;
         if(param1 != null && !isNaN(param1.getRemainDate()) && param1.getRemainDate() <= 0)
         {
            return 0;
         }
         if(canGain(param1) == false)
         {
            return 1;
         }
         return 2;
      }
      
      public function canGain(param1:InventoryItemInfo) : Boolean
      {
         return param1.NeedLevel <= PlayerManager.Instance.Self.Grade;
      }
      
      public function isShowGradeAwardsBtn(param1:InventoryItemInfo = null) : Boolean
      {
         if(param1 != null && !isNaN(param1.getRemainDate()) && param1.getRemainDate() > 0)
         {
            return true;
         }
         return false;
      }
      
      public function getRemainTime(param1:InventoryItemInfo) : String
      {
         var _loc4_:* = null;
         var _loc5_:Number = NaN;
         var _loc6_:* = null;
         var _loc9_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc10_:* = null;
         var _loc8_:* = NaN;
         var _loc7_:* = null;
         var _loc2_:* = null;
         var _loc11_:String = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.less");
         var _loc14_:String = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.time");
         var _loc15_:String = LanguageMgr.GetTranslation("minute2");
         var _loc3_:String = LanguageMgr.GetTranslation("hour2");
         var _loc13_:String = LanguageMgr.GetTranslation("shop.ShopIIShoppingCarItem.day");
         if(param1 is InventoryItemInfo)
         {
            _loc6_ = param1 as InventoryItemInfo;
            _loc9_ = _loc6_.getRemainDate();
            _loc12_ = _loc6_.getColorValidDate();
            _loc10_ = _loc6_.CategoryID == 7?LanguageMgr.GetTranslation("bag.changeColor.tips.armName"):"";
            if(_loc12_ > 0 && _loc12_ != 2147483647)
            {
               if(_loc12_ >= 1)
               {
                  _loc4_ = (!!_loc6_.IsUsed?LanguageMgr.GetTranslation("bag.changeColor.tips.name") + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.less"):LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.time")) + Math.ceil(_loc12_) + LanguageMgr.GetTranslation("shop.ShopIIShoppingCarItem.day");
               }
               else
               {
                  _loc8_ = Number(Math.floor(_loc12_ * 24));
                  if(_loc8_ < 1)
                  {
                     _loc8_ = 1;
                  }
                  _loc4_ = (!!_loc6_.IsUsed?LanguageMgr.GetTranslation("bag.changeColor.tips.name") + LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.less"):LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.time")) + _loc8_ + LanguageMgr.GetTranslation("hours");
               }
            }
            if(_loc9_ == 2147483647)
            {
               _loc4_ = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.use");
            }
            else if(_loc9_ > 0)
            {
               _loc7_ = (int(_loc9_ * 24)).toString();
               _loc2_ = (int((_loc9_ * 24 - Math.floor(_loc9_ * 24)) * 60)).toString();
               _loc5_ = Math.ceil(_loc9_);
               _loc4_ = (!!_loc6_.IsUsed?_loc10_ + _loc11_:_loc14_) + _loc7_ + _loc3_ + _loc2_ + _loc15_;
            }
            else if(!isNaN(_loc9_))
            {
               _loc4_ = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.over");
            }
         }
         return _loc4_;
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
