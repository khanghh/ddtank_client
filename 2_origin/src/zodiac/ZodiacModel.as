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
      
      public function ZodiacModel(zodiacInstance:ZodiacInstance)
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
         var i:int = 0;
         _questCounts = 0;
         for(i = 0; i < questArr.length; )
         {
            if(questArr[i] != 0)
            {
               _questCounts = Number(_questCounts) + 1;
            }
            i++;
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
