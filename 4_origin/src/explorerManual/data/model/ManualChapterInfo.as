package explorerManual.data.model
{
   public class ManualChapterInfo
   {
       
      
      private var _ID:int;
      
      private var _name:String;
      
      private var _describe:String;
      
      private var _sort:int;
      
      public function ManualChapterInfo()
      {
         super();
      }
      
      public function get Sort() : int
      {
         return _sort;
      }
      
      public function set Sort(param1:int) : void
      {
         _sort = param1;
      }
      
      public function get Describe() : String
      {
         return _describe;
      }
      
      public function set Describe(param1:String) : void
      {
         _describe = param1;
      }
      
      public function get Name() : String
      {
         return _name;
      }
      
      public function set Name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get ID() : int
      {
         return _ID;
      }
      
      public function set ID(param1:int) : void
      {
         _ID = param1;
      }
   }
}
