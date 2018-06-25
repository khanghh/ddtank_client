package particleSystem
{
   import flash.display.BitmapData;
   import particleSystem.extensions.PDParticleSystem;
   import starling.textures.Texture;
   
   public class PDParticleSystemWithID extends PDParticleSystem
   {
       
      
      public var ID:String;
      
      public var mconfig:XML;
      
      public var mbitmapdata:BitmapData;
      
      public function PDParticleSystemWithID(id:String, config:XML, $mbitmapdata:BitmapData)
      {
         ID = id;
         mconfig = config;
         mbitmapdata = $mbitmapdata;
         super(config,Texture.fromBitmapData(mbitmapdata));
      }
      
      override public function dispose() : void
      {
         super.dispose();
         mconfig = null;
         mbitmapdata = null;
      }
   }
}
