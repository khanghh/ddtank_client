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
      
      public function ZodiacModel(param1:ZodiacInstance){super();}
      
      public static function get instance() : ZodiacModel{return null;}
      
      public function get questCounts() : int{return 0;}
   }
}

class ZodiacInstance
{
    
   
   function ZodiacInstance(){super();}
}
