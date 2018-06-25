package particleSystem
{
   import com.pickgliss.loader.DataAnalyzer;
   import flash.utils.Dictionary;
   
   public class EmitterInfoAnalyzer extends DataAnalyzer
   {
       
      
      public var emitters:Dictionary;
      
      public function EmitterInfoAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var emitterInfo:* = null;
         var particleIds:* = null;
         var xml:XML = new XML(data);
         emitters = new Dictionary();
         var xml_emitter:XMLList = xml..emitter;
         var _loc8_:int = 0;
         var _loc7_:* = xml_emitter;
         for each(var x in xml_emitter)
         {
            emitterInfo = new EmitterInfo();
            emitterInfo.id = x.@id;
            emitterInfo.name = x.@name;
            particleIds = String(x.@particles).split(",");
            emitterInfo.particleIds = particleIds;
            emitters[emitterInfo.id] = emitterInfo;
         }
         onAnalyzeComplete();
      }
   }
}
