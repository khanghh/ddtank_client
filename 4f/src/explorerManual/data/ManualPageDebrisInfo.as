package explorerManual.data
{
   import explorerManual.ExplorerManualManager;
   
   public class ManualPageDebrisInfo
   {
       
      
      private var _debris:Vector.<DebrisInfo>;
      
      public function ManualPageDebrisInfo(){super();}
      
      public function get debris() : Vector.<DebrisInfo>{return null;}
      
      public function set debris(param1:Vector.<DebrisInfo>) : void{}
      
      public function getHaveDebrisByPageID(param1:int) : Array{return null;}
      
      private function debrisSort(param1:DebrisInfo, param2:DebrisInfo) : Number{return 0;}
   }
}
