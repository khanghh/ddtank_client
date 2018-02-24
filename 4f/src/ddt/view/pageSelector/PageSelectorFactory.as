package ddt.view.pageSelector
{
   public class PageSelectorFactory
   {
      
      public static const NORMAL:String = "normal";
      
      private static var instance:PageSelectorFactory;
       
      
      public function PageSelectorFactory(param1:inner){super();}
      
      public static function getInstance() : PageSelectorFactory{return null;}
      
      public function getPageSelector(param1:String) : PageSelector{return null;}
   }
}

class inner
{
    
   
   function inner(){super();}
}
