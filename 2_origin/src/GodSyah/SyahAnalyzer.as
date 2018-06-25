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
      
      public function SyahAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var j:int = 0;
         var details:* = null;
         var i:int = 0;
         var mode:* = null;
         var info:* = null;
         var xml:XML = new XML(data);
         _nowTime = _getEndTime(xml.@nowTime,xml.@nowTime);
         if(xml.@value == "true")
         {
            _details = [];
            _modes = new Vector.<SyahMode>();
            _infos = new Vector.<InventoryItemInfo>();
            _syahArr = [];
            _detailsArr = [];
            _modeArr = [];
            xmllist = xml..Condition;
            for(j = 0; j < xml.child("Active").length(); )
            {
               _detailsArr[j] = new Vector.<InventoryItemInfo>();
               _modeArr[j] = new Vector.<SyahMode>();
               details = [];
               details[0] = xml.child("Active")[j].@IsOpen;
               details[1] = _createValid(xml.child("Active")[j].@StartDate,xml.child("Active")[j].@EndDate);
               details[2] = xml.child("Active")[j].@ActiveInfo;
               details[3] = _getEndTime(xml.child("Active")[j].@StartDate,xml.child("Active")[j].@StartTime);
               details[4] = _getEndTime(xml.child("Active")[j].@EndDate,xml.child("Active")[j].@EndTime);
               details[5] = xml.child("Active")[j].@SubID;
               _syahArr[j] = details;
               for(i = 0; i < xmllist.length(); )
               {
                  if(xml.child("Active")[j].@SubID == xmllist[i].@SubID)
                  {
                     mode = _createModeValue(xmllist[i].@Value);
                     mode.syahID = xmllist[i].@ConditionID;
                     mode.level = !!mode.isGold?xmllist[i].@Type - 100:xmllist[i].@Type;
                     mode.valid = _createValid(xml.child("Active")[j].@StartDate,xml.child("Active")[j].@EndDate);
                     _modeArr[j].push(mode);
                     info = new InventoryItemInfo();
                     info.TemplateID = mode.syahID;
                     info = ItemManager.fill(info);
                     info.StrengthenLevel = mode.level;
                     info.isGold = mode.isGold;
                     _detailsArr[j].push(info);
                  }
                  i++;
               }
               j++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeComplete();
         }
      }
      
      private function _createModeValue(s:String) : SyahMode
      {
         var i:int = 0;
         var arr:Array = s.split("-");
         var mode:SyahMode = new SyahMode();
         for(i = 0; i < arr.length; )
         {
            var _loc5_:* = arr[i];
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
                                    mode.isGold = arr[i + 1] == 1?true:false;
                                 }
                              }
                              else
                              {
                                 mode.armor = arr[i + 1];
                              }
                           }
                           else
                           {
                              mode.damage = arr[i + 1];
                           }
                        }
                        else
                        {
                           mode.hp = arr[i + 1];
                        }
                     }
                     else
                     {
                        mode.lucky = arr[i + 1];
                     }
                  }
                  else
                  {
                     mode.agility = arr[i + 1];
                  }
               }
               else
               {
                  mode.defense = arr[i + 1];
               }
            }
            else
            {
               mode.attack = arr[i + 1];
            }
            i = i + 2;
         }
         return mode;
      }
      
      private function _createValid(sd:String, ed:String) : String
      {
         return sd.split(" ")[0].replace("-",".").replace("-",".") + "-" + ed.split(" ")[0].replace("-",".").replace("-",".");
      }
      
      private function _getEndTime(ed:String, et:String) : Date
      {
         var arr1:Array = ed.split(" ")[0].split("-");
         var end:String = arr1[1] + "/" + arr1[2] + "/" + arr1[0] + " " + et.split(" ")[1];
         var date:Date = new Date(end);
         return date;
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
