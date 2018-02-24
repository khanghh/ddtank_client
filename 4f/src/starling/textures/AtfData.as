package starling.textures
{
   import flash.utils.ByteArray;
   
   public class AtfData
   {
       
      
      private var mFormat:String;
      
      private var mWidth:int;
      
      private var mHeight:int;
      
      private var mNumTextures:int;
      
      private var mIsCubeMap:Boolean;
      
      private var mData:ByteArray;
      
      public function AtfData(param1:ByteArray){super();}
      
      public static function isAtfData(param1:ByteArray) : Boolean{return false;}
      
      public function get format() : String{return null;}
      
      public function get width() : int{return 0;}
      
      public function get height() : int{return 0;}
      
      public function get numTextures() : int{return 0;}
      
      public function get isCubeMap() : Boolean{return false;}
      
      public function get data() : ByteArray{return null;}
   }
}
