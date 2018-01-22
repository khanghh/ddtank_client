package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import store.forge.wishBead.WishChangeInfo;
   
   public class WishInfoAnalyzer extends DataAnalyzer
   {
       
      
      public var _wishChangeInfo:Vector.<WishChangeInfo>;
      
      public function WishInfoAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:XML = new XML(param1);
         var _loc2_:XMLList = _loc3_..item;
         _wishChangeInfo = new Vector.<WishChangeInfo>();
         if(_loc3_.@value == "true")
         {
            _loc5_ = 0;
            while(_loc5_ < _loc2_.length())
            {
               _loc4_ = new WishChangeInfo();
               ObjectUtils.copyPorpertiesByXML(_loc4_,_loc2_[_loc5_]);
               _wishChangeInfo.push(_loc4_);
               _loc5_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc3_.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
   }
}
