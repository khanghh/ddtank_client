package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import flash.utils.Dictionary;
   
   public class WeaponBallInfoAnalyze extends DataAnalyzer
   {
       
      
      public var bombs:Dictionary;
      
      public function WeaponBallInfoAnalyze(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc8_:* = null;
         var _loc10_:int = 0;
         var _loc6_:* = null;
         var _loc9_:* = null;
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc7_:XML = new XML(param1);
         bombs = new Dictionary();
         if(_loc7_.@value == "true")
         {
            _loc8_ = _loc7_..Item;
            _loc10_ = 0;
            while(_loc10_ < _loc8_.length())
            {
               _loc6_ = _loc8_[_loc10_].attributes();
               _loc9_ = [];
               var _loc14_:int = 0;
               var _loc13_:* = _loc6_;
               for each(var _loc3_ in _loc6_)
               {
                  _loc2_ = _loc3_.name().toString();
                  try
                  {
                     if(_loc2_ == "TemplateID")
                     {
                        _loc5_ = _loc3_;
                     }
                     else
                     {
                        _loc4_ = _loc3_;
                        _loc9_.push(_loc4_);
                     }
                  }
                  catch(e:Error)
                  {
                     trace("错误:",e.message);
                     continue;
                  }
               }
               bombs[_loc5_] = _loc9_;
               _loc10_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc7_.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
   }
}
