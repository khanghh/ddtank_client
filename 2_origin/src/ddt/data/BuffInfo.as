package ddt.data
{
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.TimeManager;
   
   public class BuffInfo
   {
      
      public static const FREE:int = 15;
      
      public static const DOUBEL_EXP:int = 13;
      
      public static const DOUBLE_GESTE:int = 12;
      
      public static const PREVENT_KICK:int = 11;
      
      public static const LABYRINTH_STONE:int = 10;
      
      public static const GROW_HELP:int = 14;
      
      public static const LABYRINTH_BUFF:int = 17;
      
      public static const RANDOM_SUIT:int = 18;
      
      public static const DOUBLE_PRESTIGE:int = 26;
      
      public static const GOURD_EXP:int = 27;
      
      public static const Caddy_Good:int = 70;
      
      public static const Save_Life:int = 51;
      
      public static const Agility:int = 50;
      
      public static const ReHealth:int = 52;
      
      public static const Train_Good:int = 71;
      
      public static const Level_Try:int = 72;
      
      public static const Card_Get:int = 73;
      
      public static const Pay_Buff:int = 16;
      
      public static const PropertyWater_74:int = 74;
      
      public static const DOUBLE_CONTRIBUTE:int = 110;
       
      
      public var Type:int;
      
      public var IsExist:Boolean;
      
      public var BeginData:Date;
      
      public var _ValidDate:int;
      
      public var Value:int;
      
      public var TemplateID:int;
      
      private var _ValidCount:int;
      
      public var isSelf:Boolean = true;
      
      private var _buffName:String;
      
      private var _buffItem:ItemTemplateInfo;
      
      private var _description:String;
      
      public var additionCount:int = 0;
      
      public var day:int;
      
      private var _valided:Boolean = true;
      
      public function BuffInfo(type:int = -1, isExist:Boolean = false, beginData:Date = null, validDate:int = 0, value:int = 0, validCount:int = 0, templateID:int = 0)
      {
         super();
         this.Type = type;
         this.IsExist = isExist;
         this.BeginData = beginData;
         this.ValidDate = validDate;
         this.Value = value;
         this._ValidCount = validCount;
         this.TemplateID = templateID;
         initItemInfo();
      }
      
      public function get ValidCount() : int
      {
         return _ValidCount + additionCount;
      }
      
      public function set ValidDate(value:int) : void
      {
         _ValidDate = value;
      }
      
      public function get ValidDate() : int
      {
         return _ValidDate;
      }
      
      public function get maxCount() : int
      {
         return _buffItem != null?int(_buffItem.Property3) + additionCount:0;
      }
      
      public function getLeftTimeByUnit(unit:Number) : int
      {
         if(getLeftTime() > 0)
         {
            var _loc2_:* = unit;
            if(86400000 !== _loc2_)
            {
               if(3600000 !== _loc2_)
               {
                  if(60000 === _loc2_)
                  {
                     return Math.floor(getLeftTime() % 3600000 / 60000);
                  }
               }
               else
               {
                  return Math.floor(getLeftTime() % 86400000 / 3600000);
               }
            }
            else
            {
               return Math.floor(getLeftTime() / 86400000);
            }
         }
         return 0;
      }
      
      public function get valided() : Boolean
      {
         return _valided;
      }
      
      public function calculatePayBuffValidDay() : void
      {
         var now:* = null;
         var begin:* = null;
         var elapsed:int = 0;
         if(BeginData)
         {
            now = TimeManager.Instance.Now();
            begin = new Date(BeginData.fullYear,BeginData.month,BeginData.date);
            now = new Date(now.fullYear,now.month,now.date);
            elapsed = (now.time - begin.time) / 86400000;
            if(elapsed < ValidDate)
            {
               _valided = true;
               day = ValidDate - elapsed;
            }
            else
            {
               _valided = false;
            }
         }
      }
      
      private function getLeftTime() : Number
      {
         var leftTime:* = NaN;
         if(IsExist)
         {
            leftTime = Number(ValidDate - Math.floor((TimeManager.Instance.Now().time - BeginData.time) / 60000));
         }
         else
         {
            leftTime = -1;
         }
         return leftTime * 60000;
      }
      
      public function get buffName() : String
      {
         return _buffItem.Name;
      }
      
      public function get description() : String
      {
         return _buffItem.Data;
      }
      
      public function set description(value:String) : void
      {
         _buffItem.Data = value;
      }
      
      public function get buffItemInfo() : ItemTemplateInfo
      {
         return _buffItem;
      }
      
      public function initItemInfo() : void
      {
         var _loc1_:* = Type;
         if(11 !== _loc1_)
         {
            if(12 !== _loc1_)
            {
               if(13 !== _loc1_)
               {
                  if(15 !== _loc1_)
                  {
                     if(70 !== _loc1_)
                     {
                        if(51 !== _loc1_)
                        {
                           if(50 !== _loc1_)
                           {
                              if(52 !== _loc1_)
                              {
                                 if(72 !== _loc1_)
                                 {
                                    if(73 !== _loc1_)
                                    {
                                       if(71 !== _loc1_)
                                       {
                                          if(10 !== _loc1_)
                                          {
                                             if(26 !== _loc1_)
                                             {
                                                if(14 !== _loc1_)
                                                {
                                                   if(27 !== _loc1_)
                                                   {
                                                      if(17 !== _loc1_)
                                                      {
                                                         if(110 !== _loc1_)
                                                         {
                                                            if(18 !== _loc1_)
                                                            {
                                                               _buffItem = ItemManager.Instance.getTemplateById(TemplateID);
                                                            }
                                                            else
                                                            {
                                                               _buffItem = ItemManager.Instance.getTemplateById(11966);
                                                            }
                                                         }
                                                         else
                                                         {
                                                            _buffItem = ItemManager.Instance.getTemplateById(11956);
                                                         }
                                                      }
                                                      else
                                                      {
                                                         _buffItem = new ItemTemplateInfo();
                                                      }
                                                   }
                                                }
                                                _buffItem = new ItemTemplateInfo();
                                             }
                                             else
                                             {
                                                _buffItem = ItemManager.Instance.getTemplateById(11955);
                                             }
                                          }
                                          else
                                          {
                                             _buffItem = ItemManager.Instance.getTemplateById(11916);
                                          }
                                       }
                                       else
                                       {
                                          _buffItem = ItemManager.Instance.getTemplateById(11911);
                                       }
                                    }
                                    else
                                    {
                                       _buffItem = ItemManager.Instance.getTemplateById(11913);
                                    }
                                 }
                                 else
                                 {
                                    _buffItem = ItemManager.Instance.getTemplateById(11912);
                                 }
                              }
                              else
                              {
                                 _buffItem = ItemManager.Instance.getTemplateById(11910);
                              }
                           }
                           else
                           {
                              _buffItem = ItemManager.Instance.getTemplateById(11909);
                           }
                        }
                        else
                        {
                           _buffItem = ItemManager.Instance.getTemplateById(11908);
                        }
                     }
                     else
                     {
                        _buffItem = ItemManager.Instance.getTemplateById(11907);
                     }
                  }
                  else
                  {
                     _buffItem = ItemManager.Instance.getTemplateById(11995);
                  }
               }
               else
               {
                  _buffItem = ItemManager.Instance.getTemplateById(11998);
               }
            }
            else
            {
               _buffItem = ItemManager.Instance.getTemplateById(11997);
            }
         }
         else
         {
            _buffItem = ItemManager.Instance.getTemplateById(11996);
         }
      }
      
      public function dispose() : void
      {
      }
   }
}
