package explorerManual.data
{
   import explorerManual.ExplorerManualManager;
   
   public class ManualPageDebrisInfo
   {
       
      
      private var _debris:Vector.<DebrisInfo>;
      
      public function ManualPageDebrisInfo()
      {
         super();
         _debris = new Vector.<DebrisInfo>();
      }
      
      public function get debris() : Vector.<DebrisInfo>
      {
         return _debris;
      }
      
      public function set debris(param1:Vector.<DebrisInfo>) : void
      {
         _debris = param1;
      }
      
      public function getHaveDebrisByPageID(param1:int) : Array
      {
         var _loc3_:* = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc4_:Array = [];
         var _loc2_:Array = ExplorerManualManager.instance.getDebrisByPageID(param1);
         var _loc5_:Vector.<DebrisInfo> = debris.sort(debrisSort);
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc2_.length)
            {
               if(_loc2_[_loc7_].ID == _loc5_[_loc6_].debrisID)
               {
                  _loc4_.push(_loc2_[_loc7_]);
               }
               _loc7_++;
            }
            _loc6_++;
         }
         return _loc4_;
      }
      
      private function debrisSort(param1:DebrisInfo, param2:DebrisInfo) : Number
      {
         if(param1.date.getTime() < param2.date.getTime())
         {
            return -1;
         }
         if(param1.date.getTime() > param2.date.getTime())
         {
            return 1;
         }
         return 0;
      }
   }
}
