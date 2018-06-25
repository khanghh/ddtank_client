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
      
      public function addDuplicateInfo(info:DuplicateInfo) : void
      {
         _duplicateInfo.push(info);
      }
      
      public function get page() : int
      {
         return _page;
      }
      
      public function set page(value:int) : void
      {
         _page = value;
      }
      
      public function get mapY() : int
      {
         return _mapY;
      }
      
      public function set mapY(value:int) : void
      {
         _mapY = value;
      }
      
      public function get mapX() : int
      {
         return _mapX;
      }
      
      public function set mapX(value:int) : void
      {
         _mapX = value;
      }
      
      public function get mapHeight() : int
      {
         return _mapHeight;
      }
      
      public function set mapHeight(value:int) : void
      {
         _mapHeight = value;
      }
      
      public function get mapWidth() : int
      {
         return _mapWidth;
      }
      
      public function set mapWidth(value:int) : void
      {
         _mapWidth = value;
      }
      
      public function get mapUrl() : String
      {
         return _mapUrl;
      }
      
      public function set mapUrl(value:String) : void
      {
         _mapUrl = value;
      }
   }
}
