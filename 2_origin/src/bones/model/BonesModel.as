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
      
      public function getBonesStyle(param1:String) : BoneVo
      {
         return _boneSets[param1] || _dynamicBoneSets[param1];
      }
      
      public function hasLoadingBones(param1:String) : Boolean
      {
         return _parasBones.hasKey(param1);
      }
      
      public function parasBonesStyle(param1:XMLList, param2:String) : void
      {
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc5_:* = null;
         if(hasLoadingBones(param2))
         {
            return;
            §§push(trace("该bones xml已经解析过了 type:" + param2 + " ,请勿重复加载解析!!!!!!!!"));
         }
         else
         {
            _parasBones.add(param2,true);
            var _loc3_:int = param1.length();
            _loc6_ = 0;
            while(_loc6_ < _loc3_)
            {
               _loc4_ = param1[_loc6_] as XML;
               _loc5_ = new BoneVo();
               _loc5_.styleName = _loc4_.@styleName;
               _loc5_.atlasName = _loc4_.@atlasName;
               _loc5_.path = _loc4_.@path;
               if(_loc4_.hasOwnProperty("@loadType"))
               {
                  _loc5_.loadType = int(_loc4_.@loadType);
               }
               if(_loc4_.hasOwnProperty("@boneType"))
               {
                  _loc5_.boneType = _loc4_.@boneType;
               }
               if(_loc4_.hasOwnProperty("@ext"))
               {
                  _loc5_.ext = _loc4_.@ext;
               }
               if(_boneSets.hasKey(_loc5_.styleName))
               {
                  trace("bone name " + _loc5_.styleName + "重名, 请注意检查!!!!!!!!!!!!!!!!!!!!");
               }
               else
               {
                  _boneSets.add(_loc5_.styleName,_loc5_);
               }
               _loc6_++;
            }
            return;
         }
      }
      
      public function getBoneVoListByAtlasName(param1:String) : Array
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         var _loc3_:int = _boneSets.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            if(param1 == _boneSets.list[_loc5_].atlasName)
            {
               _loc2_.push(_boneSets.list[_loc5_]);
            }
            _loc5_++;
         }
         if(_loc2_.length == 0)
         {
            _loc3_ = _dynamicBoneSets.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               if(param1 == _dynamicBoneSets.list[_loc4_].atlasName)
               {
                  _loc2_.push(_dynamicBoneSets.list[_loc4_]);
               }
               _loc4_++;
            }
         }
         return _loc2_;
      }
      
      public function addBoneVo(param1:BoneVo) : void
      {
         _dynamicBoneSets.add(param1.styleName,param1);
      }
      
      public function addBoneVoByStyle(param1:String, param2:String, param3:int = 0, param4:int = 2, param5:String = "none") : void
      {
         var _loc6_:BoneVo = new BoneVo();
         var _loc7_:* = param1;
         _loc6_.atlasName = _loc7_;
         _loc6_.styleName = _loc7_;
         _loc6_.path = param2;
         _loc6_.loadType = param3;
         _loc6_.useType = param4;
         _loc6_.boneType = param5;
         addBoneVo(_loc6_);
      }
   }
}
