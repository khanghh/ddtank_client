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
      
      public function StarlingTextureAtlas(param1:Texture, param2:Object, param3:Boolean = false)
      {
         super(param1,null);
         if(param1)
         {
            _scale = param1.scale;
            _isDifferentConfig = param3;
         }
         _subTextureDic = {};
         parseData(param2);
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
         for each(var _loc1_ in _subTextureDic)
         {
            _loc1_.dispose();
         }
         _subTextureDic = null;
         if(_bitmapData)
         {
            _bitmapData.dispose();
         }
         _bitmapData = null;
      }
      
      override public function getTexture(param1:String) : Texture
      {
         var _loc2_:Texture = _subTextureDic[param1];
         if(!_loc2_)
         {
            _loc2_ = super.getTexture(param1);
            if(_loc2_)
            {
               _subTextureDic[param1] = _loc2_;
            }
         }
         return _loc2_;
      }
      
      protected function parseData(param1:Object) : void
      {
         var _loc2_:* = null;
         var _loc4_:Object = DataParser.parseTextureAtlasData(param1,!!_isDifferentConfig?_scale:1);
         _name = _loc4_.__name;
         delete _loc4_.__name;
         var _loc6_:int = 0;
         var _loc5_:* = _loc4_;
         for(var _loc3_ in _loc4_)
         {
            _loc2_ = _loc4_[_loc3_];
            this.addRegion(_loc3_,_loc2_.region,_loc2_.frame);
         }
      }
   }
}
