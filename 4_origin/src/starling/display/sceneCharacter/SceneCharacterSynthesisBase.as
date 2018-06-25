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
      
      public function SceneCharacterSynthesisBase(textureSet:SceneCharacterTextureSet, callBack:Function)
      {
         super();
         _textureSet = textureSet;
         _callBack = callBack;
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
         var i:int = 0;
         var item:* = null;
         var list:Vector.<SceneCharacterTextureItem> = _textureSet.dataSet;
         for(i = 0; i < list.length; )
         {
            item = list[i];
            addCharacterFrames(item);
            i++;
         }
      }
      
      public function parseTexture(data:SceneCharacterTextureItem) : Array
      {
         var i:int = 0;
         var lie:int = 0;
         var hang:int = 0;
         var rect:* = null;
         var subTexture:* = null;
         var list:Array = [];
         var texture:Texture = DDTAssetManager.instance.getTexture(data.sourceName);
         for(i = 0; i < data.amount; )
         {
            lie = i % data.rowCellNumber;
            hang = i / data.rowCellNumber;
            rect = new Rectangle(data.cellWitdh * lie,data.cellHeight * hang,data.cellWitdh,data.cellHeight);
            subTexture = new SubTexture(texture,rect);
            list.push(subTexture);
            i++;
         }
         return list;
      }
      
      public function parseTextureAtlas(data:SceneCharacterTextureItem) : Array
      {
         var i:int = 0;
         var texture:* = null;
         var list:Array = [];
         var textureAtlas:TextureAtlas = DDTAssetManager.instance.getTextureAtlas(data.sourceName);
         for(i = 0; i <= data.amount; )
         {
            texture = textureAtlas.getTexture(data.sourceName + "_" + i);
            if(texture)
            {
               list.push(texture);
            }
            i++;
         }
         return list;
      }
      
      public function addCharacterFrames(item:SceneCharacterTextureItem) : void
      {
         var frams:* = null;
         removeCharacterFrames(item.type);
         if(item.parseType == 0)
         {
            frams = parseTexture(item);
         }
         else if(item.parseType == 1)
         {
            frams = parseTextureAtlas(item);
         }
         _characterFrames.add(item.type,{
            "frams":frams,
            "sortOrder":item.sortOrder,
            "w":item.cellWitdh,
            "h":item.cellHeight
         });
      }
      
      public function removeCharacterFrames(type:String) : void
      {
         var list:* = null;
         var texture:* = null;
         if(_characterFrames.hasKey(type))
         {
            list = _characterFrames[type].frams;
            while(list.length)
            {
               texture = list.pop() as Texture;
               texture.dispose();
            }
            _characterFrames.remove(type);
         }
      }
      
      public function get textureSet() : SceneCharacterTextureSet
      {
         return _textureSet;
      }
      
      public function getFramesObject(type:String) : Object
      {
         return _characterFrames[type];
      }
      
      public function get characterFrames() : DictionaryData
      {
         return _characterFrames;
      }
      
      public function dispose() : void
      {
         var list:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = _characterFrames;
         for each(var item in _characterFrames)
         {
            list = item.frams;
            while(list.length)
            {
               (list.pop() as Texture).dispose();
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
