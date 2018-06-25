package totem.data
{
   public class TotemUpGradDataVo
   {
       
      
      private var _types:int;
      
      private var _templateId:int;
      
      private var _grades:int;
      
      private var _data:int;
      
      private var _templateName:String;
      
      private var _itemTempId1:int;
      
      private var _param1:int;
      
      private var _itemTempId2:int;
      
      private var _param2:int;
      
      public function TotemUpGradDataVo()
      {
         super();
      }
      
      public function get param2() : int
      {
         return _param2;
      }
      
      public function set param2(value:int) : void
      {
         _param2 = value;
      }
      
      public function get itemTempId2() : int
      {
         return _itemTempId2;
      }
      
      public function set itemTempId2(value:int) : void
      {
         _itemTempId2 = value;
      }
      
      public function get param1() : int
      {
         return _param1;
      }
      
      public function set param1(value:int) : void
      {
         _param1 = value;
      }
      
      public function get itemTempId1() : int
      {
         return _itemTempId1;
      }
      
      public function set itemTempId1(value:int) : void
      {
         _itemTempId1 = value;
      }
      
      public function get templateName() : String
      {
         return _templateName;
      }
      
      public function set templateName(value:String) : void
      {
         _templateName = value;
      }
      
      public function get data() : int
      {
         return _data;
      }
      
      public function set data(value:int) : void
      {
         _data = value;
      }
      
      public function get grades() : int
      {
         return _grades;
      }
      
      public function set grades(value:int) : void
      {
         _grades = value;
      }
      
      public function get templateId() : int
      {
         return _templateId;
      }
      
      public function set templateId(value:int) : void
      {
         _templateId = value;
      }
      
      public function get types() : int
      {
         return _types;
      }
      
      public function set types(value:int) : void
      {
         _types = value;
      }
   }
}
