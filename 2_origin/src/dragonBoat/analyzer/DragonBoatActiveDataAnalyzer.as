package dragonBoat.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import dragonBoat.data.DragonBoatActiveInfo;
   import dragonBoat.data.DragonBoatAwardInfo;
   
   public class DragonBoatActiveDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _data:DragonBoatActiveInfo;
      
      private var _dataList:Array;
      
      private var _dataListSelf:Array;
      
      private var _dataListOther:Array;
      
      public function DragonBoatActiveDataAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc3_:XML = new XML(param1);
         _data = new DragonBoatActiveInfo();
         _dataList = [];
         _dataListSelf = [];
         _dataListOther = [];
         if(_loc3_.@value == "true")
         {
            _loc4_ = _loc3_..Active;
            _loc5_ = 0;
            if(_loc5_ < _loc4_.length())
            {
               ObjectUtils.copyPorpertiesByXML(_data,_loc4_[_loc5_]);
            }
            _loc4_ = _loc3_..ActiveExp;
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length())
            {
               if(_loc4_[_loc5_].@ActiveID == _data.ActiveID.toString())
               {
                  _dataList.push(int(_loc4_[_loc5_].@Exp));
               }
               _loc5_++;
            }
            _dataList.sort(16);
            _loc4_ = _loc3_..ActiveAward;
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length())
            {
               if(_loc4_[_loc5_].@ActiveID == _data.ActiveID.toString())
               {
                  _loc2_ = new DragonBoatAwardInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc2_,_loc4_[_loc5_]);
                  if(_loc4_[_loc5_].@IsArea == "1")
                  {
                     _dataListSelf.push(_loc2_);
                  }
                  else
                  {
                     _dataListOther.push(_loc2_);
                  }
               }
               _loc5_++;
            }
            _dataListSelf.sortOn("RandID",16);
            _dataListOther.sortOn("RandID",16);
            onAnalyzeComplete();
         }
         else
         {
            message = _loc3_.@message;
            onAnalyzeError();
            onAnalyzeError();
         }
      }
      
      public function get data() : DragonBoatActiveInfo
      {
         return _data;
      }
      
      public function get dataList() : Array
      {
         return _dataList;
      }
      
      public function get dataListSelf() : Array
      {
         return _dataListSelf;
      }
      
      public function get dataListOther() : Array
      {
         return _dataListOther;
      }
   }
}
