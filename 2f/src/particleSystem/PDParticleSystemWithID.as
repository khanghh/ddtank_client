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
      
      public function PDParticleSystemWithID(param1:String, param2:XML, param3:BitmapData){super(null,null);}
      
      override public function dispose() : void{}
   }
}
