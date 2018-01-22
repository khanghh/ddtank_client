package tofflist.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.describeType;
   import tofflist.data.TofflistConsortiaData;
   import tofflist.data.TofflistConsortiaInfo;
   import tofflist.data.TofflistListData;
   import tofflist.data.TofflistPlayerInfo;
   
   public class TofflistListAnalyzer extends DataAnalyzer
   {
       
      
      public var data:TofflistListData;
      
      private var _xml:XML;
      
      public function TofflistListAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc7_:* = null;
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc9_:int = 0;
         var _loc8_:* = null;
         var _loc6_:* = null;
         var _loc3_:* = null;
         _xml = new XML(param1);
         var _loc5_:Array = [];
         this.data = new TofflistListData();
         this.data.lastUpdateTime = _xml.@date;
         if(_xml.@value == "true")
         {
            _loc7_ = XML(_xml)..Item;
            _loc2_ = new TofflistPlayerInfo();
            _loc4_ = describeType(_loc2_);
            _loc9_ = 0;
            while(_loc9_ < _loc7_.length())
            {
               _loc8_ = new TofflistConsortiaData();
               _loc6_ = new TofflistConsortiaInfo();
               ObjectUtils.copyPorpertiesByXML(_loc6_,_loc7_[_loc9_]);
               _loc8_.consortiaInfo = _loc6_;
               if(_loc7_[_loc9_].children().length() > 0)
               {
                  _loc3_ = new TofflistPlayerInfo();
                  _loc3_.beginChanges();
                  ObjectUtils.copyPorpertiesByXML(_loc3_,_loc7_[_loc9_].Item[0]);
                  _loc3_.commitChanges();
                  _loc8_.playerInfo = _loc3_;
                  _loc5_.push(_loc8_);
               }
               _loc9_++;
            }
            this.data.list = _loc5_;
            onAnalyzeComplete();
         }
         else
         {
            message = _xml.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
   }
}
