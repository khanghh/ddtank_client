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
      
      public function ServerListAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc2_:XML = new XML(param1);
         if(_loc2_.@value == "true")
         {
            agentId = _loc2_.@agentId;
            zoneName = _loc2_.@AreaName;
            message = _loc2_.@message;
            _loc3_ = _loc2_..Item;
            list = new Vector.<ServerInfo>();
            if(_loc3_.length() > 0)
            {
               _loc5_ = 0;
               while(_loc5_ < _loc3_.length())
               {
                  _loc4_ = new ServerInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc4_,_loc3_[_loc5_]);
                  list.push(_loc4_);
                  _loc5_++;
               }
               onAnalyzeComplete();
            }
         }
         else
         {
            message = _loc2_.@message;
            onAnalyzeError();
         }
      }
   }
}
