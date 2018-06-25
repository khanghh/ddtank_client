package ddt.manager{   import com.pickgliss.utils.ObjectUtils;   import ddt.data.analyze.PetInfoAnalyzer;   import flash.utils.Dictionary;   import pet.data.PetInfo;   import pet.data.PetTemplateInfo;      public class PetInfoManager   {            private static var _list:Dictionary;                   public function PetInfoManager() { super(); }
            public static function setup(analyzer:PetInfoAnalyzer) : void { }
            public static function getPetByTemplateID(id:int) : PetTemplateInfo { return null; }
            public static function getPetByCollectID(id:int) : PetTemplateInfo { return null; }
            public static function getPetByKindID(id:int) : PetTemplateInfo { return null; }
            public static function fillPetInfo(p:PetInfo) : void { }
   }}