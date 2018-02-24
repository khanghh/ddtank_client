package bones.model
{
   import road7th.data.DictionaryData;
   
   public class BonesModel
   {
      
      public static const BONES:String = "bones";
      
      public static const BONES_GAME:String = "gamebones";
       
      
      private var _parasBones:DictionaryData;
      
      private var _boneSets:DictionaryData;
      
      private var _dynamicBoneSets:DictionaryData;
      
      public function BonesModel(){super();}
      
      public function getBonesStyle(param1:String) : BoneVo{return null;}
      
      public function hasLoadingBones(param1:String) : Boolean{return false;}
      
      public function parasBonesStyle(param1:XMLList, param2:String) : void{}
      
      public function getBoneVoListByAtlasName(param1:String) : Array{return null;}
      
      public function addBoneVo(param1:BoneVo) : void{}
      
      public function addBoneVoByStyle(param1:String, param2:String, param3:int = 0, param4:int = 2, param5:String = "none") : void{}
   }
}
