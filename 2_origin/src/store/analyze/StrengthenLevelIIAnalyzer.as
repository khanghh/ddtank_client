package store.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.store.StrengthenLevelII;
   import flash.utils.Dictionary;
   
   public class StrengthenLevelIIAnalyzer extends DataAnalyzer
   {
       
      
      public var LevelItems1:Dictionary;
      
      public var LevelItems2:Dictionary;
      
      public var LevelItems3:Dictionary;
      
      public var LevelItems4:Dictionary;
      
      public var SucceedRate:int;
      
      private var _xml:XML;
      
      public function StrengthenLevelIIAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         _xml = new XML(param1);
         LevelItems1 = new Dictionary(true);
         LevelItems2 = new Dictionary(true);
         LevelItems3 = new Dictionary(true);
         LevelItems4 = new Dictionary(true);
         var _loc2_:XMLList = _xml.Item;
         if(_xml.@value == "true")
         {
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length())
            {
               _loc3_ = new StrengthenLevelII();
               ObjectUtils.copyPorpertiesByXML(_loc3_,_loc2_[_loc4_]);
               SucceedRate = _loc3_.DamagePlusRate;
               LevelItems1[_loc3_.StrengthenLevel] = _loc3_.Rock;
               LevelItems2[_loc3_.StrengthenLevel] = _loc3_.Rock1;
               LevelItems3[_loc3_.StrengthenLevel] = _loc3_.Rock2;
               LevelItems4[_loc3_.StrengthenLevel] = _loc3_.Rock3;
               _loc4_++;
            }
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
