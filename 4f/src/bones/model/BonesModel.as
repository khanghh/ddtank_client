package bones.model{   import road7th.data.DictionaryData;      public class BonesModel   {            public static const BONES:String = "bones";            public static const BONES_GAME:String = "gamebones";                   private var _parasBones:DictionaryData;            private var _boneSets:DictionaryData;            private var _dynamicBoneSets:DictionaryData;            public function BonesModel() { super(); }
            public function getBonesStyle(styleName:String) : BoneVo { return null; }
            public function hasLoadingBones(type:String) : Boolean { return false; }
            public function parasBonesStyle(list:XMLList, type:String) : void { }
            public function getBoneVoListByAtlasName(name:String) : Array { return null; }
            public function addBoneVo(vo:BoneVo) : void { }
            public function addBoneVoByStyle(name:String, path:String, loadType:int = 0, useType:int = 2, boneType:String = "none") : void { }
   }}