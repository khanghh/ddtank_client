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
      
      public static function setup(analyzer:PetInfoAnalyzer) : void
      {
         _list = analyzer.list;
      }
      
      public static function getPetByTemplateID(id:int) : PetTemplateInfo
      {
         return _list[id];
      }
      
      public static function getPetByCollectID(id:int) : PetTemplateInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = _list;
         for each(var info in _list)
         {
            if(info.CollectID == id)
            {
               return info;
            }
         }
         return null;
      }
      
      public static function getPetByKindID(id:int) : PetTemplateInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = _list;
         for each(var info in _list)
         {
            if(info.KindID == id)
            {
               return info;
            }
         }
         return null;
      }
      
      public static function fillPetInfo(p:PetInfo) : void
      {
         var petTemp:PetTemplateInfo = _list[p.TemplateID];
         ObjectUtils.copyProperties(p,petTemp);
      }
   }
}
