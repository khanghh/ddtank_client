package GodSyah
{
   import com.pickgliss.loader.DataAnalyzer;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   
   public class SyahAnalyzer extends DataAnalyzer
   {
       
      
      private var _details:Array;
      
      private var _modes:Vector.<SyahMode>;
      
      private var _infos:Vector.<InventoryItemInfo>;
      
      private var _nowTime:Date;
      
      private var _syahArr:Array;
      
      private var _detailsArr:Array;
      
      private var _modeArr:Array;
      
      public function SyahAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc8_:int = 0;
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc3_:XML = new XML(param1);
         _nowTime = _getEndTime(_loc3_.@nowTime,_loc3_.@nowTime);
         if(_loc3_.@value == "true")
         {
            _details = [];
            _modes = new Vector.<SyahMode>();
            _infos = new Vector.<InventoryItemInfo>();
            _syahArr = [];
            _detailsArr = [];
            _modeArr = [];
            _loc4_ = _loc3_..Condition;
            _loc5_ = 0;
            while(_loc5_ < _loc3_.child("Active").length())
            {
               _detailsArr[_loc5_] = new Vector.<InventoryItemInfo>();
               _modeArr[_loc5_] = new Vector.<SyahMode>();
               _loc2_ = [];
               _loc2_[0] = _loc3_.child("Active")[_loc5_].@IsOpen;
               _loc2_[1] = _createValid(_loc3_.child("Active")[_loc5_].@StartDate,_loc3_.child("Active")[_loc5_].@EndDate);
               _loc2_[2] = _loc3_.child("Active")[_loc5_].@ActiveInfo;
               _loc2_[3] = _getEndTime(_loc3_.child("Active")[_loc5_].@StartDate,_loc3_.child("Active")[_loc5_].@StartTime);
               _loc2_[4] = _getEndTime(_loc3_.child("Active")[_loc5_].@EndDate,_loc3_.child("Active")[_loc5_].@EndTime);
               _loc2_[5] = _loc3_.child("Active")[_loc5_].@SubID;
               _syahArr[_loc5_] = _loc2_;
               _loc8_ = 0;
               while(_loc8_ < _loc4_.length())
               {
                  if(_loc3_.child("Active")[_loc5_].@SubID == _loc4_[_loc8_].@SubID)
                  {
                     _loc7_ = _createModeValue(_loc4_[_loc8_].@Value);
                     _loc7_.syahID = _loc4_[_loc8_].@ConditionID;
                     _loc7_.level = !!_loc7_.isGold?_loc4_[_loc8_].@Type - 100:_loc4_[_loc8_].@Type;
                     _loc7_.valid = _createValid(_loc3_.child("Active")[_loc5_].@StartDate,_loc3_.child("Active")[_loc5_].@EndDate);
                     _modeArr[_loc5_].push(_loc7_);
                     _loc6_ = new InventoryItemInfo();
                     _loc6_.TemplateID = _loc7_.syahID;
                     _loc6_ = ItemManager.fill(_loc6_);
                     _loc6_.StrengthenLevel = _loc7_.level;
                     _loc6_.isGold = _loc7_.isGold;
                     _detailsArr[_loc5_].push(_loc6_);
                  }
                  _loc8_++;
               }
               _loc5_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc3_.@message;
            onAnalyzeComplete();
         }
      }
      
      private function _createModeValue(param1:String) : SyahMode
      {
         var _loc3_:int = 0;
         var _loc2_:Array = param1.split("-");
         var _loc4_:SyahMode = new SyahMode();
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            var _loc5_:* = _loc2_[_loc3_];
            if("1" !== _loc5_)
            {
               if("2" !== _loc5_)
               {
                  if("3" !== _loc5_)
                  {
                     if("4" !== _loc5_)
                     {
                        if("5" !== _loc5_)
                        {
                           if("6" !== _loc5_)
                           {
                              if("7" !== _loc5_)
                              {
                                 if("11" === _loc5_)
                                 {
                                    _loc4_.isGold = _loc2_[_loc3_ + 1] == 1?true:false;
                                 }
                              }
                              else
                              {
                                 _loc4_.armor = _loc2_[_loc3_ + 1];
                              }
                           }
                           else
                           {
                              _loc4_.damage = _loc2_[_loc3_ + 1];
                           }
                        }
                        else
                        {
                           _loc4_.hp = _loc2_[_loc3_ + 1];
                        }
                     }
                     else
                     {
                        _loc4_.lucky = _loc2_[_loc3_ + 1];
                     }
                  }
                  else
                  {
                     _loc4_.agility = _loc2_[_loc3_ + 1];
                  }
               }
               else
               {
                  _loc4_.defense = _loc2_[_loc3_ + 1];
               }
            }
            else
            {
               _loc4_.attack = _loc2_[_loc3_ + 1];
            }
            _loc3_ = _loc3_ + 2;
         }
         return _loc4_;
      }
      
      private function _createValid(param1:String, param2:String) : String
      {
         return param1.split(" ")[0].replace("-",".").replace("-",".") + "-" + param2.split(" ")[0].replace("-",".").replace("-",".");
      }
      
      private function _getEndTime(param1:String, param2:String) : Date
      {
         var _loc3_:Array = param1.split(" ")[0].split("-");
         var _loc5_:String = _loc3_[1] + "/" + _loc3_[2] + "/" + _loc3_[0] + " " + param2.split(" ")[1];
         var _loc4_:Date = new Date(_loc5_);
         return _loc4_;
      }
      
      public function get modes() : Array
      {
         return _modeArr;
      }
      
      public function get details() : Array
      {
         return _syahArr;
      }
      
      public function get infos() : Array
      {
         return _detailsArr;
      }
      
      public function get nowTime() : Date
      {
         return _nowTime;
      }
   }
}
