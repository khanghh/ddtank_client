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
      
      public function WinningLogItemInfo($TemplateID:int = 0)
      {
         super();
         TemplateID = $TemplateID;
      }
      
      public function get TemplateInfo() : ItemTemplateInfo
      {
         if(_templateInfo == null)
         {
            return ItemManager.Instance.getTemplateById(this.TemplateID);
         }
         return _templateInfo;
      }
      
      public function get logNameArr() : Array
      {
         return _logNameArr;
      }
      
      public function set logNameArr(value:Array) : void
      {
         _logNameArr = value;
      }
   }
}
