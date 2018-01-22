package ddt.view.pageSelector
{
   public class PageSelectorFactory
   {
      
      public static const NORMAL:String = "normal";
      
      private static var instance:PageSelectorFactory;
       
      
      public function PageSelectorFactory(param1:inner)
      {
         super();
      }
      
      public static function getInstance() : PageSelectorFactory
      {
         if(!instance)
         {
            instance = new PageSelectorFactory(new inner());
         }
         return instance;
      }
      
      public function getPageSelector(param1:String) : PageSelector
      {
         var _loc2_:* = null;
         var _loc3_:* = param1;
         if("normal" !== _loc3_)
         {
            return null;
         }
         _loc2_ = new PageSelector();
         _loc2_.setLeftBtn("ddt.pageSelector.leftBtn");
         _loc2_.setRightBtn("ddt.pageSelector.rightBtn");
         _loc2_.setNumBG("asset.pageSelector.numBG");
         _loc2_.setPageNumber("ddt.pageSelector.numberTxt");
         return _loc2_;
      }
   }
}

class inner
{
    
   
   function inner()
   {
      super();
   }
}
