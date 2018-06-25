package particleSystem.loader
{
   import deng.fzip.FZip;
   
   public class ParticleFZip extends FZip
   {
       
      
      public var ID:String;
      
      public function ParticleFZip(filenameEncoding:String = "utf-8")
      {
         super(filenameEncoding);
      }
   }
}
