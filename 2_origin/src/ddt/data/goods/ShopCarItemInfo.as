package ddt.data.goods
{
   import flash.events.Event;
   
   public class ShopCarItemInfo extends ShopItemInfo
   {
       
      
      private var _currentBuyType:int = 1;
      
      private var _color:String = "";
      
      public var dressing:Boolean;
      
      public var ModelSex:Boolean;
      
      public var colorValue:String = "";
      
      public var place:int;
      
      public var skin:String = "";
      
      public function ShopCarItemInfo(goodsID:int, templateID:int, CategoryID:int = 0)
      {
         super(goodsID,templateID);
         currentBuyType = 1;
         if(CategoryID == 14)
         {
            currentBuyType = 2;
         }
         dressing = false;
      }
      
      public function set Property8(value:String) : void
      {
         var i:int = 0;
         super.TemplateInfo.Property8 = value;
         for(i = 0; i < value.length - 1; )
         {
            _color = _color + "|";
            i++;
         }
      }
      
      public function get Property8() : String
      {
         return super.TemplateInfo.Property8;
      }
      
      public function get CategoryID() : int
      {
         return TemplateInfo.CategoryID;
      }
      
      public function get Color() : String
      {
         return _color;
      }
      
      public function set Color(value:String) : void
      {
         if(_color != value)
         {
            _color = value;
            dispatchEvent(new Event("change"));
         }
      }
      
      public function set currentBuyType(value:int) : void
      {
         _currentBuyType = value;
         dispatchEvent(new Event("change"));
      }
      
      public function get currentBuyType() : int
      {
         return _currentBuyType;
      }
      
      public function getCurrentPrice() : ItemPrice
      {
         return getItemPrice(_currentBuyType);
      }
   }
}
