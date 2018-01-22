package road7th.data
{
   public class StringObject
   {
       
      
      private var _data:String;
      
      public function StringObject(param1:String = "")
      {
         super();
         _data = param1;
      }
      
      public function get isBoolean() : Boolean
      {
         var _loc1_:String = _data.toLowerCase();
         return _data == "true" || _data == "True" || _data == "False" || _data == "false";
      }
      
      public function get isInt() : Boolean
      {
         var _loc1_:RegExp = /^-?\d+$/;
         return _loc1_.test(_data);
      }
      
      public function get getData() : String
      {
         return _data;
      }
      
      public function getBoolean() : Boolean
      {
         if("true" == _data || "True" == _data)
         {
            return true;
         }
         if("false" == _data || "False" == _data)
         {
            return false;
         }
         if("" == _data)
         {
            return false;
         }
         return true;
      }
      
      public function getInt() : int
      {
         return int(_data);
      }
      
      public function getNumber() : Number
      {
         return Number(_data);
      }
   }
}
