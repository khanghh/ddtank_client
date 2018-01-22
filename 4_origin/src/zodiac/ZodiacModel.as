package zodiac
{
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   
   public class ZodiacModel extends EventDispatcher
   {
      
      private static var _instance:ZodiacModel;
       
      
      public var questArr:Array;
      
      public var indexTypeArr:Dictionary;
      
      public var awardRecord:int;
      
      public var maxCounts:int;
      
      public var finshedCounts:int;
      
      public var isOpen:Boolean;
      
      public var newIndex:int;
      
      public var index:int = 0;
      
      private var _questCounts:int = 0;
      
      public function ZodiacModel(param1:ZodiacInstance)
      {
         super();
         indexTypeArr = new Dictionary();
      }
      
      public static function get instance() : ZodiacModel
      {
         if(_instance == null)
         {
            _instance = new ZodiacModel(new ZodiacInstance());
         }
         return _instance;
      }
      
      public function get questCounts() : int
      {
         var _loc1_:int = 0;
         _questCounts = 0;
         _loc1_ = 0;
         while(_loc1_ < questArr.length)
         {
            if(questArr[_loc1_] != 0)
            {
               _questCounts = Number(_questCounts) + 1;
            }
            _loc1_++;
         }
         return _questCounts;
      }
   }
}

class ZodiacInstance
{
    
   
   function ZodiacInstance()
   {
      super();
   }
}
