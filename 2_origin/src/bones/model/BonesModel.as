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
      
      public function BonesModel()
      {
         super();
         _boneSets = new DictionaryData();
         _parasBones = new DictionaryData();
         _dynamicBoneSets = new DictionaryData();
      }
      
      public function getBonesStyle(styleName:String) : BoneVo
      {
         return _boneSets[styleName] || _dynamicBoneSets[styleName];
      }
      
      public function hasLoadingBones(type:String) : Boolean
      {
         return _parasBones.hasKey(type);
      }
      
      public function parasBonesStyle(list:XMLList, type:String) : void
      {
         var i:int = 0;
         var xml:* = null;
         var vo:* = null;
         if(hasLoadingBones(type))
         {
            trace("该bones xml已经解析过了 type:" + type + " ,请勿重复加载解析!!!!!!!!");
            return;
         }
         _parasBones.add(type,true);
         var listLen:int = list.length();
         for(i = 0; i < listLen; )
         {
            xml = list[i] as XML;
            vo = new BoneVo();
            vo.styleName = xml.@styleName;
            vo.atlasName = xml.@atlasName;
            vo.path = xml.@path;
            if(xml.hasOwnProperty("@loadType"))
            {
               vo.loadType = int(xml.@loadType);
            }
            if(xml.hasOwnProperty("@boneType"))
            {
               vo.boneType = xml.@boneType;
            }
            if(xml.hasOwnProperty("@ext"))
            {
               vo.ext = xml.@ext;
            }
            if(_boneSets.hasKey(vo.styleName))
            {
               trace("bone name " + vo.styleName + "重名, 请注意检查!!!!!!!!!!!!!!!!!!!!");
            }
            else
            {
               _boneSets.add(vo.styleName,vo);
            }
            i++;
         }
      }
      
      public function getBoneVoListByAtlasName(name:String) : Array
      {
         var i:int = 0;
         var j:int = 0;
         var list:Array = [];
         var len:int = _boneSets.length;
         for(i = 0; i < len; )
         {
            if(name == _boneSets.list[i].atlasName)
            {
               list.push(_boneSets.list[i]);
            }
            i++;
         }
         if(list.length == 0)
         {
            len = _dynamicBoneSets.length;
            for(j = 0; j < len; )
            {
               if(name == _dynamicBoneSets.list[j].atlasName)
               {
                  list.push(_dynamicBoneSets.list[j]);
               }
               j++;
            }
         }
         return list;
      }
      
      public function addBoneVo(vo:BoneVo) : void
      {
         _dynamicBoneSets.add(vo.styleName,vo);
      }
      
      public function addBoneVoByStyle(name:String, path:String, loadType:int = 0, useType:int = 2, boneType:String = "none") : void
      {
         var vo:BoneVo = new BoneVo();
         var _loc7_:* = name;
         vo.atlasName = _loc7_;
         vo.styleName = _loc7_;
         vo.path = path;
         vo.loadType = loadType;
         vo.useType = useType;
         vo.boneType = boneType;
         addBoneVo(vo);
      }
   }
}
