package ddt.view.pageSelector
{
   public class PageSelectorFactory
   {
      
      public static const NORMAL:String = "normal";
      
      private static var instance:PageSelectorFactory;
       
      
      public function PageSelectorFactory(single:inner)
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
      
      public function getPageSelector(type:String) : PageSelector
      {
         var _normal:* = null;
         var _loc3_:* = type;
         if("normal" !== _loc3_)
         {
            return null;
         }
         _normal = new PageSelector();
         _normal.setLeftBtn("ddt.pageSelector.leftBtn");
         _normal.setRightBtn("ddt.pageSelector.rightBtn");
         _normal.setNumBG("asset.pageSelector.numBG");
         _normal.setPageNumber("ddt.pageSelector.numberTxt");
         return _normal;
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
