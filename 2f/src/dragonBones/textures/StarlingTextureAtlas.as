package dragonBones.textures
{
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
      
      public function StarlingTextureAtlas(param1:Texture, param2:Object, param3:Boolean = false){super(null,null);}
      
      public function get name() : String{return null;}
      
      override public function dispose() : void{}
      
      override public function getTexture(param1:String) : Texture{return null;}
      
      protected function parseData(param1:Object) : void{}
   }
}
