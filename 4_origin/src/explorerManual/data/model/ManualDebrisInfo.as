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
      
      public function set JampsCurrency(param1:int) : void
      {
         _jampsCurrency = param1;
      }
      
      public function get Describe() : String
      {
         return _describe;
      }
      
      public function set Describe(param1:String) : void
      {
         _describe = param1;
      }
      
      public function get ImagePath() : String
      {
         return _imagePath;
      }
      
      public function set ImagePath(param1:String) : void
      {
         _imagePath = param1;
      }
      
      public function get Sort() : int
      {
         return _sort;
      }
      
      public function set Sort(param1:int) : void
      {
         _sort = param1;
      }
      
      public function get PageID() : int
      {
         return _pageID;
      }
      
      public function set PageID(param1:int) : void
      {
         _pageID = param1;
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
