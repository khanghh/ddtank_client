package BraveDoor.data
{
   import flash.events.EventDispatcher;
   
   public class BraveDoorDuplicateInfo extends EventDispatcher
   {
       
      
      private var _mapUrl:String;
      
      private var _mapWidth:int;
      
      private var _mapHeight:int;
      
      private var _mapX:int;
      
      private var _mapY:int;
      
      private var _page:int;
      
      private var _duplicateInfo:Vector.<DuplicateInfo> = null;
      
      public function BraveDoorDuplicateInfo()
      {
         super();
         _duplicateInfo = new Vector.<DuplicateInfo>();
      }
      
      public function get duplicateInfo() : Vector.<DuplicateInfo>
      {
         return _duplicateInfo;
      }
      
      public function addDuplicateInfo(param1:DuplicateInfo) : void
      {
         _duplicateInfo.push(param1);
      }
      
      public function get page() : int
      {
         return _page;
      }
      
      public function set page(param1:int) : void
      {
         _page = param1;
      }
      
      public function get mapY() : int
      {
         return _mapY;
      }
      
      public function set mapY(param1:int) : void
      {
         _mapY = param1;
      }
      
      public function get mapX() : int
      {
         return _mapX;
      }
      
      public function set mapX(param1:int) : void
      {
         _mapX = param1;
      }
      
      public function get mapHeight() : int
      {
         return _mapHeight;
      }
      
      public function set mapHeight(param1:int) : void
      {
         _mapHeight = param1;
      }
      
      public function get mapWidth() : int
      {
         return _mapWidth;
      }
      
      public function set mapWidth(param1:int) : void
      {
         _mapWidth = param1;
      }
      
      public function get mapUrl() : String
      {
         return _mapUrl;
      }
      
      public function set mapUrl(param1:String) : void
      {
         _mapUrl = param1;
      }
   }
}
