package dice.vo
{
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   
   public class DiceAwardInfo
   {
       
      
      private var _level:int;
      
      private var _integral:int;
      
      private var _templateInfo:Vector.<DiceAwardCell>;
      
      public function DiceAwardInfo(param1:int, param2:int, param3:String)
      {
         super();
         _templateInfo = new Vector.<DiceAwardCell>();
         _level = param1;
         _integral = param2;
         setTemplateInfo = param3;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function get integral() : int
      {
         return _integral;
      }
      
      public function get templateInfo() : Vector.<DiceAwardCell>
      {
         return _templateInfo;
      }
      
      private function set setTemplateInfo(param1:String) : void
      {
         var _loc4_:* = null;
         var _loc7_:* = null;
         var _loc5_:* = null;
         var _loc2_:* = null;
         var _loc6_:int = 0;
         if(param1 == null || param1 == "")
         {
            return;
         }
         var _loc3_:Array = param1.split(",");
         _loc6_ = _loc3_.length;
         while(_loc6_ > 0)
         {
            _loc2_ = _loc3_[_loc6_ - 1];
            if(_loc2_ != null && _loc2_ != "")
            {
               _loc7_ = ItemManager.Instance.getTemplateById(int(_loc2_.split("|")[0]));
               _loc4_ = new DiceAwardCell(_loc7_,int(_loc2_.split("|")[1]));
               _templateInfo.push(_loc4_);
            }
            _loc6_--;
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         _loc1_ = _templateInfo.length;
         while(_loc1_ > 0)
         {
            if(_templateInfo[_loc1_ - 1])
            {
               _templateInfo[_loc1_ - 1].dispose();
               _templateInfo[_loc1_ - 1] = null;
            }
            _loc1_--;
         }
         _templateInfo = null;
      }
   }
}
