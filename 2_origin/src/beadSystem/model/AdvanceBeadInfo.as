package beadSystem.model
{
   import flash.events.EventDispatcher;
   import road7th.data.DictionaryData;
   
   public class AdvanceBeadInfo extends EventDispatcher
   {
       
      
      public var advancedTempId:int;
      
      public var runeName:String;
      
      public var advanceDesc:String;
      
      public var mainMaterials:String;
      
      public var auxiliaryMaterials:String;
      
      public var quality:int;
      
      public var maxLevelTempRunId:int;
      
      public function AdvanceBeadInfo()
      {
         super();
      }
      
      public function getAllBead() : Array
      {
         var i:int = 0;
         var temArr:Array = [];
         if(mainMaterials != "")
         {
            temArr = temArr.concat(mainMaterials.split("|"));
         }
         if(auxiliaryMaterials != "")
         {
            temArr = temArr.concat(auxiliaryMaterials.split("|"));
         }
         var dic:DictionaryData = new DictionaryData();
         for(i = 0; i < temArr.length; )
         {
            dic.add(temArr[i],temArr[i]);
            i++;
         }
         return dic.list;
      }
      
      public function verificationMaterials(temID:int, type:int) : Boolean
      {
         var temBol:Boolean = false;
         var temIndex:int = -1;
         switch(int(type))
         {
            case 0:
               temIndex = mainMaterials.indexOf(temID.toString());
               break;
            case 1:
               temIndex = auxiliaryMaterials.indexOf(temID.toString());
         }
         return temIndex >= 0;
      }
   }
}
