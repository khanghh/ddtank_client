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
      
      public function set debris(value:Vector.<DebrisInfo>) : void
      {
         _debris = value;
      }
      
      public function getHaveDebrisByPageID(pageID:int) : Array
      {
         var debrsInfo:* = null;
         var j:int = 0;
         var i:int = 0;
         var temArr:Array = [];
         var debrisArr:Array = ExplorerManualManager.instance.getDebrisByPageID(pageID);
         var newDebris:Vector.<DebrisInfo> = debris.sort(debrisSort);
         for(j = 0; j < newDebris.length; )
         {
            for(i = 0; i < debrisArr.length; )
            {
               if(debrisArr[i].ID == newDebris[j].debrisID)
               {
                  temArr.push(debrisArr[i]);
               }
               i++;
            }
            j++;
         }
         return temArr;
      }
      
      private function debrisSort(x:DebrisInfo, y:DebrisInfo) : Number
      {
         if(x.date.getTime() < y.date.getTime())
         {
            return -1;
         }
         if(x.date.getTime() > y.date.getTime())
         {
            return 1;
         }
         return 0;
      }
   }
}
