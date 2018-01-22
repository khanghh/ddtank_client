package ddt.manager
{
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.analyze.PetInfoAnalyzer;
   import flash.utils.Dictionary;
   import pet.data.PetInfo;
   import pet.data.PetTemplateInfo;
   
   public class PetInfoManager
   {
      
      private static var _list:Dictionary;
       
      
      public function PetInfoManager()
      {
         super();
      }
      
      public static function setup(param1:PetInfoAnalyzer) : void
      {
         _list = param1.list;
      }
      
      public static function getPetByTemplateID(param1:int) : PetTemplateInfo
      {
         return _list[param1];
      }
      
      public static function getPetByCollectID(param1:int) : PetTemplateInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = _list;
         for each(var _loc2_ in _list)
         {
            if(_loc2_.CollectID == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function getPetByKindID(param1:int) : PetTemplateInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = _list;
         for each(var _loc2_ in _list)
         {
            if(_loc2_.KindID == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function fillPetInfo(param1:PetInfo) : void
      {
         var _loc2_:PetTemplateInfo = _list[param1.TemplateID];
         ObjectUtils.copyProperties(param1,_loc2_);
      }
   }
}
