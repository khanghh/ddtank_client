package starling.display.sceneCharacter
{
   import flash.geom.Rectangle;
   import road7th.DDTAssetManager;
   import road7th.data.DictionaryData;
   import starling.textures.SubTexture;
   import starling.textures.Texture;
   import starling.textures.TextureAtlas;
   
   public class SceneCharacterSynthesisBase
   {
      
      public static const PARSE_TEXTURE:int = 0;
      
      public static const PARSE_TEXTUREATLAS:int = 1;
       
      
      private var _textureSet:SceneCharacterTextureSet;
      
      private var _actionSet:SceneCharacterActionSet;
      
      private var _actionPointSet:SceneCharacterActionPointSet;
      
      private var _callBack:Function;
      
      private var _characterFrames:DictionaryData;
      
      public function SceneCharacterSynthesisBase(param1:SceneCharacterTextureSet, param2:Function)
      {
         super();
         _textureSet = param1;
         _callBack = param2;
         initialize();
      }
      
      private function initialize() : void
      {
         _characterFrames = new DictionaryData();
         textureSynthesis();
         if(_callBack != null)
         {
            _callBack(this);
         }
      }
      
      private function textureSynthesis() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:Vector.<SceneCharacterTextureItem> = _textureSet.dataSet;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc1_ = _loc2_[_loc3_];
            addCharacterFrames(_loc1_);
            _loc3_++;
         }
      }
      
      public function parseTexture(param1:SceneCharacterTextureItem) : Array
      {
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc7_:* = null;
         var _loc3_:Array = [];
         var _loc2_:Texture = DDTAssetManager.instance.getTexture(param1.sourceName);
         _loc8_ = 0;
         while(_loc8_ < param1.amount)
         {
            _loc6_ = _loc8_ % param1.rowCellNumber;
            _loc5_ = _loc8_ / param1.rowCellNumber;
            _loc4_ = new Rectangle(param1.cellWitdh * _loc6_,param1.cellHeight * _loc5_,param1.cellWitdh,param1.cellHeight);
            _loc7_ = new SubTexture(_loc2_,_loc4_);
            _loc3_.push(_loc7_);
            _loc8_++;
         }
         return _loc3_;
      }
      
      public function parseTextureAtlas(param1:SceneCharacterTextureItem) : Array
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc4_:Array = [];
         var _loc2_:TextureAtlas = DDTAssetManager.instance.getTextureAtlas(param1.sourceName);
         _loc5_ = 0;
         while(_loc5_ <= param1.amount)
         {
            _loc3_ = _loc2_.getTexture(param1.sourceName + "_" + _loc5_);
            if(_loc3_)
            {
               _loc4_.push(_loc3_);
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      public function addCharacterFrames(param1:SceneCharacterTextureItem) : void
      {
         var _loc2_:* = null;
         removeCharacterFrames(param1.type);
         if(param1.parseType == 0)
         {
            _loc2_ = parseTexture(param1);
         }
         else if(param1.parseType == 1)
         {
            _loc2_ = parseTextureAtlas(param1);
         }
         _characterFrames.add(param1.type,{
            "frams":_loc2_,
            "sortOrder":param1.sortOrder,
            "w":param1.cellWitdh,
            "h":param1.cellHeight
         });
      }
      
      public function removeCharacterFrames(param1:String) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(_characterFrames.hasKey(param1))
         {
            _loc3_ = _characterFrames[param1].frams;
            while(_loc3_.length)
            {
               _loc2_ = _loc3_.pop() as Texture;
               _loc2_.dispose();
            }
            _characterFrames.remove(param1);
         }
      }
      
      public function get textureSet() : SceneCharacterTextureSet
      {
         return _textureSet;
      }
      
      public function getFramesObject(param1:String) : Object
      {
         return _characterFrames[param1];
      }
      
      public function get characterFrames() : DictionaryData
      {
         return _characterFrames;
      }
      
      public function dispose() : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = _characterFrames;
         for each(var _loc1_ in _characterFrames)
         {
            _loc2_ = _loc1_.frams;
            while(_loc2_.length)
            {
               (_loc2_.pop() as Texture).dispose();
            }
         }
         _characterFrames.clear();
         _characterFrames = null;
         if(_textureSet)
         {
            _textureSet.dispose();
         }
         _textureSet = null;
         _callBack = null;
      }
   }
}
