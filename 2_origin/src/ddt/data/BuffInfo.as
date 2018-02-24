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
      
      public function BuffInfo(param1:int = -1, param2:Boolean = false, param3:Date = null, param4:int = 0, param5:int = 0, param6:int = 0, param7:int = 0)
      {
         super();
         this.Type = param1;
         this.IsExist = param2;
         this.BeginData = param3;
         this.ValidDate = param4;
         this.Value = param5;
         this._ValidCount = param6;
         this.TemplateID = param7;
         initItemInfo();
      }
      
      public function get ValidCount() : int
      {
         return _ValidCount + additionCount;
      }
      
      public function set ValidDate(param1:int) : void
      {
         _ValidDate = param1;
      }
      
      public function get ValidDate() : int
      {
         return _ValidDate;
      }
      
      public function get maxCount() : int
      {
         return _buffItem != null?int(_buffItem.Property3) + additionCount:0;
      }
      
      public function getLeftTimeByUnit(param1:Number) : int
      {
         if(getLeftTime() > 0)
         {
            var _loc2_:* = param1;
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
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc1_:int = 0;
         if(BeginData)
         {
            _loc2_ = TimeManager.Instance.Now();
            _loc3_ = new Date(BeginData.fullYear,BeginData.month,BeginData.date);
            _loc2_ = new Date(_loc2_.fullYear,_loc2_.month,_loc2_.date);
            _loc1_ = (_loc2_.time - _loc3_.time) / 86400000;
            if(_loc1_ < ValidDate)
            {
               _valided = true;
               day = ValidDate - _loc1_;
            }
            else
            {
               _valided = false;
            }
         }
      }
      
      private function getLeftTime() : Number
      {
         var _loc1_:* = NaN;
         if(IsExist)
         {
            _loc1_ = Number(ValidDate - Math.floor((TimeManager.Instance.Now().time - BeginData.time) / 60000));
         }
         else
         {
            _loc1_ = -1;
         }
         return _loc1_ * 60000;
      }
      
      public function get buffName() : String
      {
         return _buffItem.Name;
      }
      
      public function get description() : String
      {
         return _buffItem.Data;
      }
      
      public function set description(param1:String) : void
      {
         _buffItem.Data = param1;
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
