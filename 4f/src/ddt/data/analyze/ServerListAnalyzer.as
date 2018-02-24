package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.ServerInfo;
   
   public class ServerListAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Vector.<ServerInfo>;
      
      public var agentId:int;
      
      public var zoneName:String;
      
      public function ServerListAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
   }
}
