package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BallInfo;
   
   public class BallInfoAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Vector.<BallInfo>;
      
      public function BallInfoAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc2_:XML = new XML(param1);
         list = new Vector.<BallInfo>();
         if(_loc2_.@value == "true")
         {
            _loc3_ = _loc2_..Item;
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length())
            {
               _loc4_ = new BallInfo();
               ObjectUtils.copyPorpertiesByXML(_loc4_,_loc3_[_loc5_]);
               _loc4_.blastOutID = _loc3_[_loc5_].@BombPartical;
               _loc4_.craterID = _loc3_[_loc5_].@Crater;
               _loc4_.FlyingPartical = _loc3_[_loc5_].@FlyingPartical;
               list.push(_loc4_);
               _loc5_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc2_.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
   }
}
