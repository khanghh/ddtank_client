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
       
      
      public function PetInfoManager(){super();}
      
      public static function setup(param1:PetInfoAnalyzer) : void{}
      
      public static function getPetByTemplateID(param1:int) : PetTemplateInfo{return null;}
      
      public static function getPetByCollectID(param1:int) : PetTemplateInfo{return null;}
      
      public static function getPetByKindID(param1:int) : PetTemplateInfo{return null;}
      
      public static function fillPetInfo(param1:PetInfo) : void{}
   }
}
