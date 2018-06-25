package explorerManual.data.model
{
   public class ManualDebrisInfo
   {
       
      
      private var _ID:int;
      
      private var _pageID:int;
      
      private var _sort:int;
      
      private var _imagePath:String;
      
      private var _describe:String;
      
      private var _jampsCurrency:int;
      
      public function ManualDebrisInfo()
      {
         super();
      }
      
      public function get JampsCurrency() : int
      {
         return _jampsCurrency;
      }
      
      public function set JampsCurrency(value:int) : void
      {
         _jampsCurrency = value;
      }
      
      public function get Describe() : String
      {
         return _describe;
      }
      
      public function set Describe(value:String) : void
      {
         _describe = value;
      }
      
      public function get ImagePath() : String
      {
         return _imagePath;
      }
      
      public function set ImagePath(value:String) : void
      {
         _imagePath = value;
      }
      
      public function get Sort() : int
      {
         return _sort;
      }
      
      public function set Sort(value:int) : void
      {
         _sort = value;
      }
      
      public function get PageID() : int
      {
         return _pageID;
      }
      
      public function set PageID(value:int) : void
      {
         _pageID = value;
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
