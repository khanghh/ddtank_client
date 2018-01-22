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
         var _loc3_:int = 0;
         var _loc1_:Array = [];
         if(mainMaterials != "")
         {
            _loc1_ = _loc1_.concat(mainMaterials.split("|"));
         }
         if(auxiliaryMaterials != "")
         {
            _loc1_ = _loc1_.concat(auxiliaryMaterials.split("|"));
         }
         var _loc2_:DictionaryData = new DictionaryData();
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_.add(_loc1_[_loc3_],_loc1_[_loc3_]);
            _loc3_++;
         }
         return _loc2_.list;
      }
      
      public function verificationMaterials(param1:int, param2:int) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc4_:int = -1;
         switch(int(param2))
         {
            case 0:
               _loc4_ = mainMaterials.indexOf(param1.toString());
               break;
            case 1:
               _loc4_ = auxiliaryMaterials.indexOf(param1.toString());
         }
         return _loc4_ >= 0;
      }
   }
}
