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
      
      public function set Sort(value:int) : void
      {
         _sort = value;
      }
      
      public function get Describe() : String
      {
         return _describe;
      }
      
      public function set Describe(value:String) : void
      {
         _describe = value;
      }
      
      public function get Name() : String
      {
         return _name;
      }
      
      public function set Name(value:String) : void
      {
         _name = value;
      }
      
      public function get ID() : int
      {
         return _ID;
      }
      
      public function set ID(value:int) : void
      {
         _ID = value;
      }
   }
}
