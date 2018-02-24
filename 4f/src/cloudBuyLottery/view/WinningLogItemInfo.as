package cloudBuyLottery.view
{
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import flash.events.EventDispatcher;
   
   public class WinningLogItemInfo extends EventDispatcher
   {
       
      
      public var TemplateID:int;
      
      private var _templateInfo:ItemTemplateInfo;
      
      private var _logNameArr:Array;
      
      public var nickName:String;
      
      public var count:int;
      
      public var validate:int;
      
      public var property:Array;
      
      public function WinningLogItemInfo(param1:int = 0){super();}
      
      public function get TemplateInfo() : ItemTemplateInfo{return null;}
      
      public function get logNameArr() : Array{return null;}
      
      public function set logNameArr(param1:Array) : void{}
   }
}
