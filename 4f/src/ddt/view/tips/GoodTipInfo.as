package ddt.view.tips
{
   import ddt.data.goods.ItemTemplateInfo;
   
   public class GoodTipInfo
   {
       
      
      private var _itemInfo:ItemTemplateInfo;
      
      public var typeIsSecond:Boolean = true;
      
      public var isBalanceTip:Boolean;
      
      public var exp:int;
      
      public var upExp:int;
      
      public var beadName:String;
      
      public var latentEnergyItemId:int;
      
      public var suitIcon:Boolean;
      
      public var buyType:int;
      
      public var expireTime:int;
      
      public var ghostLv:int = -1;
      
      public function GoodTipInfo(){super();}
      
      public function get itemInfo() : ItemTemplateInfo{return null;}
      
      public function set itemInfo(param1:ItemTemplateInfo) : void{}
   }
}
