package starling.scene.hall
{
   public class SceneMapGridData
   {
       
      
      public var mapId:int;
      
      public var numX:int;
      
      public var numY:int;
      
      private var _gridsType:String;
      
      public var gridsTypeArrArr:Array;
      
      public var bgImageW:int;
      
      public var bgImageH:int;
      
      public var cellW:int;
      
      public var cellH:int;
      
      public function SceneMapGridData()
      {
         super();
      }
      
      public function get gridsType() : String
      {
         return _gridsType;
      }
      
      public function set gridsType(value:String) : void
      {
         _gridsType = value;
         gridsTypeArrArr = JSON.parse(value) as Array;
      }
   }
}
