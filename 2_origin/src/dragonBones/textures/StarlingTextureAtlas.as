package dragonBones.textures
{
   import dragonBones.§core:dragonBones_internal§._bitmapData;
   import dragonBones.objects.DataParser;
   import flash.display.BitmapData;
   import starling.textures.SubTexture;
   import starling.textures.Texture;
   import starling.textures.TextureAtlas;
   
   public class StarlingTextureAtlas extends TextureAtlas implements ITextureAtlas
   {
       
      
      var _bitmapData:BitmapData;
      
      protected var _subTextureDic:Object;
      
      protected var _isDifferentConfig:Boolean;
      
      protected var _scale:Number;
      
      protected var _name:String;
      
      public function StarlingTextureAtlas(texture:Texture, textureAtlasRawData:Object, isDifferentConfig:Boolean = false)
      {
         super(texture,null);
         if(texture)
         {
            _scale = texture.scale;
            _isDifferentConfig = isDifferentConfig;
         }
         _subTextureDic = {};
         parseData(textureAtlasRawData);
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var _loc3_:int = 0;
         var _loc2_:* = _subTextureDic;
         for each(var subTexture in _subTextureDic)
         {
            subTexture.dispose();
         }
         _subTextureDic = null;
         if(_bitmapData)
         {
            _bitmapData.dispose();
         }
         _bitmapData = null;
      }
      
      override public function getTexture(name:String) : Texture
      {
         var texture:Texture = _subTextureDic[name];
         if(!texture)
         {
            texture = super.getTexture(name);
            if(texture)
            {
               _subTextureDic[name] = texture;
            }
         }
         return texture;
      }
      
      protected function parseData(textureAtlasRawData:Object) : void
      {
         var textureData:* = null;
         var textureAtlasData:Object = DataParser.parseTextureAtlasData(textureAtlasRawData,!!_isDifferentConfig?_scale:1);
         _name = textureAtlasData.__name;
         delete textureAtlasData.__name;
         var _loc6_:int = 0;
         var _loc5_:* = textureAtlasData;
         for(var subTextureName in textureAtlasData)
         {
            textureData = textureAtlasData[subTextureName];
            this.addRegion(subTextureName,textureData.region,textureData.frame);
         }
      }
   }
}
